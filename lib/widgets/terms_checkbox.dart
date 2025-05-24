import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;

  const TermsCheckbox({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      title: Wrap(
        children: [
          const Text("Acepto los "),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/terms');
            },
            child: const Text(
              "Términos y Condiciones",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Text(" y la "),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/privacy');
            },
            child: const Text(
              "Política de Privacidad",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Text("."),
        ],
      ),
    );
  }
}
