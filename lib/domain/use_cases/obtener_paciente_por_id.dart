import '../entities/paciente.dart';
import '../repositories/paciente_repository.dart';

class ObtenerPacientePorId {
  final PacienteRepository repository;

  ObtenerPacientePorId(this.repository);

  Future<Paciente?> call(int id) async {
    return await repository.obtenerPorId(id);
  }
}
