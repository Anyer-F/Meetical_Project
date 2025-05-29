import 'package:flutter/material.dart';
import 'package:meetical_project/presentation/pages/recover_password.dart';
import 'package:meetical_project/presentation/pages/splash_page.dart';
import 'package:meetical_project/presentation/pages/login_page.dart';
import 'package:meetical_project/presentation/pages/select_user_type_page.dart';
import 'package:meetical_project/presentation/pages/register_patient_page.dart';
import 'package:meetical_project/presentation/pages/terms_page.dart';
import 'package:meetical_project/presentation/pages/privacy_page.dart';
import 'package:meetical_project/presentation/pages/register_doctor_page.dart';
import 'package:meetical_project/presentation/pages/reset_password.dart';
import 'package:meetical_project/presentation/pages/programar_cita.dart';
import 'package:meetical_project/presentation/pages/calendario_citas.dart';

void main() => runApp(const MeeticalApp());

class MeeticalApp extends StatelessWidget {
  const MeeticalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetical App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/select_user_type': (context) => const SelectUserTypePage(),
        '/register_patient': (context) => const RegisterPatientPage(),
        '/terms': (context) => const TermsPage(),
        '/privacy': (context) => const PrivacyPage(),
        '/register_doctor': (context) => const RegisterDoctorPage(),
        '/recover_password': (context) => const RecoverPasswordPage(),
        '/reset_password': (context) => const ResetPassword(),
        '/calendario_citas': (context) => const CalendarioCitasScreen(doctor: {}), // Dummy, reemplazado por argumentos
        '/programar_cita': (context) => const ProgramarCitaScreen(),
        '/programar_cita': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return ProgramarCitaPage(
              doctorId: args['doctorId'],
              doctorNombre: args['doctorNombre'],
              patientId: args['patientId'],
            );
          },
      },
    );
  }
}
