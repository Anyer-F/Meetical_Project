import '../entities/cita_medica.dart';
import '../repositories/cita_medica_repository.dart';

class ActualizarCita {
  final CitaMedicaRepository repository;

  ActualizarCita(this.repository);

  Future<void> call(CitaMedica cita) async {
    await repository.actualizarCita(cita);
  }
}
