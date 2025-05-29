import express from 'express';
const router = express.Router();

// Ruta de prueba
router.get('/ping', (req, res) => {
  res.send('Auth API activa');
});

export default router;
 