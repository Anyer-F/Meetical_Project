import 'package:flutter/material.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/doctor_profile':
            (context) => const DoctorProfilePage(), // ✅ Ruta agregada
      },
    );
  }
}
