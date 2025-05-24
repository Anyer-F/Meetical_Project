import mongoose from 'mongoose';

const doctorSchema = new mongoose.Schema({
  name: String,
  surname: String,
  email: { type: String, unique: true },
  phone: String,
  birthDate: String,
  title: String,
  specialty: String,
  registerNumber: String,
  location: String,
  clinicNumber: String,
  gender: String,
  password: String,
  notificationsEnabled: Boolean,
  termsAccepted: Boolean,
});

export default mongoose.model('Doctor', doctorSchema);
