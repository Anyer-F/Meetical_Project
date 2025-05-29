import 'package:flutter/material.dart';
import '../../data/temp/data_store.dart';

class DetalleCitaPage extends StatefulWidget {
  final Map<String, dynamic> paciente;

  const DetalleCitaPage({Key? key, required this.paciente}) : super(key: key);

  @override
  State<DetalleCitaPage> createState() => _DetalleCitaPageState();
}

class _DetalleCitaPageState extends State<DetalleCitaPage> {
  bool mostrarAgendada = false;
  bool mostrarRechazada = false;
  final TextEditingController motivoRechazoController = TextEditingController();

  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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

  Widget _buildNotificacionAgendada() {
    return Card(
      margin: const EdgeInsets.only(top: 20),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline, color: Colors.green),
        title: const Text('Cita Agendada'),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              mostrarAgendada = false;
            });
          },
        ),
        subtitle: ElevatedButton(
          onPressed: () {
            setState(() {
              mostrarAgendada = false;
              Navigator.pop(context);
            });
          },
          child: const Text("Aceptar"),
        ),
      ),
    );
  }

  Widget _buildNotificacionRechazada() {
    return Card(
      margin: const EdgeInsets.only(top: 20),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cancel_outlined, color: Colors.red),
                const SizedBox(width: 8),
                const Text(
                  'Cita Rechazada',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      mostrarRechazada = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Motivo:"),
            TextFormField(
              controller: motivoRechazoController,
              maxLines: 2,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final motivo = motivoRechazoController.text.trim();
                if (motivo.isNotEmpty) {
                  setState(() {
                    DataStore.citasPendientes.remove(widget.paciente);
                    mostrarRechazada = false;
                    Navigator.pop(context);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Motivo enviado al paciente: $motivo"),
                    ),
                  );
                }
              },
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    motivoRechazoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paciente = widget.paciente;

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
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Registro de Pacientes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildField("Nombre", paciente["nombre"] ?? ""),
                _buildField("Apellido", paciente["apellido"] ?? ""),
                _buildField("CUI/DPI", paciente["dpi"] ?? ""),
                _buildField(
                  "Fecha de Nacimiento",
                  paciente["fechaNacimiento"] ?? "",
                ),
                _buildField("Edad", paciente["edad"] ?? ""),
                _buildField("Género", paciente["genero"] ?? ""),
                _buildField("Teléfono", paciente["telefono"] ?? ""),
                _buildField("Dirección", paciente["direccion"] ?? ""),
                _buildField(
                  "Descripción de la Cita",
                  paciente["descripcion"] ?? "",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          mostrarAgendada = true;
                          mostrarRechazada = false;
                          DataStore.historialMedico.add(widget.paciente);
                          DataStore.citasPendientes.remove(widget.paciente);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Aceptar Cita"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          mostrarRechazada = true;
                          mostrarAgendada = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Rechazar"),
                    ),
                  ],
                ),
                if (mostrarAgendada) _buildNotificacionAgendada(),
                if (mostrarRechazada) _buildNotificacionRechazada(),
                const SizedBox(height: 20),
                Image.asset('assets/images/logo.png', height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
