class AsesorPar {
  final int id;
  final String nombre;
  final String numeroCuenta;
  final String contrasena;
  final String licenciatura;
  final String grupo;
  final String correoInstitucional;
  final String numeroTelefono;
  final double promedio;
  final List<String> materiasAsesora;
  final List<String> horariosAsesora;

  AsesorPar({
    required this.id,
    required this.nombre,
    required this.numeroCuenta,
    required this.contrasena,
    required this.licenciatura,
    required this.grupo,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.promedio,
    required this.materiasAsesora,
    required this.horariosAsesora,
  });

  // Convierte el JSON a Objeto Dart
  factory AsesorPar.fromJson(Map<String, dynamic> json) {
    return AsesorPar(
      id: json['id'],
      nombre: json['nombre'],
      numeroCuenta: json['numeroCuenta'],
      contrasena: json['contrasena'] ?? '',
      licenciatura: json['licenciatura'],
      grupo: json['grupo'],
      correoInstitucional: json['correoInstitucional'],
      numeroTelefono: json['numeroTelefono'],
      promedio: (json['promedio'] as num).toDouble(),
      materiasAsesora: List<String>.from(json['materiasAsesora']),
      horariosAsesora: List<String>.from(json['horariosAsesora']),
    );
  }

  // Convierte el Objeto Dart a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'numeroCuenta': numeroCuenta,
      'contrasena': contrasena,
      'licenciatura': licenciatura,
      'grupo': grupo,
      'correoInstitucional': correoInstitucional,
      'numeroTelefono': numeroTelefono,
      'promedio': promedio,
      'materiasAsesora': materiasAsesora,
      'horariosAsesora': horariosAsesora,
    };
  }

  // Permite crear una copia modificando solo algunos campos
  AsesorPar copyWith({
    int? id,
    String? nombre,
    String? numeroCuenta,
    String? contrasena,
    String? licenciatura,
    String? grupo,
    String? correoInstitucional,
    String? numeroTelefono,
    double? promedio,
    List<String>? materiasAsesora,
    List<String>? horariosAsesora,
  }) {
    return AsesorPar(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      numeroCuenta: numeroCuenta ?? this.numeroCuenta,
      contrasena: contrasena ?? this.contrasena,
      licenciatura: licenciatura ?? this.licenciatura,
      grupo: grupo ?? this.grupo,
      correoInstitucional: correoInstitucional ?? this.correoInstitucional,
      numeroTelefono: numeroTelefono ?? this.numeroTelefono,
      promedio: promedio ?? this.promedio,
      materiasAsesora: materiasAsesora ?? this.materiasAsesora,
      horariosAsesora: horariosAsesora ?? this.horariosAsesora,
    );
  }
}