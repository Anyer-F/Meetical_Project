import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final emailOrPhone = emailController.text.trim();
    final password = passwordController.text.trim();

    if (emailOrPhone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor llena todos los campos')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse('http://10.0.2.2:3000/api/auth/login'); // Android Emulator
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'emailOrPhone': emailOrPhone,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final userType = responseData['userType'];
        final userName = responseData['name'];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bienvenido $userName')),
        );

        if (userType == 'doctor') {
          Navigator.pushNamed(context, '/doctor_home');
        } else if (userType == 'patient') {
          Navigator.pushNamed(context, '/search_patient_home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Error al iniciar sesión')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Inicio de sesión",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/imagenes/login/user_icon.jpg'),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Correo Electrónico o Teléfono',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Iniciar Sesión"),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/recover_password');
                          },
                          child: const Text("¿Olvidaste tu contraseña?"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Necesitas una cuenta? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/select_user_type');
                        },
                        child: const Text(
                          "Regístrate",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Al continuar, aceptas nuestras Política de privacidad y Términos y condiciones",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
