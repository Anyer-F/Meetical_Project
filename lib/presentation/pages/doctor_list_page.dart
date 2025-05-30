import 'package:flutter/material.dart';
import '../widgets/doctor_card.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = [
      {'name': 'Gabriel Morales', 'specialty': 'Cardiólogo'},
      {'name': 'Onofri Kallimachí', 'specialty': 'Pediatra'},
      {'name': 'Irma Cirio', 'specialty': 'Ginecólogo'},
      {'name': 'Agostina López', 'specialty': 'Oftalmóloga'},
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Tablero',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'Encuentre a su médico.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(
                    name: doctor['name']!,
                    specialty: doctor['specialty']!,
                    onTap: () {
                      Navigator.pushNamed(context, '/doctor_detail');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
