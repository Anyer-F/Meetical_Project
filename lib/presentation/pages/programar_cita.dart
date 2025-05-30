import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetical_project/core/api/services/appointment_service.dart'; // Asegúrate de usar la ruta correcta

class ProgramarCitaPage extends StatefulWidget {
  final String doctorId;
  final String doctorNombre;
  final String patientId;

  const ProgramarCitaPage({
    Key? key,
    required this.doctorId,
    required this.doctorNombre,
    required this.patientId,
  }) : super(key: key);

  @override
  _ProgramarCitaPageState createState() => _ProgramarCitaPageState();
}

class _ProgramarCitaPageState extends State<ProgramarCitaPage> {
  DateTime? _fechaSeleccionada;
  TimeOfDay? _horaInicioSeleccionada;

  final AppointmentService _appointmentService = AppointmentService();

  Future<void> _programarCita() async {
    final fecha = _fechaSeleccionada!;
    final horaInicio = _horaInicioSeleccionada!;
    final DateTime horaInicioDT = DateTime(
      fecha.year,
      fecha.month,
      fecha.day,
      horaInicio.hour,
      horaInicio.minute,
    );
    final DateTime horaFinDT = horaInicioDT.add(const Duration(hours: 1));

    final DateFormat isoFormatter = DateFormat("yyyy-MM-ddTHH:mm:ss");

    final bool exito = await _appointmentService.createAppointment(
      doctorId: widget.doctorId,
      patientId: widget.patientId,
      startTime: isoFormatter.format(horaInicioDT),
      endTime: isoFormatter.format(horaFinDT),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          exito ? '✅ Cita registrada con éxito' : '❌ Error al registrar cita',
        ),
      ),
    );

    if (exito) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final doctorId = widget.doctorId;
    final doctorNombre = widget.doctorNombre;
    final patientId = widget.patientId;

    return Scaffold(
      appBar: AppBar(title: const Text('Programar Cita')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Doctor: $doctorNombre',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                DateTime? fecha = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (fecha != null) {
                  setState(() => _fechaSeleccionada = fecha);
                }
              },
              child: Text(
                _fechaSeleccionada == null
                    ? 'Seleccionar fecha'
                    : 'Fecha: ${dateFormatter.format(_fechaSeleccionada!)}',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                TimeOfDay? hora = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (hora != null) {
                  setState(() => _horaInicioSeleccionada = hora);
                }
              },
              child: Text(
                _horaInicioSeleccionada == null
                    ? 'Seleccionar hora de inicio'
                    : 'Hora: ${_horaInicioSeleccionada!.format(context)}',
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed:
                  (_fechaSeleccionada != null &&
                          _horaInicioSeleccionada != null)
                      ? _programarCita
                      : null,
              child: const Text('Solicitar cita'),
            ),
          ],
        ),
      ),
    );
  }
}
