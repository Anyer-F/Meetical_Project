import '../../domain/entities/paciente.dart';
import '../../domain/repositories/paciente_repository.dart';

class FakePacienteRepository implements PacienteRepository {
  final List<Paciente> _pacientes = [
    Paciente(
      id: '1',
      nombre: 'Carlos',
      apellidos: 'Martínez',
      cui: '1234567890123',
      fechaNacimiento: DateTime(1990, 5, 20),
      edad: 34,
      genero: 'Masculino',
      telefono: '5551234567',
      direccion: 'Zona 1, Ciudad',
      descripcionCita: 'Chequeo general',
    ),
    Paciente(
      id: '2',
      nombre: 'Ana',
      apellidos: 'Gómez',
      cui: '9876543210987',
      fechaNacimiento: DateTime(1985, 3, 14),
      edad: 39,
      genero: 'Femenino',
      telefono: '5557654321',
      direccion: 'Zona 10, Ciudad',
      descripcionCita: 'Consulta ginecológica',
    ),
  ];

  /// Simulación personalizada para buscador
  @override
  Future<List<Paciente>> obtenerPacientes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _pacientes;
  }

  /// Implementación del método que pide la interfaz
  @override
  Future<List<Paciente>> obtenerTodos() async {
    return obtenerPacientes();
  }

  /// ID como int, convertido internamente a string
  @override
  Future<Paciente?> obtenerPorId(int id) async {
    try {
      return _pacientes.firstWhere((p) => p.id == id.toString());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> guardar(Paciente paciente) async {
    _pacientes.add(paciente);
  }

  @override
  Future<void> actualizar(Paciente paciente) async {
    final index = _pacientes.indexWhere((p) => p.id == paciente.id);
    if (index != -1) {
      _pacientes[index] = paciente;
    }
  }

  @override
  Future<void> eliminar(int id) async {
    _pacientes.removeWhere((p) => p.id == id.toString());
  }
}
