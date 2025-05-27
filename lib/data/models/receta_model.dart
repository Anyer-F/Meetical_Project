// lib/data/models/receta_model.dart
import '../../domain/entities/receta.dart';

class RecetaModel {
  final int id;
  final int pacienteId;
  final String contenido;
  final DateTime fecha;

  RecetaModel({
    required this.id,
    required this.pacienteId,
    required this.contenido,
    required this.fecha,
  });

  factory RecetaModel.fromJson(Map<String, dynamic> json) {
    return RecetaModel(
      id: json['id'],
      pacienteId: json['pacienteId'],
      contenido: json['contenido'],
      fecha: DateTime.parse(json['fecha']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pacienteId': pacienteId,
      'contenido': contenido,
      'fecha': fecha.toIso8601String(),
    };
  }

  Receta toEntity() {
    return Receta(
      id: id,
      pacienteId: pacienteId,
      contenido: contenido,
      fecha: fecha,
    );
  }

  static RecetaModel fromEntity(Receta entity) {
    return RecetaModel(
      id: entity.id,
      pacienteId: entity.pacienteId,
      contenido: entity.contenido,
      fecha: entity.fecha,
    );
  }
}
