import 'package:flutter/material.dart';

class InformacionPacientePage extends StatelessWidget {
  final Map<String, dynamic> cita;

  const InformacionPacientePage({Key? key, required this.cita})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Información del paciente',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildReadOnlyField('Nombre', cita['nombre']),
                _buildReadOnlyField(
                  'Apellido',
                  'Ejemplo',
                ), // Puedes reemplazar si tienes apellido
                _buildReadOnlyField('CUI/DPI', '1234567890123'),
                _buildReadOnlyField('Fecha de Nacimiento', '01/01/1990'),
                _buildReadOnlyField('Edad', '33'),
                _buildReadOnlyField('Género', 'Masculino'),
                _buildReadOnlyField('Teléfono', '+502 1234-5678'),
                _buildReadOnlyField('Dirección', 'Ciudad, Zona 1'),
                _buildReadOnlyField(
                  'Descripción de la Cita',
                  'Chequeo general',
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Regresar'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
