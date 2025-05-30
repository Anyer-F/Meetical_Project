// core/api/patients.js
import express from 'express';
import mongoose from 'mongoose';
import bcrypt from 'bcrypt';

const router = express.Router();

// Esquema del paciente
const patientSchema = new mongoose.Schema({
  name: { type: String, required: true },
  surname: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  phone: { type: String, required: true },
  gender: { type: String, required: true },
  password: { type: String, required: true }, // Encriptada
}, { timestamps: true });

const Patient = mongoose.model('Patient', patientSchema);

// Registrar paciente
router.post('/register', async (req, res) => {
  try {
    const { name, surname, email, phone, gender, password } = req.body;

    if (!name || !surname || !email || !phone || !gender || !password) {
      return res.status(400).json({ message: 'Faltan campos obligatorios' });
    }

    const existing = await Patient.findOne({ email });
    if (existing) {
      return res.status(409).json({ message: 'El correo ya está registrado' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newPatient = new Patient({
      name,
      surname,
      email,
      phone,
      gender,
      password: hashedPassword,
    });

    await newPatient.save();

    res.status(201).json({ message: 'Paciente registrado exitosamente' });
  } catch (error) {
    console.error('❌ Error al registrar paciente:', error);
    res.status(500).json({ message: 'Error del servidor' });
  }
});

export default router;

 