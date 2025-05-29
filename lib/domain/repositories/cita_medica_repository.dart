// lib/domain/repositories/cita_medica_repository.dart
import '../entities/cita_medica.dart';

abstract class CitaMedicaRepository {
  Future<List<CitaMedica>> obtenerCitasPorPaciente(int pacienteId);
  Future<void> programarCita(CitaMedica cita);
  Future<void> actualizarCita(CitaMedica cita);
  Future<void> cancelarCita(int citaId);
}
