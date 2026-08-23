class materias {
  final int idMateria;
  final String nombre;

  materias({
    required this.idMateria,
    required this.nombre,
  });

  factory materias.fromJson(Map<String, dynamic> json) {
    return materias(
      idMateria: json['id_materia'],
      nombre: json['materia'] ?? json['nombre'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_materia': idMateria,
      'materia': nombre,
    };
  }
}