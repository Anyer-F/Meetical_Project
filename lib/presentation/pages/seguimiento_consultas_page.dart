import 'package:flutter/material.dart';
import 'detalle_cita_page.dart';
import '../../data/temp/data_store.dart';

class SeguimientoConsultasPage extends StatefulWidget {
  const SeguimientoConsultasPage({Key? key}) : super(key: key);

  @override
  State<SeguimientoConsultasPage> createState() =>
      _SeguimientoConsultasPageState();
}

class _SeguimientoConsultasPageState extends State<SeguimientoConsultasPage> {
  Map<String, dynamic>? pacienteSeleccionado;

  @override
  Widget build(BuildContext context) {
    final pacientesPendientes = DataStore.citasPendientes;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Seguimiento de Consultas',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Solicitudes Pendientes',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildEncabezadoTabla(),
              Expanded(child: _buildListaPacientes(pacientesPendientes)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed:
                    pacienteSeleccionado == null
                        ? null
                        : () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => DetalleCitaPage(
                                    paciente: pacienteSeleccionado!,
                                  ),
                            ),
                          );
                          setState(() {}); // Refrescar al volver
                        },
                child: const Text('Ver Cita'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Regresar'),
              ),
              const SizedBox(height: 16),
              Image.asset('assets/images/logo.png', height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEncabezadoTabla() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          Expanded(flex: 3, child: Text("Nombre")),
          Expanded(flex: 3, child: Text("Dirección")),
          Expanded(flex: 3, child: Text("Tel")),
        ],
      ),
    );
  }

  Widget _buildListaPacientes(List<Map<String, dynamic>> pacientes) {
    return ListView.builder(
      itemCount: pacientes.length,
      itemBuilder: (context, index) {
        final paciente = pacientes[index];
        final seleccionado = pacienteSeleccionado == paciente;

        return GestureDetector(
          onTap: () {
            setState(() {
              pacienteSeleccionado = paciente;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
              color: seleccionado ? Colors.blue.shade50 : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text('${paciente["no"]}')),
                    Expanded(flex: 3, child: Text(paciente["nombre"])),
                    Expanded(flex: 3, child: Text(paciente["direccion"])),
                    Expanded(flex: 3, child: Text(paciente["telefono"])),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
