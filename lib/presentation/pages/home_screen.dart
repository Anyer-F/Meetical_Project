import 'package:flutter/material.dart';
import '../pages/recordatorio_page.dart';
import '../pages/historial_medico_page.dart';
import '../pages/seguimiento_consultas_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFC7E7ED)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Logo
              Image.asset('assets/images/logo.png', width: 200),

              const SizedBox(height: 60),

              // Botones
              Column(
                children: [
                  CustomHomeButton(
                    text: 'Recordatorio de citas',
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RecordatorioPage(),
                          ),
                        ),
                  ),
                  const SizedBox(height: 20),
                  CustomHomeButton(
                    text: 'Historial Médico',
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistorialMedicoPage(),
                          ),
                        ),
                  ),
                  const SizedBox(height: 20),
                  CustomHomeButton(
                    text: 'Seguimiento de consultas',
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SeguimientoConsultasPage(),
                          ),
                        ),
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),

      // ✅ BOTTOM NAV BAR con botón a DoctorProfilePage
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/doctor_profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tablero'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class CustomHomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomHomeButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.7),
          foregroundColor: Colors.black87,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
