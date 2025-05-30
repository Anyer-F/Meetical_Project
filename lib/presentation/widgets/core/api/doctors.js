import express from 'express';
import mongoose from 'mongoose';
import bcrypt from 'bcrypt';

const router = express.Router();

// Esquema del médico
const doctorSchema = new mongoose.Schema({
  name: { type: String, required: true },
  surname: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  phone: { type: String, required: true },
  gender: { type: String, required: true },
  notificationsEnabled: { type: Boolean, default: true },
  password: { type: String, required: true }, // Contraseña encriptada
}, { timestamps: true });

const Doctor = mongoose.model('Doctor', doctorSchema);

// Ruta de prueba
router.get('/profile', (req, res) => {
  res.json({
    name: "Fabian",
    surname: "Gómez",
    email: "fn.gomez@example.com",
    phone: "50212345678",
    gender: "Masculino"
  });
});

// Obtener médico por ID
router.get('/:id', async (req, res) => {
  try {
    const doctor = await Doctor.findById(req.params.id).select('-password');

    if (!doctor) {
      return res.status(404).json({ message: 'Médico no encontrado' });
    }

    res.json(doctor);
  } catch (error) {
    console.error('❌ Error al obtener médico:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

// Registrar nuevo médico
router.post('/register', async (req, res) => {
  try {
    const { name, surname, email, phone, gender, password } = req.body;

    // Validación básica
    if (!name || !surname || !email || !phone || !gender || !password) {
      return res.status(400).json({ message: 'Faltan campos obligatorios' });
    }

    // Verifica si el correo ya está registrado
    const existingDoctor = await Doctor.findOne({ email });
    if (existingDoctor) {
      return res.status(409).json({ message: 'El correo ya está registrado' });
    }

    // Encriptar la contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    // Crear nuevo médico
    const newDoctor = new Doctor({
      name,
      surname,
      email,
      phone,
      gender,
      password: hashedPassword,
    });

    await newDoctor.save();

    res.status(201).json({ message: 'Médico registrado exitosamente' });
  } catch (error) {
    console.error('❌ Error al registrar médico:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

export default router;





  