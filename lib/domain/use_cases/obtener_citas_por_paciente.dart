import '../entities/cita_medica.dart';
import '../repositories/cita_medica_repository.dart';

class ObtenerCitasPorPaciente {
  final CitaMedicaRepository repository;

  ObtenerCitasPorPaciente(this.repository);

  Future<List<CitaMedica>> call(int pacienteId) async {
    return await repository.obtenerCitasPorPaciente(pacienteId);
  }
}
