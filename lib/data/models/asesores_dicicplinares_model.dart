class AsesorDisciplinar {
  final int id;
  final String nombre;
  final String numeroCuenta;
  final String contrasena;
  final String correoInstitucional;
  final String numeroTelefono;
  final List<String> materiasAsesora;
  final List<String> horariosAsesora;

  AsesorDisciplinar({
    required this.id,
    required this.nombre,
    required this.numeroCuenta,
    required this.contrasena,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.materiasAsesora,
    required this.horariosAsesora,
  });

  factory AsesorDisciplinar.fromJson(Map<String, dynamic> json) {
    return AsesorDisciplinar(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      // Agregamos .toString() para evitar el error de tipo si el JSON manda un número
      numeroCuenta: json['numero_cuenta']?.toString() ?? '', 
      contrasena: json['contrasena'] ?? '',
      correoInstitucional: json['correoInstitucional'] ?? '',
      numeroTelefono: json['numeroTelefono'] ?? '',
      materiasAsesora: List<String>.from(json['materiasAsesora'] ?? []),
      horariosAsesora: List<String>.from(json['horariosAsesora'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'numero_cuenta': numeroCuenta, // Faltaba este
      'contrasena': contrasena,      // Faltaba este
      'correoInstitucional': correoInstitucional,
      'numeroTelefono': numeroTelefono,
      'materiasAsesora': materiasAsesora,
      'horariosAsesora': horariosAsesora,
    };
  }

  AsesorDisciplinar copyWith({
    int? id,
    String? nombre,
    String? numeroCuenta,
    String? contrasena,
    String? correoInstitucional,
    String? numeroTelefono,
    List<String>? materiasAsesora,
    List<String>? horariosAsesora,
  }) {
    return AsesorDisciplinar(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      numeroCuenta: numeroCuenta ?? this.numeroCuenta,
      contrasena: contrasena ?? this.contrasena,
      correoInstitucional: correoInstitucional ?? this.correoInstitucional,
      numeroTelefono: numeroTelefono ?? this.numeroTelefono,
      materiasAsesora: materiasAsesora ?? this.materiasAsesora,
      horariosAsesora: horariosAsesora ?? this.horariosAsesora,
    );
  }
}

/* import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/crear_asesor_disiplinar.dart';

class AsesorDisciplinar {
  final int idPersona;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String numeroCuenta;
  final String correo;
  final String numCel;

  final List<MateriaItem> materiasasesor; // IDs y nombres
  final List<HorarioItem> horariosasesor;

  AsesorDisciplinar({
    required this.idPersona,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.numeroCuenta,
    required this.correo,
    required this.numCel,
    required this.materiasasesor,
    required this.horariosasesor,
  });

  factory AsesorDisciplinar.fromJson(Map<String, dynamic> json) {
    return AsesorDisciplinar(
      idPersona: json['id_persona'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      numeroCuenta: json['numero_cuenta']?.toString() ?? '',
      correo: json['correo'] ?? '',
      numCel: json['num_cel'] ?? '',
      materiasasesor: (json['materiasasesor'] as List? ?? [])
          .map((m) => MateriaItem(id: m['id_materia'], nombre: m['materia']))
          .toList(),
      horariosasesor: (json['horariosasesor'] as List? ?? [])
          .map((h) => HorarioItem(id: h['id_horario'], texto: h['horario']))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id_persona': idPersona,
        'nombre': nombre,
        'apellido_paterno': apellidoPaterno,
        'apellido_materno': apellidoMaterno,
        'numero_cuenta': numeroCuenta,
        'correo': correo,
        'num_cel': numCel,
        'materias': materiasasesor.map((m) => {'id_materia': m.id}).toList(),
        'horarios': horariosasesor.map((h) => {'id_horario': h.id}).toList(),
      };
}

 */


