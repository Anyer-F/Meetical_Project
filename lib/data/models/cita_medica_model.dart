// lib/data/models/cita_medica_model.dart
import '../../domain/entities/cita_medica.dart';

class CitaMedicaModel {
  final int id;
  final int pacienteId;
  final DateTime fecha;
  final String descripcion;
  final bool alarmaActivada;

  CitaMedicaModel({
    required this.id,
    required this.pacienteId,
    required this.fecha,
    required this.descripcion,
    required this.alarmaActivada,
  });

  factory CitaMedicaModel.fromJson(Map<String, dynamic> json) {
    return CitaMedicaModel(
      id: json['id'],
      pacienteId: json['pacienteId'],
      fecha: DateTime.parse(json['fecha']),
      descripcion: json['descripcion'],
      alarmaActivada: json['alarmaActivada'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pacienteId': pacienteId,
      'fecha': fecha.toIso8601String(),
      'descripcion': descripcion,
      'alarmaActivada': alarmaActivada,
    };
  }

  CitaMedica toEntity() {
    return CitaMedica(
      id: id,
      pacienteId: pacienteId,
      fecha: fecha,
      descripcion: descripcion,
      alarmaActivada: alarmaActivada,
    );
  }

  static CitaMedicaModel fromEntity(CitaMedica entity) {
    return CitaMedicaModel(
      id: entity.id,
      pacienteId: entity.pacienteId,
      fecha: entity.fecha,
      descripcion: entity.descripcion,
      alarmaActivada: entity.alarmaActivada,
    );
  }
}
