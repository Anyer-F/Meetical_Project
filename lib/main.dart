import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:meetical_project/presentation/pages/recover_password.dart';
import 'package:meetical_project/presentation/pages/splash_page.dart';
import 'package:meetical_project/presentation/pages/login_page.dart';
import 'package:meetical_project/presentation/pages/select_user_type_page.dart';
import 'package:meetical_project/presentation/pages/register_patient_page.dart';
import 'package:meetical_project/presentation/pages/terms_page.dart';
import 'package:meetical_project/presentation/pages/privacy_page.dart';
import 'package:meetical_project/presentation/pages/register_doctor_page.dart';
import 'package:meetical_project/presentation/pages/reset_password.dart';
<<<<<<< HEAD
=======
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'presentation/pages/home_screen.dart';
import 'presentation/pages/doctor_profile_page.dart'; // ✅ Importamos la pantalla del perfil

// ✅ Instancia global para usar en cualquier parte de la app
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Inicializa zonas horarias (necesario para notificaciones programadas)
  tz.initializeTimeZones();
  tz.setLocalLocation(
    tz.getLocation('America/Guatemala'),
  ); // Cambia según tu zona

  // ✅ Configuración para Android
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
  );

  // ✅ Inicializa el sistema de notificaciones
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      // Aquí puedes manejar qué hacer si el usuario toca la notificación
    },
  );
>>>>>>> origin/Andy

  runApp(const MyApp());
}
=======
import 'package:meetical_project/presentation/pages/programar_cita.dart';
import 'package:meetical_project/presentation/pages/calendario_citas.dart';

void main() => runApp(const MeeticalApp());
>>>>>>> origin/anyer

class MeeticalApp extends StatelessWidget {
  const MeeticalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
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
<<<<<<< HEAD
     
         
=======
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/doctor_profile':
            (context) => const DoctorProfilePage(), // ✅ Ruta agregada
>>>>>>> origin/Andy
=======
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
>>>>>>> origin/anyer
      },
    );
  }
}
