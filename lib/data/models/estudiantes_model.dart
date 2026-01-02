class Estudiantes {
  final int id;
  final String nombre;
  final String numeroCuenta;
  final String licenciatura;
  final String grupo;
  final String correoInstitucional;
  final String numeroTelefono;
  final double promedio;

  Estudiantes({
    required this.id,
    required this.nombre,
    required this.numeroCuenta,
    required this.licenciatura,
    required this.grupo,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.promedio,
  });

  factory Estudiantes.fromJson(Map<String, dynamic> json) {
    return Estudiantes(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'numeroCuenta': numeroCuenta,
      'licenciatura': licenciatura,
      'grupo': grupo,
      'correoInstitucional': correoInstitucional,
      'numeroTelefono': numeroTelefono,
      'promedio': promedio,
    };
  }

  Estudiantes copyWith({
    int? id,
    String? nombre,
    String? numeroCuenta,
    String? licenciatura,
    String? grupo,
    String? correoInstitucional,
    String? numeroTelefono,
    double? promedio,
  }) {
    return Estudiantes(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      numeroCuenta: numeroCuenta ?? this.numeroCuenta,
      licenciatura: licenciatura ?? this.licenciatura,
      grupo: grupo ?? this.grupo,
      correoInstitucional: correoInstitucional ?? this.correoInstitucional,
      numeroTelefono: numeroTelefono ?? this.numeroTelefono,
      promedio: promedio ?? this.promedio,
    );
  }
}