import 'package:flutter/material.dart';
import 'package:meetical_project/widgets/custom_text_field.dart';
import 'package:meetical_project/core/api/services/auth_service.dart';
import 'dart:convert';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool showVerificationField = false;

  Future<void> sendCode() async {
    final input = emailOrPhoneController.text.trim();

    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu correo o teléfono')),
      );
      return;
    }

    try {
      final response = await AuthService.sendRecoveryCode(input);
      print("📌 Estado respuesta: ${response.statusCode}");
      print("📦 Cuerpo respuesta: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          showVerificationField = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Código enviado con éxito')),
        );
      } else {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${body['error'] ?? 'No se pudo enviar el código'}',
            ),
          ),
        );
      }
    } catch (e) {
      print("❌ Error en la solicitud: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error de red: $e')));
    }
  }

  Future<void> verifyCodeAndRedirect() async {
    final input = emailOrPhoneController.text.trim();
    final code = codeController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa el código')),
      );
      return;
    }

    try {
      final response = await AuthService.verifyRecoveryCode(input, code);
      print("📌 Estado respuesta: ${response.statusCode}");
      print("📦 Cuerpo respuesta: ${response.body}");

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/reset_password', arguments: input);
      } else {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Código inválido: ${body['error'] ?? 'Código incorrecto'}',
            ),
          ),
        );
      }
    } catch (e) {
      print("❌ Error en la verificación: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error de red: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Recuperación de contraseña"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Recuperación de contraseña",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              labelText: "Ingresa correo electrónico o Teléfono",
              controller: emailOrPhoneController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: sendCode, child: const Text("Enviar")),
            const SizedBox(height: 24),
            if (showVerificationField) ...[
              CustomTextField(
                labelText: "Código de verificación",
                controller: codeController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: verifyCodeAndRedirect,
                child: const Text("Aceptar"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
