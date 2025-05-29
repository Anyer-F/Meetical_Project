// lib/domain/repositories/paciente_repository.dart
import '../entities/paciente.dart';

abstract class PacienteRepository {
  Future<List<Paciente>> obtenerPacientes(); //AGREGADO FAKE
  Future<List<Paciente>> obtenerTodos();
  Future<Paciente?> obtenerPorId(int id);
  Future<void> guardar(Paciente paciente);
  Future<void> actualizar(Paciente paciente);
  Future<void> eliminar(int id);
}
