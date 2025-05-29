import '../entities/receta.dart';
import '../repositories/receta_repository.dart';

class ObtenerRecetaPorPaciente {
  final RecetaRepository repository;

  ObtenerRecetaPorPaciente(this.repository);

  Future<Receta?> call(int pacienteId) async {
    return await repository.obtenerRecetaPorPaciente(pacienteId);
  }
}
