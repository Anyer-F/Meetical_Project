import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(backgroundImage: AssetImage('assets/doctor.png')),
        title: Text(name),
        subtitle: Text(specialty),
        onTap: onTap,
      ),
    );
  }
}
