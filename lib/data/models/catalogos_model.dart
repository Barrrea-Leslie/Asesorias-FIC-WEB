class CatalogosModel {
  final List<dynamic> diasSemana;
  final List<dynamic> estatus;
  final List<dynamic> grupos;
  final List<dynamic> horarios;
  final List<dynamic> licenciaturas;
  final List<dynamic> materias;
  final List<dynamic> modalidades;
  final List<dynamic> planEstudios;
  final List<dynamic> razonAsesoria;
  final List<dynamic> roles;
  final List<dynamic> semestres;

  CatalogosModel({
    required this.diasSemana,
    required this.estatus,
    required this.grupos,
    required this.horarios,
    required this.licenciaturas,
    required this.materias,
    required this.modalidades,
    required this.planEstudios,
    required this.razonAsesoria,
    required this.roles,
    required this.semestres,
  });

  factory CatalogosModel.fromJson(Map<String, dynamic> json) {
    return CatalogosModel(
      diasSemana: json['dias_semana'] ?? [],
      estatus: json['estatus'] ?? [],
      grupos: json['grupos'] ?? [],
      horarios: json['horarios'] ?? [],
      licenciaturas: json['licenciaturas'] ?? [],
      materias: json['materias'] ?? [],
      modalidades: json['modalidades'] ?? [],
      planEstudios: json['plan_estudios'] ?? [],
      razonAsesoria: json['razon_asesoria'] ?? [],
      roles: json['roles'] ?? [],
      semestres: json['semestres'] ?? [],
    );
  }
}