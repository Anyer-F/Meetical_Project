// core/api/doctors.js
import express from 'express';
import Doctor from '../data/models/doctor.js';

const router = express.Router();

// ✅ Registrar nuevo doctor
router.post('/register', async (req, res) => {
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
      notificationsEnabled = true,
      termsAccepted = false,
    } = req.body;

    // Validación básica
    if (!name || !surname || !email || !phone || !gender || !password) {
      return res.status(400).json({ message: 'Faltan campos obligatorios' });
    }

    // Verificar si el email ya está registrado
    const existing = await Doctor.findOne({ email });
    if (existing) {
      return res.status(409).json({ message: 'El correo ya está registrado' });
    }

    // Crear nuevo doctor (la contraseña se encripta automáticamente)
    const nuevoDoctor = new Doctor({
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
      termsAccepted,
    });

    await nuevoDoctor.save();
    res.status(201).json({ message: 'Doctor registrado correctamente' });
  } catch (error) {
    console.error('❌ Error al registrar doctor:', error);
    res.status(500).json({ message: 'Error del servidor' });
  }
});

export default router;



