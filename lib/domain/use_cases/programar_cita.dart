import '../entities/cita_medica.dart';
import '../repositories/cita_medica_repository.dart';

class ProgramarCita {
  final CitaMedicaRepository repository;

  ProgramarCita(this.repository);

  Future<void> call(CitaMedica cita) async {
    await repository.programarCita(cita);
  }
}
