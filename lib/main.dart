import 'package:flutter/material.dart';
import 'presentation/pages/doctor_list_page.dart';
import 'presentation/pages/doctor_detail_page.dart';

void main() => runApp(const MeeticalApp());

class MeeticalApp extends StatelessWidget {
  const MeeticalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetical',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const DoctorListPage(),
        '/doctor_detail': (context) => const DoctorDetailPage(),
      },
    );
  }
}
