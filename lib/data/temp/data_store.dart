class DataStore {
  /// Lista de citas pendientes (se usa en Seguimiento de Consultas)
  static List<Map<String, dynamic>> citasPendientes = [
    {
      "no": 1,
      "nombre": "Juan Pérez",
      "apellido": "Pérez",
      "direccion": "Zona 1",
      "telefono": "1234-5678",
      "dpi": "1234567890101",
      "fechaNacimiento": "1990-01-01",
      "edad": "33",
      "genero": "Masculino",
      "descripcion": "Chequeo general",
      "fecha": "2024-05-20",
      "atendido": false,
    },
    {
      "no": 2,
      "nombre": "Ana López",
      "apellido": "López",
      "direccion": "Zona 10",
      "telefono": "8765-4321",
      "dpi": "0987654321012",
      "fechaNacimiento": "1985-05-15",
      "edad": "38",
      "genero": "Femenino",
      "descripcion": "Dolor de cabeza constante",
      "fecha": "2024-05-21",
      "atendido": false,
    },
  ];

  /// Historial de citas aceptadas (se usa en Historial Médico)
  static List<Map<String, dynamic>> historialMedico = [];
}
