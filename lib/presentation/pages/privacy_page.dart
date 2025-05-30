import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidad'),
        backgroundColor: Colors.teal,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('''
Meetical se compromete a proteger la privacidad de sus usuarios. Esta política describe cómo se recopila, utiliza y protege la información personal.

1. Protección de Datos Personales**
- Meetical implementa protocolos de seguridad robustos para proteger la información médica y personal de los usuarios.
- Se emplea cifrado avanzado para la transmisión de datos, garantizando la privacidad de los usuarios.

2. Recopilación y Uso de Información**
- Los datos proporcionados por los usuarios serán utilizados exclusivamente para la gestión de citas médicas y la mejora de la aplicación.
- No compartimos información personal con terceros sin autorización explícita del usuario.

3. Acceso y Seguridad**
- Los datos almacenados en Meetical estarán protegidos mediante sistemas de autenticación segura y bases de datos confiables.
- La plataforma cuenta con medidas de verificación para asegurar que solo profesionales médicos certificados puedan registrarse.

4. Consentimiento del Usuario**
- Al utilizar la aplicación, el usuario acepta el procesamiento de sus datos de acuerdo con estas políticas.
- En caso de dudas, el usuario puede solicitar información sobre sus datos y el manejo de privacidad a través del soporte técnico.

5. Responsabilidad en la Seguridad**
- Meetical no se hace responsable por accesos no autorizados si el usuario comparte sus credenciales con terceros.
- Se recomienda a los usuarios mantener contraseñas seguras y no divulgar información sensible.
            ''', style: TextStyle(fontSize: 16, height: 1.5)),
        ),
      ),
    );
  }
}
