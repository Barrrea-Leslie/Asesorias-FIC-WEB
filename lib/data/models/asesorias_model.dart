class Asesorias {
  final int id;
  final int idEstudiante;
  final String materia;
  final String fechaInicio;
  final String fechaFin;
  final String horario;
  final String modalidad;
  final String razon;
  final int esAsesor;

  Asesorias({
    required this.id,
    required this.idEstudiante,
    required this.materia,
    required this.fechaInicio,
    required this.fechaFin,
    required this.horario,
    required this.modalidad,
    required this.razon,
    required this.esAsesor,
  });


  factory Asesorias.fromJson(Map<String, dynamic> json){
    return Asesorias(
      id: json['id'],
      idEstudiante: json['idEstudiante'],
      materia: json['materia'],
      fechaInicio: json['fechaInicio'],
      fechaFin: json['fechaFin'],
      horario: json['horario'],
      modalidad: json['modalidad'],
      razon: json['razon'],
      esAsesor: json['esAsesor']);
  }
  

}
