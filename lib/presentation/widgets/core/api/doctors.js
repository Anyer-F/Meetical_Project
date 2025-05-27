import express from 'express';
import mongoose from 'mongoose';

const router = express.Router();

// ✅ Define el esquema del médico (si no lo has importado de otro archivo)
const doctorSchema = new mongoose.Schema({
  name: String,
  surname: String,
  email: String,
  phone: String,
  gender: String,
  notificationsEnabled: Boolean,
  password: String,
});

const Doctor = mongoose.model('Doctor', doctorSchema);

// ✅ Ruta fija para pruebas (puedes eliminarla si ya no la usas)
router.get('/profile', (req, res) => {
  res.json({
    name: "Fabian",
    surname: "Gómez",
    email: "fn.gomez@example.com",
    phone: "50212345678",
    gender: "Masculino"
  });
});

// ✅ Obtener perfil de un médico por ID (desde MongoDB Atlas)
router.get('/:id', async (req, res) => {
  try {
    const doctor = await Doctor.findById(req.params.id).select('-password'); // excluye contraseña

    if (!doctor) {
      return res.status(404).json({ message: 'Médico no encontrado' });
    }

    res.json(doctor);
  } catch (error) {
    console.error('❌ Error al obtener médico:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

export default router;
  