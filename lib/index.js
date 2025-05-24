import dotenv from 'detenv';
import cors from 'cors';
dotenv.config();
require('dotenv').config();  // Cargar variables de entorno desde .env

const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const doctorRoutes = require('./core/api/doctors');

const app = express();
app.use(cors());
app.use(express.json());

// Usar URI de MongoDB desde variables de entorno
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('Conectado a MongoDB'))
.catch(err => console.error('Error al conectar a MongoDB:', err));

// Usar puerto desde variable de entorno o 3000 por defecto
const PORT = process.env.PORT || 3000;
console.log(`Using port: ${PORT}`);

app.use('/api/doctors', doctorRoutes);

app.listen(3000, '0.0.0.0', () => {
  console.log('Servidor corriendo en el puerto 3000');
});

