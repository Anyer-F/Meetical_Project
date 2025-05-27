import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class RecordatorioPage extends StatefulWidget {
  const RecordatorioPage({Key? key}) : super(key: key);

  @override
  State<RecordatorioPage> createState() => _RecordatorioPageState();
}

class _RecordatorioPageState extends State<RecordatorioPage> {
  late fln.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final List<String> pacientes = ['Juan Pérez', 'Ana López', 'Carlos Gómez'];
  String? pacienteSeleccionado;

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 12, minute: 0);
  String descripcion = '';

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin = fln.FlutterLocalNotificationsPlugin();

    const androidSettings = fln.AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = fln.DarwinInitializationSettings();

    const initSettings = fln.InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> _scheduleNotification(DateTime dateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Recordatorio para $pacienteSeleccionado',
      descripcion.isNotEmpty ? descripcion : 'Tienes una cita programada.',
      tz.TZDateTime.from(dateTime, tz.local),
      const fln.NotificationDetails(
        android: fln.AndroidNotificationDetails(
          'main_channel_id',
          'Main Channel',
          channelDescription: 'Canal principal de notificaciones',
          importance: fln.Importance.max,
          priority: fln.Priority.high,
        ),
        iOS: fln.DarwinNotificationDetails(),
      ),
      androidScheduleMode: fln.AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: fln.DateTimeComponents.time,
    );
  }

  Future<void> _pickTime(BuildContext context, bool isStartTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _onListoPressed() {
    if (pacienteSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona un paciente.')),
      );
      return;
    }

    final now = DateTime.now();
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startTime.hour,
      startTime.minute,
    );

    if (selectedDateTime.isBefore(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La hora debe ser en el futuro.')),
      );
      return;
    }

    _scheduleNotification(selectedDateTime);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(' Alarma de Recordatorio Activado $pacienteSeleccionado'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recordatorio de Citas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Seleccionar Paciente',
                border: OutlineInputBorder(),
              ),
              value: pacienteSeleccionado,
              items:
                  pacientes.map((paciente) {
                    return DropdownMenuItem(
                      value: paciente,
                      child: Text(paciente),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  pacienteSeleccionado = value;
                });
              },
            ),

            const SizedBox(height: 20),
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('De:'),
                    subtitle: Text(startTime.format(context)),
                    onTap: () => _pickTime(context, true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Hasta:'),
                    subtitle: Text(endTime.format(context)),
                    onTap: () => _pickTime(context, false),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  descripcion = value;
                });
              },
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _onListoPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Listo', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
