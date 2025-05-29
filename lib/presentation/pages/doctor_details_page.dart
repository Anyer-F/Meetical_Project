import 'package:flutter/material.dart';

class DoctorDetailPage extends StatelessWidget {
  const DoctorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/banner.png'), // Puedes reemplazarlo por una imagen adecuada
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/doctor.png'),
            ),
            const SizedBox(height: 12),
            const Text('Gabriel Morales Sánchez', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Dirección del consultorio: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Calle de la Salud 175, Torre Médica, Edificio C\n'),
                    TextSpan(text: 'Ciudad: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Huehuetenango\n'),
                    TextSpan(text: 'Horarios de disponibilidad:\n'),
                    TextSpan(text: '• Lunes a Viernes: 08:00 - 13:00\n'),
                    TextSpan(text: '• Sábados: 09:00 - 12:00\n'),
                    TextSpan(text: '• Domingos: Cerrado\n\n'),
                    TextSpan(text: 'Especialidad y subespecialidad:\n'),
                    TextSpan(text: '• Especialidad: Medicina Interna\n'),
                    TextSpan(text: '• Subespecialidad: Cardiología\n\n'),
                    TextSpan(text: 'Acerca de:\n', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text:
                          'Médico especialista en Medicina Interna y subespecialista en Cardiología, con más de 10 años de experiencia en el tratamiento de enfermedades cardiovasculares...',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Agendar cita'),
            ),
          ],
        ),
      ),
    );
  }
}
