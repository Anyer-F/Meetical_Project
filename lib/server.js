// server.js

import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import dotenv from 'dotenv';
import 'express-async-errors';

import authRoutes from './core/api/auth.js';
import doctorsRouter from './core/api/doctors.js';
import patientsRouter from './core/api/patients.js';
import appointmentsRouter from './core/api/appointments.js';

// Cargar variables de entorno
dotenv.config();

// Verificar que URI esté definida
if (!process.env.MONGODB_URI) {
  console.error('❌ ERROR: La variable de entorno MONGODB_URI no está definida');
  process.exit(1);
}

// Conexión a MongoDB
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('✅ Conectado a MongoDB Atlas'))
.catch(err => {
  console.error('❌ Error en conexión a MongoDB:', err);
  process.exit(1);
});

// Inicializar app
const app = express();
app.use(cors());
app.use(express.json());

// Rutas API
app.use('/api/auth', authRoutes);
app.use('/api/doctors', doctorsRouter);
app.use('/api/patients', patientsRouter);
app.use('/api/appointments', appointmentsRouter);

// Ruta base de prueba
app.get('/', (req, res) => {
  res.send('✅ Backend Meetical corriendo');
});

// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor corriendo en http://0.0.0.0:${PORT}`);
});


