class SolicitudesEnRevision{

  final String materia;
  final String asesor;
  final String fecha;
  final String horario;
  final String estado;
  final String notas;

  SolicitudesEnRevision({
    required this.materia,
    required this.asesor,
    required this.fecha,
    required this.horario,
    required this.estado,
    required this.notas
  });

  factory SolicitudesEnRevision.fromJson(Map<String, dynamic> json){
    return SolicitudesEnRevision(
      materia: json['materia'],
      asesor: json['asesor'],
      fecha: json['fecha'],
      horario: json['horario'],
      estado: json['estado'],
      notas: json['notas']
    );
  }

}