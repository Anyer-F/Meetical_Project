import express from 'express';
import Doctor from '../data/models/doctor.js';  // Import correcto
import bcrypt from 'bcryptjs';

const router = express.Router();

router.post('/register', async (req, res) => {
  // Logs de debugging agregados aquí
  console.log('📥 Request recibido en /api/doctors/register');
  console.log('📋 Headers:', req.headers);
  console.log('📦 Body:', req.body);
  
  try {
    const {
      name,
      surname,
      email,
      phone,
      birthDate,
      title,
      specialty,
      registerNumber,
      location,
      clinicNumber,
      gender,
      password,
      notificationsEnabled,
      termsAccepted
    } = req.body;

    if (!name || !surname || !email || !password || !gender || !termsAccepted) {
      return res.status(400).json({ message: 'Faltan campos obligatorios' });
    }

    if (await Doctor.findOne({ email })) {
      return res.status(400).json({ message: 'El correo ya está registrado' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newDoctor = new Doctor({
      name,
      surname,
      email,
      phone,
      birthDate,
      title,
      specialty,
      registerNumber,
      location,
      clinicNumber,
      gender,
      password: hashedPassword,
      notificationsEnabled,
      termsAccepted
    });

    await newDoctor.save();

    res.status(201).json({ message: 'Médico registrado correctamente', doctor: newDoctor });
  } catch (error) {
    // Error logging mejorado
    console.error('❌ Error completo:', error);
    res.status(500).json({ 
      message: 'Error interno al registrar médico',
      error: error.message 
    });
    }
});

// Obtener todos los doctores
router.get('/', async (req, res) => {
    try {
        const doctors = await Doctor.find();
        res.json(doctors);
    } catch (error) {
        res.status(500).json({ message: 'Error al obtener la lista de doctores', error: error.message });
    }
});

export default router;