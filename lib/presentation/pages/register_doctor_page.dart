import 'package:flutter/material.dart';
import 'package:meetical_project/widgets/widgets.dart';
import 'dart:convert';
import 'package:meetical_project/core/api/services/auth_service.dart';
import 'package:meetical_project/presentation/pages/privacy_page.dart';
import 'package:meetical_project/presentation/pages/terms_page.dart';

class RegisterDoctorPage extends StatefulWidget {
  const RegisterDoctorPage({super.key});

  @override
  _RegisterDoctorPageState createState() => _RegisterDoctorPageState();
}

class _RegisterDoctorPageState extends State<RegisterDoctorPage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthdateController = TextEditingController();
  final titleController = TextEditingController();
  final specialtyController = TextEditingController();
  final registerNumberController = TextEditingController();
  final locationController = TextEditingController();
  final clinicNumberController = TextEditingController();

  String? gender = 'Masculino';
  bool notificationsEnabled = false;
  bool termsAccepted = false;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? birthDateError;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        birthdateController.text = picked.toIso8601String().split('T').first;
        birthDateError = null;
      });
    }
  }
Future<void> validateAndSubmit() async {
  setState(() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    emailError = emailRegex.hasMatch(emailController.text) ? null : 'Correo Electrónico incorrecto';
    passwordError = passwordController.text.length < 8 ? 'Debe tener al menos 8 caracteres' : null;
    confirmPasswordError = confirmPasswordController.text != passwordController.text
        ? 'La contraseña no coincide'
        : null;
    birthDateError = birthdateController.text.isEmpty ? 'Debe seleccionar una fecha de nacimiento' : null;
  });

  if (emailError == null &&
      passwordError == null &&
      confirmPasswordError == null &&
      birthDateError == null &&
      termsAccepted) {
    final payload = {
      "name": nameController.text,
      "surname": surnameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "birthDate": birthdateController.text,
      "title": titleController.text,
      "specialty": specialtyController.text,
      "registerNumber": registerNumberController.text,
      "location": locationController.text,
      "clinicNumber": clinicNumberController.text,
      "gender": gender,
      "password": passwordController.text,
      "notificationsEnabled": notificationsEnabled,
      "termsAccepted": termsAccepted,
    };

    try {
      final response = await AuthService.registerDoctor(payload);

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('¡Registro exitoso!'),
            content: const Text('Médico registrado correctamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        try {
          final body = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${body['message'] ?? response.body}')),
          );
        } catch (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error inesperado: ${response.body}')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de red: $e')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Médico")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomTextField(labelText: 'Nombres', controller: nameController),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Apellidos', controller: surnameController),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Correo Electrónico', controller: emailController, errorText: emailError),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Teléfono', controller: phoneController),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: () => selectDate(context),
              child: AbsorbPointer(
                child: CustomTextField(labelText: 'Fecha de Nacimiento', controller: birthdateController),
              ),
            ),
            if (birthDateError != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  birthDateError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 12),

            CustomTextField(labelText: 'Título Médico', controller: titleController),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Especialidad', controller: specialtyController),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Número de Registro', controller: registerNumberController),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Ubicación', controller: locationController),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Número de Clínica', controller: clinicNumberController),
            const SizedBox(height: 12),

            GenderDropdown(value: gender, onChanged: (v) => setState(() => gender = v)),
            const SizedBox(height: 12),

            CustomTextField(labelText: 'Contraseña', controller: passwordController, obscureText: true, errorText: passwordError),
            const SizedBox(height: 12),
            CustomTextField(labelText: 'Confirmar Contraseña', controller: confirmPasswordController, obscureText: true, errorText: confirmPasswordError),
            const SizedBox(height: 12),

            SwitchListTile(
              value: notificationsEnabled,
              onChanged: (val) => setState(() => notificationsEnabled = val),
              title: const Text("Activar Notificaciones"),
            ),
            const SizedBox(height: 12),

            CheckboxListTile(
              value: termsAccepted,
              onChanged: (val) => setState(() => termsAccepted = val ?? false),
              title: Row(
                children: [
                  const Text("Aceptar "),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsPage())),
                    child: const Text("Términos", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  ),
                  const Text(" y "),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPage())),
                    child: const Text("Política", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: validateAndSubmit,
                    child: const Text("Registrar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
