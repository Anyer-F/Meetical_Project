import express from 'express';
import Patient from '../data/models/patient.js';
import bcrypt from 'bcryptjs';

const router = express.Router();

// Registro de pacientes
router.post('/register', async (req, res) => {
  try {
    const {
      name,
      surname,
      email,
      phone,
      birthDate,
      gender,
      password,
      notificationsEnabled,
      termsAccepted
    } = req.body;

    // Validar campos obligatorios
    if (!name || !surname || !email || !password || !gender || !termsAccepted) {
      return res.status(400).json({ message: 'Faltan campos obligatorios' });
    }

    // Verificar si ya existe el correo
    if (await Patient.findOne({ email })) {
      return res.status(400).json({ message: 'El correo ya está registrado' });
    }

    // Hashear contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    // Crear nuevo paciente
    const newPatient = new Patient({
      name,
      surname,
      email,
      phone,
      birthDate,
      gender,
      password: hashedPassword,
      notificationsEnabled,
      termsAccepted
    });

    await newPatient.save();

    res.status(201).json({ message: 'Paciente registrado correctamente', patient: newPatient });
  } catch (error) {
    console.error('❌ Error en registro paciente:', error);
    res.status(500).json({ message: 'Error interno al registrar paciente' });
  }
});

export default router;
