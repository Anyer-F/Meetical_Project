import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// 📦 Páginas generales
import 'package:meetical_project/presentation/pages/splash_page.dart';
import 'package:meetical_project/presentation/pages/login_page.dart';
import 'package:meetical_project/presentation/pages/select_user_type_page.dart';
import 'package:meetical_project/presentation/pages/register_patient_page.dart';
import 'package:meetical_project/presentation/pages/register_doctor_page.dart';
import 'package:meetical_project/presentation/pages/recover_password.dart';
import 'package:meetical_project/presentation/pages/reset_password.dart';
import 'package:meetical_project/presentation/pages/terms_page.dart';
import 'package:meetical_project/presentation/pages/privacy_page.dart';

// 👨‍⚕️ Páginas del médico
import 'package:meetical_project/presentation/pages/doctor_profile_page.dart';
import 'package:meetical_project/presentation/pages/calendario_citas.dart';
import 'package:meetical_project/presentation/pages/programar_cita.dart';
import 'package:meetical_project/presentation/pages/home_screen.dart';

// 🔔 Notificaciones
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ⏰ Inicializar zonas horarias
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Guatemala'));

  // 🔔 Configurar notificaciones locales
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      // Acción cuando el usuario toca la notificación (pendiente)
    },
  );

  runApp(const MeeticalApp());
}

class MeeticalApp extends StatelessWidget {
  const MeeticalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetical App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // 🌟 Rutas generales
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/select_user_type': (context) => const SelectUserTypePage(),
        '/register_patient': (context) => const RegisterPatientPage(),
        '/register_doctor': (context) => const RegisterDoctorPage(),
        '/recover_password': (context) => const RecoverPasswordPage(),
        '/reset_password': (context) => const ResetPassword(),
        '/terms': (context) => const TermsPage(),
        '/privacy': (context) => const PrivacyPage(),

        // 👨‍⚕️ Médico
        '/home': (context) => const HomeScreen(),
        '/doctor_profile': (context) => const DoctorProfilePage(),
        '/calendario_citas':
            (context) => const CalendarioCitasScreen(doctor: {}),

        // 📅 Programar cita con argumentos
        '/programar_cita': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return ProgramarCitaPage(
              doctorId: args['doctorId'],
              doctorNombre: args['doctorNombre'],
              patientId: args['patientId'],
            );
          } else {
            return const Scaffold(
              body: Center(child: Text('Error: Faltan argumentos')),
            );
          }
        },
      },
    );
  }
}
