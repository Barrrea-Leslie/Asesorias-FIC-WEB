import 'package:asesorias_fic/data/models/horarios.dart';
import 'package:asesorias_fic/data/models/materias.dart';

class asesores_vista_estudiante {
  final int idPersona;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String correo;
  final List<materias> materiasListModel;
  final List<horarios> horariosListModel;

  asesores_vista_estudiante({
    required this.idPersona,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.correo,
    required this.materiasListModel,
    required this.horariosListModel,
  });


  // GETTERS DE COMPATIBILIDAD Y FORMATO PARA LA UI


  /// Devuelve las materias como texto separado por comas (ej. "Algoritmia, Arquitectura")
  String get materiasAsesora => materiasListModel.map((m) => m.nombre).join(', ');

  /// Devuelve los horarios como texto separado por comas (ej. "4:00-5:00 PM, 5:00-6:00 PM")
  String get horariosFormateados => horariosListModel.map((h) => h.horario).join(', ');

  /// Devuelve únicamente los nombres de las materias en una lista List<String>
  List<String> get materiasList => materiasListModel.map((m) => m.nombre).toList();

  /// Devuelve únicamente los textos de horarios en una lista List<String>
  List<String> get horariosList => horariosListModel.map((h) => h.horario).toList();

  /// Devuelve el nombre completo del asesor
  String get nombreCompleto => '$nombre $apellidoPaterno $apellidoMaterno'.trim();

  factory asesores_vista_estudiante.fromJson(Map<String, dynamic> json) {
    return asesores_vista_estudiante(
      idPersona: json['id_persona'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      correo: json['correo'] ?? '',
      materiasListModel: (json['materias'] as List<dynamic>?)
              ?.map((item) {
                if (item is Map<String, dynamic>) {
                  return materias.fromJson(item);
                } else if (item is String) {
                  return materias(idMateria: 0, nombre: item);
                }
                return materias(idMateria: 0, nombre: '');
              })
              .toList() ??
          [],
      horariosListModel: (json['horarios'] as List<dynamic>?)
              ?.map((item) {
                if (item is Map<String, dynamic>) {
                  return horarios.fromJson(item);
                } else if (item is String) {
                  return horarios(idHorario: 0, horario: item);
                }
                return horarios(idHorario: 0, horario: '');
              })
              .toList() ??
          [],
    );
  }

  // ----------------------------------------------------
  // A JSON
  // ----------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id_persona': idPersona,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'correo': correo,
      'materias': materiasListModel.map((m) => m.toJson()).toList(),
      'horarios': horariosListModel.map((h) => h.toJson()).toList(),
    };
  }
}