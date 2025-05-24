import dotenv from 'dotenv';
import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import 'express-async-errors';

dotenv.config();
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => console.log('Conectado a MongoDB Atlas'))
  .catch(error => console.error('Error en conexión:', error));

// Verificar que MONGODB_URI está definida
if (!process.env.MONGODB_URI) {
  console.error('🚨 ERROR: La variable de entorno MONGODB_URI no está definida');
  process.exit(1);
}

// Importar rutas desde la nueva ubicación
import authRoutes from './core/api/auth.js';
import doctorsRouter from './core/api/doctors.js';
import patientsRouter from './core/api/patients.js';

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Usar las rutas con la nueva ubicación
app.use('/api/auth', authRoutes);
app.use('/api/doctors', doctorsRouter);
app.use('/api/patients', patientsRouter);

// 🔍 Depuración: Imprimir el valor de la URI
console.log('Valor de MONGODB_URI:', process.env.MONGODB_URI);
console.log('Usando puerto:', process.env.PORT);
// Conexión a MongoDB con manejo de errores
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log(' Conectado a MongoDB'))
.catch((err) => {
  console.error(' Error al conectar a MongoDB:', err);
  process.exit(1);
});

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('✅ Servidor Meetical Backend funcionando');
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Servidor corriendo en el puerto 3000');
});

