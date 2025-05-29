import '../entities/receta.dart';
import '../repositories/receta_repository.dart';

class GuardarReceta {
  final RecetaRepository repository;

  GuardarReceta(this.repository);

  Future<void> call(Receta receta) async {
    await repository.guardarReceta(receta);
  }
}
