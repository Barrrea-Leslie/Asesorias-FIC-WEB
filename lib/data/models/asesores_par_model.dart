class AsesorPar {
  final int id;
  final String nombre;
  final String numeroCuenta;
  final String licenciatura;
  final String grupo;
  final String correoInstitucional;
  final String numeroTelefono;
  final double promedio;
  final List<String> materiasAsesora;
  final List<String> horariosAsesora;

  AsesorPar({
    required this.id,
    required this.nombre,
    required this.numeroCuenta,
    required this.licenciatura,
    required this.grupo,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.promedio,
    required this.materiasAsesora,
    required this.horariosAsesora,
  });

  factory AsesorPar.fromJson(Map<String, dynamic> json) {
    return AsesorPar(
      id: json['id'],
      nombre: json['nombre'],
      numeroCuenta: json['numeroCuenta'],
      licenciatura: json['licenciatura'],
      grupo: json['grupo'],
      correoInstitucional: json['correoInstitucional'],
      numeroTelefono: json['numeroTelefono'],
      promedio: (json['promedio'] as num).toDouble(),
      materiasAsesora: List<String>.from(json['materiasAsesora']),
      horariosAsesora: List<String>.from(json['horariosAsesora']),
    );
  }
}
