import 'package:flutter/material.dart';

class NotificacionesPage extends StatelessWidget {
  final List<Map<String, String>> notificaciones = [
    {
      'titulo': 'Cita confirmada',
      'mensaje': 'Tu cita con el Dr. Gómez ha sido confirmada para el 10 de junio a las 15:00.'
    },
    {
      'titulo': 'Recordatorio de cita',
      'mensaje': 'Recuerda que tienes una cita mañana a las 10:00 con la Dra. Martínez.'
    },
  ];

  NotificacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: ListView.builder(
        itemCount: notificaciones.length,
        itemBuilder: (context, index) {
          final noti = notificaciones[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(noti['titulo']!),
              subtitle: Text(noti['mensaje']!),
              leading: const Icon(Icons.notifications),
            ),
          );
        },
      ),
    );
  }
}
