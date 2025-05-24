import 'package:flutter/material.dart';

class SelectUserTypePage extends StatelessWidget {
  const SelectUserTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imagenes/register/fondo_registro.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              '¿Quieres registrarte como?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 130), // 
            _buildUserTypeOption(
              context,
              imagePath: 'assets/imagenes/register/medico.jpg',
              label: 'Médico',
              onPressed: () => Navigator.pushNamed(context, '/register_doctor'),
            ),
            const SizedBox(height: 150), // Mayor separación entre botones
            _buildUserTypeOption(
              context,
              imagePath: 'assets/imagenes/register/paciente.jpg',
              label: 'Paciente',
              onPressed: () => Navigator.pushNamed(context, '/register_patient'),
            ),
            const Spacer(flex: 3),
            _buildCancelButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypeOption(BuildContext context,
      {required String imagePath, required String label, required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(width: 25),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF3EEF9),
            foregroundColor: Colors.deepPurple,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          ),
          child: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF3EEF9),
        foregroundColor: Colors.deepPurple,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 35),
      ),
      child: const Text('Cancelar', style: TextStyle(fontSize: 16)),
    );
  }
}
