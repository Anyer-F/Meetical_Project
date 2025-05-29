import 'package:flutter/material.dart';

class NotificacionesPage extends StatelessWidget {
<<<<<<< HEAD
  const NotificacionesPage({super.key});
=======
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
>>>>>>> origin/anyer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color(0xFFE5F5FB), // Color de fondo claro
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: const Color(0xFFBED2E0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Notificaciones',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Lista de notificaciones vacías
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Cantidad fija por ahora
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.notifications, size: 28),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Mensaje de notificación',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica futura para reenviar notificación
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text('Recordar Notificación'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica futura para eliminar notificación
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text('Eliminar Notificación'),
                ),
              ],
            ),
          ],
        ),
=======
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
>>>>>>> origin/anyer
      ),
    );
  }
}
