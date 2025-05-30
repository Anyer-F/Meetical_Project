import 'package:flutter/material.dart';

class InfoDoctorScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const InfoDoctorScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${doctor['name']} ${doctor['surname']}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _infoTile('Especialidad', doctor['specialty']),
            _infoTile('Correo', doctor['email']),
            _infoTile('Teléfono', doctor['phone']),
            _infoTile('Número de registro', doctor['registerNumber']),
            _infoTile('Título', doctor['title']),
            _infoTile('Clínica / Consultorio', doctor['clinicNumber']),
            _infoTile('Ubicación', doctor['location']),
            _infoTile('Género', doctor['gender']),
            _infoTile('Fecha de nacimiento', doctor['birthDate']),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/programar_cita',
                  arguments: {
                    'doctorId': doctor['_id'],
                    'doctorNombre': '${doctor['name']} ${doctor['surname']}',
                    'patientId':
                        'mockPatientId123', // Reemplaza con el real cuando lo tengas
                  },
                );
              },
              child: const Text('Agendar cita'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, dynamic value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value?.toString() ?? 'No disponible'),
    );
  }
}
