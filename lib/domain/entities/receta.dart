// lib/domain/entities/receta.dart
class Receta {
  final int id;
  final int pacienteId;
  final String contenido;
  final DateTime fecha;

  Receta({
    required this.id,
    required this.pacienteId,
    required this.contenido,
    required this.fecha,
  });
}
