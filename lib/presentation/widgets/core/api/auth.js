import express from 'express';
import bcrypt from 'bcrypt';
import Doctor from '../data/models/doctor.js';
import Patient from '../data/models/patient.js';

const router = express.Router();

// ✅ Ruta de prueba
router.get('/ping', (req, res) => {
  res.send('Auth API activa');
});

// ✅ Ruta de inicio de sesión
router.post('/login', async (req, res) => {
  try {
    const { emailOrPhone, password } = req.body;

    if (!emailOrPhone || !password) {
      return res.status(400).json({ message: 'Campos incompletos' });
    }

    // Buscar usuario (doctor o paciente)
    const user =
      (await Doctor.findOne({
        $or: [{ email: emailOrPhone }, { phone: emailOrPhone }],
      })) ||
      (await Patient.findOne({
        $or: [{ email: emailOrPhone }, { phone: emailOrPhone }],
      }));

    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    // Comparar contraseñas
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Contraseña incorrecta' });
    }

    // Determinar tipo de usuario
    const userType = user instanceof Doctor ? 'doctor' : 'patient';

    // Responder con datos
    res.status(200).json({
      message: 'Login exitoso',
      userType,
      name: user.name,
      email: user.email,
      _id: user._id,
    });
  } catch (error) {
    console.error('❌ Error en login:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

export default router;

