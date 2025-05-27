// lib/domain/repositories/receta_repository.dart
import '../entities/receta.dart';

abstract class RecetaRepository {
  Future<Receta?> obtenerRecetaPorPaciente(int pacienteId);
  Future<void> guardarReceta(Receta receta);
  Future<void> actualizarReceta(Receta receta);
}
