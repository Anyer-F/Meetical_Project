import '../entities/receta.dart';
import '../repositories/receta_repository.dart';

class ActualizarReceta {
  final RecetaRepository repository;

  ActualizarReceta(this.repository);

  Future<void> call(Receta receta) async {
    await repository.actualizarReceta(receta);
  }
}
