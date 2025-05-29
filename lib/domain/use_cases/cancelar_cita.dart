import '../repositories/cita_medica_repository.dart';

class CancelarCita {
  final CitaMedicaRepository repository;

  CancelarCita(this.repository);

  Future<void> call(int citaId) async {
    await repository.cancelarCita(citaId);
  }
}
