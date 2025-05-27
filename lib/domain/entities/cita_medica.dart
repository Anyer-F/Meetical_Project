// lib/domain/entities/cita_medica.dart
class CitaMedica {
  final int id;
  final int pacienteId;
  final DateTime fecha;
  final String descripcion;
  final bool alarmaActivada;

  CitaMedica({
    required this.id,
    required this.pacienteId,
    required this.fecha,
    required this.descripcion,
    this.alarmaActivada = false,
  });
}
