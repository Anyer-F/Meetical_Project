import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Datos simulados del paciente
  Map<String, String> paciente = {
    'nombre': 'Juan Pérez',
    'email': 'juan.perez@example.com',
    'telefono': '123-456-7890',
    'direccion': 'Calle Falsa 123',
  };

  bool _editando = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _emailController;
  late TextEditingController _telefonoController;
  late TextEditingController _direccionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: paciente['nombre']);
    _emailController = TextEditingController(text: paciente['email']);
    _telefonoController = TextEditingController(text: paciente['telefono']);
    _direccionController = TextEditingController(text: paciente['direccion']);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        paciente['nombre'] = _nombreController.text;
        paciente['email'] = _emailController.text;
        paciente['telefono'] = _telefonoController.text;
        paciente['direccion'] = _direccionController.text;
        _editando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Paciente'),
        actions: [
          IconButton(
            icon: Icon(_editando ? Icons.check : Icons.edit),
            onPressed: () {
              if (_editando) {
                _guardarCambios();
              } else {
                setState(() {
                  _editando = true;
                });
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                enabled: _editando,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa el nombre' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
                enabled: _editando,
                validator: (value) =>
                    value == null || !value.contains('@') ? 'Correo inválido' : null,
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                enabled: _editando,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa el teléfono' : null,
              ),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                enabled: _editando,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa la dirección' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
