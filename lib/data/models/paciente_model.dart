import '../../domain/entities/paciente.dart';

class PacienteModel {
  final String id;
  final String nombre;
  final String apellidos;
  final String cui;
  final DateTime fechaNacimiento;
  final int edad;
  final String genero;
  final String telefono;
  final String direccion;
  final String descripcionCita;

  PacienteModel({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.cui,
    required this.fechaNacimiento,
    required this.edad,
    required this.genero,
    required this.telefono,
    required this.direccion,
    required this.descripcionCita,
  });

  factory PacienteModel.fromJson(Map<String, dynamic> json) {
    return PacienteModel(
      id: json['id'].toString(),
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      cui: json['cui'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      edad: json['edad'],
      genero: json['genero'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      descripcionCita: json['descripcionCita'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'cui': cui,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'edad': edad,
      'genero': genero,
      'telefono': telefono,
      'direccion': direccion,
      'descripcionCita': descripcionCita,
    };
  }

  Paciente toEntity() {
    return Paciente(
      id: id,
      nombre: nombre,
      apellidos: apellidos,
      cui: cui,
      fechaNacimiento: fechaNacimiento,
      edad: edad,
      genero: genero,
      telefono: telefono,
      direccion: direccion,
      descripcionCita: descripcionCita,
    );
  }

  factory PacienteModel.fromEntity(Paciente paciente) {
    return PacienteModel(
      id: paciente.id,
      nombre: paciente.nombre,
      apellidos: paciente.apellidos,
      cui: paciente.cui,
      fechaNacimiento: paciente.fechaNacimiento,
      edad: paciente.edad,
      genero: paciente.genero,
      telefono: paciente.telefono,
      direccion: paciente.direccion,
      descripcionCita: paciente.descripcionCita,
    );
  }
}
