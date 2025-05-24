import 'package:flutter/material.dart';
import 'package:meetical_project/widgets/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  String? passwordError;
  String? confirmError;

  void validateAndSubmit(String emailOrPhone) {
    setState(() {
      passwordError = passwordController.text.length < 8
          ? "Debe tener al menos 8 caracteres"
          : null;
      confirmError = passwordController.text != confirmController.text
          ? "La contraseña no coincide"
          : null;
    });

    if (passwordError == null && confirmError == null) {
      // Aquí iría una llamada al backend para actualizar la contraseña usando emailOrPhone
      print("Nueva contraseña para $emailOrPhone: ${passwordController.text}");

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String emailOrPhone =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Restablece tu contraseña",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: "Contraseña nueva",
              controller: passwordController,
              obscureText: true,
              errorText: passwordError,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: "Vuelve a ingresar la contraseña",
              controller: confirmController,
              obscureText: true,
              errorText: confirmError,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => validateAndSubmit(emailOrPhone),
              child: const Text("Cambiar contraseña"),
            ),
          ],
        ),
      ),
    );
  }
}
