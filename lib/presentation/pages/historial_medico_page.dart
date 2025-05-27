import 'package:flutter/material.dart';
import 'informacion_paciente_page.dart';
import 'receta_medica_page.dart';

class HistorialMedicoPage extends StatefulWidget {
  const HistorialMedicoPage({Key? key}) : super(key: key);

  @override
  State<HistorialMedicoPage> createState() => _HistorialMedicoPageState();
}

class _HistorialMedicoPageState extends State<HistorialMedicoPage> {
  final List<Map<String, dynamic>> citasSimuladas = [
    {"no": 1, "nombre": "Juan Pérez", "fecha": "2023-12-01", "atendido": true},
    {"no": 2, "nombre": "Ana López", "fecha": "2023-11-28", "atendido": false},
    {"no": 3, "nombre": "Carlos Ruiz", "fecha": "2023-11-25", "atendido": true},
  ];

  String filtro = '';
  Map<String, dynamic>? citaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/images/logo.png', height: 80),
              const SizedBox(height: 10),
              _buildSearchBar(),
              const SizedBox(height: 12),
              _buildTableHeader(),
              const SizedBox(height: 6),
              Expanded(child: _buildTableBody()),
              const SizedBox(height: 16),
              _buildBottomButtons(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            filtro = value.toLowerCase();
          });
        },
        decoration: InputDecoration(
          hintText: 'Buscar',
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: Text("No", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Nombre",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text("Fecha", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Atendido",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBody() {
    final datosFiltrados =
        citasSimuladas.where((cita) {
          final nombre = cita['nombre'].toString().toLowerCase();
          return nombre.contains(filtro);
        }).toList();

    return ListView.builder(
      itemCount: datosFiltrados.length,
      itemBuilder: (context, index) {
        final cita = datosFiltrados[index];
        final seleccionada = citaSeleccionada == cita;

        return GestureDetector(
          onTap: () {
            setState(() {
              citaSeleccionada = cita;
            });
          },
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: seleccionada ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            color: seleccionada ? Colors.blue.shade50 : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text('${cita["no"]}')),
                  Expanded(flex: 3, child: Text(cita["nombre"])),
                  Expanded(flex: 3, child: Text(cita["fecha"])),
                  Expanded(
                    flex: 2,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: cita["atendido"] ? "Sí" : "No",
                      items:
                          ["Sí", "No"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          cita["atendido"] = newValue == "Sí";
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed:
              citaSeleccionada == null
                  ? null
                  : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => InformacionPacientePage(
                              cita: citaSeleccionada!,
                            ),
                      ),
                    );
                  },
          icon: const Icon(Icons.info_outline),
          label: const Text('Ver Información del paciente'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.deepPurple.shade100,
            foregroundColor: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed:
              citaSeleccionada == null
                  ? null
                  : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => RecetaMedicaPage(cita: citaSeleccionada!),
                      ),
                    );
                  },
          icon: const Icon(Icons.medication_outlined),
          label: const Text('Receta'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.deepPurple.shade100,
            foregroundColor: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
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
            backgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.black87,
          ),
        ),
      ],
    );
  }
}
