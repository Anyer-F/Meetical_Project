import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FiltrarDoctoresScreen extends StatefulWidget {
  const FiltrarDoctoresScreen({super.key});

  @override
  State<FiltrarDoctoresScreen> createState() => _FiltrarDoctoresScreenState();
}

class _FiltrarDoctoresScreenState extends State<FiltrarDoctoresScreen> {
  List<dynamic> doctores = [];
  List<dynamic> doctoresFiltrados = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    obtenerDoctores();
  }

  Future<void> obtenerDoctores() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/doctors'));

    if (response.statusCode == 200) {
      setState(() {
        doctores = jsonDecode(response.body);
        doctoresFiltrados = doctores;
      });
    } else {
      throw Exception('Error al cargar doctores');
    }
  }

  void filtrarDoctores(String valor) {
    setState(() {
      query = valor.toLowerCase();
      doctoresFiltrados = doctores.where((doctor) {
        final nombre = doctor['name'].toString().toLowerCase();
        final especialidad = doctor['specialty']?.toString().toLowerCase() ?? '';
        final ciudad = doctor['location']?.toString().toLowerCase() ?? '';
        return nombre.contains(query) ||
            especialidad.contains(query) ||
            ciudad.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar doctores')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre, especialidad o ciudad',
                border: OutlineInputBorder(),
              ),
              onChanged: filtrarDoctores,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: doctoresFiltrados.length,
              itemBuilder: (context, index) {
                final doctor = doctoresFiltrados[index];
                return ListTile(
                  title: Text('${doctor['name']} ${doctor['surname']}'),
                  subtitle: Text('${doctor['specialty'] ?? 'Sin especialidad'} - ${doctor['location'] ?? 'Sin ciudad'}'),
                  onTap: () {
                    Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (_) => InfoDoctorScreen(doctor: doctor),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
