import mongoose from 'mongoose';

const appointmentSchema = new mongoose.Schema({
  doctorId: { type: mongoose.Schema.Types.ObjectId, ref: 'Doctor', required: true },
  patientId: { type: mongoose.Schema.Types.ObjectId, ref: 'Patient', required: true },
  fecha: { type: String, required: true }, // Usamos string para simplificar comparación
  horaInicio: { type: String, required: true },
  horaFinal: { type: String, required: true },
  descripcionCita: { type: String },
  estado: { type: String, enum: ['pendiente', 'aceptada', 'rechazada'], default: 'pendiente' }
});

const Appointment = mongoose.model('Appointment', appointmentSchema);

export default Appointment;
