import dotenv from 'dotenv';
import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import 'express-async-errors';

import authRoutes from './core/api/auth.js';
import doctorsRouter from './core/api/doctors.js';
import patientsRouter from './core/api/patients.js';

dotenv.config();

const app = express();

// Verificar que la URI esté definida antes de intentar conectar
if (!process.env.MONGODB_URI) {
  console.error('🚨 ERROR: La variable de entorno MONGODB_URI no está definida');
  process.exit(1);
}

// Conexión a MongoDB
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('✅ Conectado a MongoDB Atlas'))
.catch((err) => {
  console.error('❌ Error al conectar a MongoDB:', err);
  process.exit(1);
});

// Middleware
app.use(cors());
app.use(express.json());

// Rutas de la API
app.use('/api/auth', authRoutes);
app.use('/api/doctors', doctorsRouter);
app.use('/api/patients', patientsRouter);

// Ruta raíz para prueba
app.get('/', (req, res) => {
  res.send('✅ Servidor Meetical Backend funcionando');
});

// Puerto
const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor corriendo en el puerto ${PORT}`);
});
