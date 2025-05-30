import express from 'express';
import bcrypt from 'bcrypt';
import Doctor from '../data/models/doctor.js';
import Patient from '../data/models/patient.js';
import VerificationCode from '../data/models/verificationCode.js';
import nodemailer from 'nodemailer';
import dotenv from 'dotenv';

dotenv.config();

const router = express.Router();

// Configurar transporte SMTP
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

transporter.verify((error) => {
  if (error) {
    console.error('Error SMTP:', error);
  } else {
    console.log('SMTP listo');
  }
});

// ✅ LOGIN
router.post('/login', async (req, res) => {
  const { emailOrPhone, password } = req.body;

  try {
    const user =
      await Doctor.findOne({ email: emailOrPhone }) ||
      await Doctor.findOne({ phone: emailOrPhone }) ||
      await Patient.findOne({ email: emailOrPhone }) ||
      await Patient.findOne({ phone: emailOrPhone });

    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ message: 'Contraseña incorrecta' });
    }

    const userType = user instanceof Doctor ? 'doctor' : 'patient';

    return res.status(200).json({
      userType,
      id: user._id,
      name: user.name,
      email: user.email,
    });
  } catch (error) {
    console.error('❌ Error al iniciar sesión:', error);
    res.status(500).json({ message: 'Error del servidor' });
  }
});

// ✅ Enviar código de verificación
router.post('/send-code', async (req, res) => {
  try {
    const { emailOrPhone } = req.body;
    console.log('Solicitud de código para:', emailOrPhone);

    const user =
      await Doctor.findOne({ email: emailOrPhone }) ||
      await Doctor.findOne({ phone: emailOrPhone }) ||
      await Patient.findOne({ email: emailOrPhone }) ||
      await Patient.findOne({ phone: emailOrPhone });

    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    const code = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000);

    await VerificationCode.findOneAndUpdate(
      { emailOrPhone },
      { code, expiresAt },
      { upsert: true, new: true }
    );

    if (emailOrPhone.includes('@')) {
      await transporter.sendMail({
        from: process.env.EMAIL_USER,
        to: emailOrPhone,
        subject: 'Código de recuperación',
        html: `<p>Tu código es: <strong>${code}</strong></p><p>Expira en 5 minutos.</p>`,
      });
    }

    res.status(200).json({ message: 'Código enviado' });
  } catch (error) {
    console.error('❌ Error al enviar código:', error);
    res.status(500).json({ error: 'Error en el envío' });
  }
});

// ✅ Verificar código
router.post('/verify-code', async (req, res) => {
  try {
    const { emailOrPhone, code } = req.body;
    const record = await VerificationCode.findOne({ emailOrPhone });

    if (!record || record.code !== code) {
      return res.status(400).json({ error: 'Código incorrecto' });
    }

    if (record.expiresAt < new Date()) {
      return res.status(400).json({ error: 'Código expirado' });
    }

    res.status(200).json({ message: 'Código verificado' });
  } catch (error) {
    console.error('❌ Error en verificación:', error);
    res.status(500).json({ error: 'Error interno' });
  }
});

// ✅ Restablecer contraseña
router.post('/reset-password', async (req, res) => {
  try {
    const { emailOrPhone, password } = req.body;

    let user =
      await Doctor.findOne({ email: emailOrPhone }) ||
      await Doctor.findOne({ phone: emailOrPhone }) ||
      await Patient.findOne({ email: emailOrPhone }) ||
      await Patient.findOne({ phone: emailOrPhone });

    if (!user) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    // Encriptar nueva contraseña
    const hashedPassword = await bcrypt.hash(password, 10);
    user.password = hashedPassword;
    await user.save();

    await VerificationCode.deleteOne({ emailOrPhone });

    res.status(200).json({ message: 'Contraseña actualizada' });
  } catch (error) {
    console.error('❌ Error al actualizar contraseña:', error);
    res.status(500).json({ error: 'Error al actualizar' });
  }
});

export default router;



