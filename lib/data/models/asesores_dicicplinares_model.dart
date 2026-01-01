class AsesorDisciplinar {
  final int id;
  final String nombre;
  final String correoInstitucional;
  final String numeroTelefono;


  AsesorDisciplinar({
    required this.id,
    required this.nombre,
    required this.correoInstitucional,
    required this.numeroTelefono,
  });

  factory AsesorDisciplinar.fromJson(Map<String, dynamic> json) {
    return AsesorDisciplinar(
      id: json['id'],
      nombre: json['nombre'],
      correoInstitucional: json['correoInstitucional'],
      numeroTelefono: json['numeroTelefono'],
    );
  }
}
