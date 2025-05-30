import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioCitasScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const CalendarioCitasScreen({super.key, required this.doctor});

  @override
  State<CalendarioCitasScreen> createState() => _CalendarioCitasScreenState();
}

class _CalendarioCitasScreenState extends State<CalendarioCitasScreen> {
  DateTime selectedDate = DateTime.now();
  final List<String> horariosDisponibles = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  List<String> horariosOcupados = ['09:00', '14:00']; //Esto vendría del backend

  @override
  Widget build(BuildContext context) {
    final horariosLibres =
        horariosDisponibles
            .where((hora) => !horariosOcupados.contains(hora))
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Calendario de Citas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _seleccionFecha(),
            const SizedBox(height: 20),
            const Text(
              'Horarios Disponibles:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  horariosLibres.isEmpty
                      ? const Center(
                        child: Text(
                          'No hay horarios disponibles para esta fecha',
                        ),
                      )
                      : ListView.builder(
                        itemCount: horariosLibres.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(horariosLibres[index]),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/programar_cita',
                                arguments: {
                                  'doctor': widget.doctor,
                                  'fecha': selectedDate,
                                  'hora': horariosLibres[index],
                                },
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _seleccionFecha() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Fecha: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
          style: const TextStyle(fontSize: 16),
        ),
        ElevatedButton(
          onPressed: () async {
            final DateTime? fecha = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );
            if (fecha != null) {
              setState(() {
                selectedDate = fecha;
                horariosOcupados = ['09:00']; // 🔁 Simular backend por ahora
              });
            }
          },
          child: const Text('Cambiar Fecha'),
        ),
      ],
    );
  }
}
