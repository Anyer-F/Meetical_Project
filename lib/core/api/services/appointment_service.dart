// lib/core/api/service/appointment_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentService {
  final String baseUrl = 'http://10.0.2.2:3000/api/appointments';

  Future<bool> createAppointment({
    required String doctorId,
    required String patientId,
    required String startTime,
    required String endTime,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'doctorId': doctorId,
        'patientId': patientId,
        'startTime': startTime,
        'endTime': endTime,
      }),
    );

    return response.statusCode == 201;
  }
}
