import 'package:flutter/material.dart';
import 'package:meetical_project/presentation/pages/register_doctor_page.dart';
import 'package:meetical_project/presentation/pages/register_patient_page.dart';
import 'package:meetical_project/core/api/services/auth_service.dart';

class FormActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final String submitText;
  final TextEditingController emailOrPhoneController;
  final TextEditingController codeController;

  const FormActionButtons({
    Key? key,
    required this.onCancel,
    required this.onSubmit,
    required this.emailOrPhoneController,
    required this.codeController,
    this.submitText = "Registrarse",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await AuthService.sendRecoveryCode(emailOrPhoneController.text);
          },
          child: const Text("Enviar Código"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final response = await AuthService.verifyRecoveryCode(emailOrPhoneController.text, codeController.text);
            if (response.statusCode == 200) {
              Navigator.pushNamed(context, '/reset_password');  // Navegar a la pantalla de cambio de contraseña
            }
          },
          child: const Text("Verificar Código"),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onCancel,
                child: const Text("Cancelar"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: onSubmit,
                child: Text(submitText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
