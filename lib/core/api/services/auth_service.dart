import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:3000/api';

  ///  Envía un código de recuperación al correo o teléfono del usuario.
  static Future<http.Response> sendRecoveryCode(String emailOrPhone) async {
    final url = Uri.parse('$baseUrl/auth/send-code'); //  Ajusta si la ruta es diferente en tu API

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',  // Asegura que el servidor responda en JSON
        },
        body: jsonEncode({'emailOrPhone': emailOrPhone}),
      );

      print(" Estado respuesta: ${response.statusCode}");
      print(" Cuerpo respuesta: ${response.body}");

      return response;
    } catch (e) {
      print(" Error en la solicitud: $e");
      return http.Response('{"error": "Error en la conexión"}', 500);
    }
  }

  ///  Verifica el código de recuperación enviado al usuario.
  static Future<http.Response> verifyRecoveryCode(String emailOrPhone, String code) async {
    final url = Uri.parse('$baseUrl/auth/verify-code');

    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'emailOrPhone': emailOrPhone,
        'code': code,
      }),
    );
  }

  ///  Cambia la contraseña del usuario (médico o paciente) usando email/teléfono.
  static Future<http.Response> resetPassword(String emailOrPhone, String newPassword) async {
    final url = Uri.parse('$baseUrl/auth/reset-password');

    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'emailOrPhone': emailOrPhone,
        'password': newPassword,
      }),
    );
  }

  ///  Registra un médico enviando su información al backend.
  static Future<http.Response> registerDoctor(Map<String, dynamic> doctorData) async {
    final url = Uri.parse('$baseUrl/doctors/register'); 

    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(doctorData),
    );
  }

  /// Registra un paciente enviando su información al backend.
  static Future<http.Response> registerPatient(Map<String, dynamic> patientData) async {
    final url = Uri.parse('$baseUrl/patients/register'); 

    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(patientData),
    );
  }

  ///  Verifica la respuesta del servidor y maneja errores correctamente.
  static Future<Map<String, dynamic>> processResponse(http.Response response) async {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(" Error en respuesta del servidor: ${response.body}");
      return {'success': false, 'error': 'Unexpected response format'};
    }
  }

  ///  Realiza una solicitud con verificación adicional de headers y formato de respuesta.
  static Future<Map<String, dynamic>> makePostRequest(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return await processResponse(response);
  }
}
