import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final String? value;
  final Function(String?)? onChanged;

  const GenderDropdown({Key? key, this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: const [
        DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
        DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
        DropdownMenuItem(value: 'Otro', child: Text('Otro')),
      ],
      decoration: const InputDecoration(
        labelText: 'Género',
        border: OutlineInputBorder(),
      ),
    );
  }
}
