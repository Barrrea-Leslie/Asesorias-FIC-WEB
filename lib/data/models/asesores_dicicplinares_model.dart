class AsesorDisciplinar {
  final int id;
  final String nombre;
  final String numeroCuenta;
  final String licenciatura;
  final String grupo;
  final String correoInstitucional;
  final String numeroTelefono;
  final double promedio;

  AsesorDisciplinar({
    required this.id,
    required this.nombre,
    required this.numeroCuenta,
    required this.licenciatura,
    required this.grupo,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.promedio,
  });

  factory AsesorDisciplinar.fromJson(Map<String, dynamic> json) {
    return AsesorDisciplinar(
      id: json['id'],
      nombre: json['nombre'],
      numeroCuenta: json['numeroCuenta'],
      licenciatura: json['licenciatura'],
      grupo: json['grupo'],
      correoInstitucional: json['correoInstitucional'],
      numeroTelefono: json['numeroTelefono'],
      promedio: (json['promedio'] as num).toDouble(),
    );
  }
}
