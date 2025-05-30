import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
        backgroundColor: Colors.teal,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('''
Meetical es una aplicación digital destinada a la gestión de citas médicas, proporcionando accesibilidad, organización y eficiencia en la prestación de servicios de salud. Al utilizar nuestra plataforma, aceptas los siguientes términos y condiciones.

1. Uso de la Aplicación**
- Los usuarios podrán agendar citas médicas en cualquier momento y desde cualquier lugar.
- Los profesionales de salud y clínicas pueden gestionar su horario, ver listas de pacientes y consultar historiales de citas.
- Meetical envía notificaciones automáticas para recordar citas y reducir inasistencias.
- La plataforma permite la búsqueda de especialistas por ubicación y especialidad.

2. Requisitos y Registro**
- Para utilizar Meetical, el usuario debe proporcionar datos personales, que serán tratados conforme a nuestras políticas de privacidad.
- Los profesionales médicos deben registrar su identidad y validarse para garantizar la autenticidad de los servicios ofrecidos.

3. Responsabilidades del Usuario**
- Es responsabilidad del usuario brindar información veraz y actualizada.
- Meetical no se hace responsable por cancelaciones de citas, ausencia del usuario o cambios de horario por parte de los profesionales.

4. Limitaciones del Servicio**
- Meetical requiere conexión a internet para operar.
- Algunos usuarios pueden experimentar dificultades debido a falta de familiaridad con la tecnología.

5. Modificaciones y Actualizaciones**
- Meetical se reserva el derecho de actualizar sus funciones y términos sin previo aviso.
            ''', style: TextStyle(fontSize: 16, height: 1.5)),
        ),
      ),
    );
  }
}
