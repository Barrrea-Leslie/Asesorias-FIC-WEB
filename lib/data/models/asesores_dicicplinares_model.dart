
class AsesorDisciplinar {
  final int idPersona;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String numeroCuenta;
  final String correo;
  final String numCel;
  final List<String> materiasAsesora;
  final List<String> horariosAsesora;

  AsesorDisciplinar({
    required this.idPersona,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.numeroCuenta,
    required this.correo,
    required this.numCel,
    required this.materiasAsesora,
    required this.horariosAsesora,
  });

  factory AsesorDisciplinar.fromJson(Map<String, dynamic> json) {
    final materias = (json['materiasasesor'] as List? ?? [])
        .map((m) => m['materia'].toString())
        .toList();

    final horarios = (json['horariosasesor'] as List? ?? [])
        .map((h) => h['horario'].toString())
        .toList();

    return AsesorDisciplinar(
      idPersona: json['id_persona'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      numeroCuenta: json['numero_cuenta']?.toString() ?? '',
      correo: json['correo'] ?? '',
      numCel: json['num_cel'] ?? '',
      materiasAsesora: materias,
      horariosAsesora: horarios,
    );
  }
}


/* class AsesorDisciplinar {
  final int id;
  final String nombre;
  final String correoInstitucional;
  final String numeroTelefono;
  final List<String> materiasAsesora;
  final List<String> horariosAsesora;

  AsesorDisciplinar({
    required this.id,
    required this.nombre,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.materiasAsesora,
    required this.horariosAsesora,
  });

  factory AsesorDisciplinar.fromJson(Map<String, dynamic> json) {
    return AsesorDisciplinar(
      id: json['id'],
      nombre: json['nombre'],
      correoInstitucional: json['correoInstitucional'],
      numeroTelefono: json['numeroTelefono'],
      materiasAsesora: List<String>.from(json['materiasAsesora']),
      horariosAsesora: List<String>.from(json['horariosAsesora']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correoInstitucional': correoInstitucional,
      'numeroTelefono': numeroTelefono,
      'materiasAsesora': materiasAsesora,
      'horariosAsesora': horariosAsesora,
    };
  }

  AsesorDisciplinar copyWith({
    int? id,
    String? nombre,
    String? correoInstitucional,
    String? numeroTelefono,
    List<String>? materiasAsesora,
    List<String>? horariosAsesora,
  }) {
    return AsesorDisciplinar(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      correoInstitucional: correoInstitucional ?? this.correoInstitucional,
      numeroTelefono: numeroTelefono ?? this.numeroTelefono,
      materiasAsesora: materiasAsesora ?? this.materiasAsesora,
      horariosAsesora: horariosAsesora ?? this.horariosAsesora,
    );
  }
} */