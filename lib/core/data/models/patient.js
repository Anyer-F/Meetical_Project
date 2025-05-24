import mongoose from 'mongoose';

const patientSchema = new mongoose.Schema({
  name: String,
  surname: String,
  email: { type: String, unique: true },
  phone: String,
  birthDate: String,
  gender: String,
  password: String,
  notificationsEnabled: Boolean,
  termsAccepted: Boolean,
});

export default mongoose.model('Patient', patientSchema);
