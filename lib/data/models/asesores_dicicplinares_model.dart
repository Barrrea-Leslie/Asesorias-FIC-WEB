class AsesorDisciplinar {
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
}