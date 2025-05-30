import 'package:flutter/material.dart';

class NotificacionesPage extends StatelessWidget {
  final List<Map<String, String>> notificaciones = [
    {
      'titulo': 'Cita confirmada',
      'mensaje':
          'Tu cita con el Dr. Gómez ha sido confirmada para el 10 de junio a las 15:00.',
    },
    {
      'titulo': 'Recordatorio de cita',
      'mensaje':
          'Recuerda que tienes una cita mañana a las 10:00 con la Dra. Martínez.',
    },
    {
      'titulo': 'Cambio de horario',
      'mensaje':
          'Tu cita con el Dr. Pérez fue cambiada al 12 de junio a las 11:00.',
    },
  ];

  NotificacionesPage({super.key}); // 👈 Aquí ya sin 'const'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F5FB),
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: const Color(0xFFBED2E0),
      ),
      body: ListView.builder(
        itemCount: notificaciones.length,
        itemBuilder: (context, index) {
          final noti = notificaciones[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.blueGrey),
              title: Text(
                noti['titulo']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(noti['mensaje']!),
            ),
          );
        },
      ),
    );
  }
}
