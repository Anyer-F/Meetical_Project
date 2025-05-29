// lib/domain/entities/paciente.dart

class Paciente {
  final String id;
  final String nombre;
  final String apellidos;
  final String cui;
  final DateTime fechaNacimiento;
  final int edad;
  final String genero;
  final String telefono;
  final String direccion;
  final String descripcionCita; // NUEVO

  Paciente({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.cui,
    required this.fechaNacimiento,
    required this.edad,
    required this.genero,
    required this.telefono,
    required this.direccion,
    required this.descripcionCita, // NUEVO
  });
}
