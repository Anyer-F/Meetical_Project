import express from 'express';
import Appointment from '../data/models/appointment.js';

const router = express.Router();

// Crear nueva cita
router.post('/', async (req, res) => {
  try {
    const { doctorId, patientId, fecha, horaInicio, horaFinal, descripcionCita } = req.body;

    if (!doctorId || !patientId || !fecha || !horaInicio || !horaFinal) {
      return res.status(400).json({ message: 'Faltan datos obligatorios' });
    }

    // Validar solapamiento de citas
    const existeConflicto = await Appointment.findOne({
      doctorId,
      fecha,
      $or: [
        { horaInicio: { $lt: horaFinal }, horaFinal: { $gt: horaInicio } }
      ]
    });

    if (existeConflicto) {
      return res.status(409).json({ message: 'El horario ya está ocupado' });
    }

    const nuevaCita = new Appointment({
      doctorId,
      patientId,
      fecha,
      horaInicio,
      horaFinal,
      descripcionCita,
      estado: 'pendiente' // pendiente, aceptada o rechazada
    });

    await nuevaCita.save();

    res.status(201).json({ message: 'Cita registrada con éxito', cita: nuevaCita });
  } catch (error) {
    console.error('❌ Error al registrar cita:', error);
    res.status(500).json({ message: 'Error interno', error: error.message });
  }
});

export default router;
