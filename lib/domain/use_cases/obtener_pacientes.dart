import '../entities/paciente.dart';
import '../repositories/paciente_repository.dart';

class ObtenerPacientes {
  final PacienteRepository repository;

  ObtenerPacientes(this.repository);

  Future<List<Paciente>> call() async {
    return await repository.obtenerTodos();
  }
}
