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
      },
    );
  }
}
