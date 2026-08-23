class horarios {
  final int idHorario;
  final String horario;

  horarios({
    required this.idHorario,
    required this.horario,
  });

  factory horarios.fromJson(Map<String, dynamic> json) {
    return horarios(
      idHorario: json['id_horario'],
      horario: json['horario'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_horario': idHorario,
      'horario': horario,
    };
  }
}