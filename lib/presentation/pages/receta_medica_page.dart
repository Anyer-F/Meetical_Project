import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RecetaMedicaPage extends StatefulWidget {
  final Map<String, dynamic> cita;

  const RecetaMedicaPage({Key? key, required this.cita}) : super(key: key);

  @override
  State<RecetaMedicaPage> createState() => _RecetaMedicaPageState();
}

class _RecetaMedicaPageState extends State<RecetaMedicaPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController diagnosticoController = TextEditingController();
  final TextEditingController recetaController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  bool editable = true;

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.cita['nombre'];
    edadController.text = '30';
    dniController.text = '1234567890123';
    diagnosticoController.text = 'Diagnóstico general';
    recetaController.text = 'Rp./ Tomar 1 tableta cada 8 horas por 5 días.';
    fechaController.text = DateTime.now().toString().substring(0, 10);
  }

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    dniController.dispose();
    diagnosticoController.dispose();
    recetaController.dispose();
    fechaController.dispose();
    super.dispose();
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          readOnly: !editable,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: editable ? Colors.white : Colors.grey.shade200,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Future<void> _generarPdf() async {
    final pdf = pw.Document();

    final logoBytes = await rootBundle.load('assets/images/logo.png');
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(child: pw.Image(logoImage, height: 50)),
                pw.SizedBox(height: 10),
                pw.Text("Médico especialista en Medicina Interna"),
                pw.Text("Nombre"),
                pw.Text("CMP: 00000     RNE: 0000"),
                pw.Divider(),

                pw.Text("NOMBRE: ${nombreController.text}"),
                pw.Text(
                  "N° DNI: ${dniController.text}    EDAD: ${edadController.text}",
                ),
                pw.SizedBox(height: 10),

                pw.Text(
                  "DIAGNÓSTICO:",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(diagnosticoController.text),
                pw.SizedBox(height: 10),

                pw.Text(
                  "Rp./",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(recetaController.text),
                pw.SizedBox(height: 20),

                pw.Text("FECHA: ${fechaController.text}"),
                pw.SizedBox(height: 40),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text("Firma y Sello"),
                ),
                pw.Divider(),
                pw.Text("Contacto al médico: ***"),
                pw.Text("Correo: test@testgmail.com"),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'receta_medica.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receta Médica'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png', height: 40),
                    const SizedBox(height: 8),
                    const Text(
                      "Médico especialista en Medicina Interna",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text("Nombre"),
                    const Text("CMP: 00000     RNE: 0000"),
                    const Divider(thickness: 1),
                    _buildEditableField("NOMBRE:", nombreController),
                    Row(
                      children: [
                        Expanded(
                          child: _buildEditableField("N° DNI:", dniController),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildEditableField("EDAD:", edadController),
                        ),
                      ],
                    ),
                    _buildEditableField("DIAGNÓSTICO:", diagnosticoController),
                    _buildEditableField("Rp./", recetaController, maxLines: 5),
                    Row(
                      children: [
                        Expanded(
                          child: _buildEditableField("FECHA:", fechaController),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Text(
                              "FIRMA Y SELLO",
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    const Text("Contacto al médico: ***"),
                    const Text(
                      "Correo: test@testgmail.com",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    editable = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Receta guardada.")),
                  );
                },
                child: const Text("Guardar"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        editable = true;
                      });
                    },
                    child: const Text("Modificar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _generarPdf,
                    child: const Text("Descargar Receta"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
