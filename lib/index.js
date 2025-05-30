// Cargar módulos necesarios
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config(); // Cargar variables desde .env

// Inicializar app
const app = express();
app.use(cors());
app.use(express.json());

// Verificar URI
if (!process.env.MONGODB_URI) {
  console.error('❌ ERROR: MONGODB_URI no está definida');
  process.exit(1);
}

// Conexión a MongoDB
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('✅ Conectado a MongoDB'))
.catch(err => {
  console.error('❌ Error al conectar a MongoDB:', err);
  process.exit(1);
});

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('✅ Backend Meetical funcionando');
});

// Rutas reales
const doctorRoutes = require('./core/api/doctors');
app.use('/api/doctors', doctorRoutes);

// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor corriendo en http://0.0.0.0:${PORT}`);
});

