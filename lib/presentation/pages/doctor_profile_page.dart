import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  Map<String, dynamic>? doctorData;
  bool isLoading = true;
  String errorMessage = '';

  final String doctorId = '682fcdadc2c3d8337a7f294c'; // <-- Tu ID de prueba
  final String baseUrl =
      'http://10.0.2.2:3000/api/doctors'; // Asegúrate que el backend esté corriendo

  @override
  void initState() {
    super.initState();
    fetchDoctorProfile();
  }

  Future<void> fetchDoctorProfile() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$doctorId'));

      if (response.statusCode == 200) {
        setState(() {
          doctorData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Ocurrió un error al conectar: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Médico'),
        backgroundColor: Colors.teal,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person, size: 80, color: Colors.teal),
                        const SizedBox(height: 20),
                        InfoRow(
                          label: 'Nombre',
                          value: doctorData?['name'] ?? '',
                        ),
                        InfoRow(
                          label: 'Apellido',
                          value: doctorData?['surname'] ?? '',
                        ),
                        InfoRow(
                          label: 'Correo',
                          value: doctorData?['email'] ?? '',
                        ),
                        InfoRow(
                          label: 'Teléfono',
                          value: doctorData?['phone'] ?? '',
                        ),
                        InfoRow(
                          label: 'Género',
                          value: doctorData?['gender'] ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
