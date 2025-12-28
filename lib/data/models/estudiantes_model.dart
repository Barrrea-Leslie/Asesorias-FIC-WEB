

class Estudiantes{

  final int id;
  final String nombre;
  final String numeroCuenta;
  final String licenciatura;
  final String grupo;
  final String correoInstitucional;
  final String numeroTelefono;
  final double promedio;

  Estudiantes({
    required this.id,
    required this.nombre,
    required this.numeroCuenta,
    required this.licenciatura,
    required this.grupo,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.promedio
    });

    factory Estudiantes.fromJson(Map<String, dynamic> json) {

      return Estudiantes(
        id: json['id'],
        numeroCuenta: json['numeroCuenta'],
        nombre: json['nombre'],
        licenciatura: json['licenciatura'],
        grupo: json['grupo'],
        correoInstitucional: json['correoInstitucional'],
        numeroTelefono: json['numeroTelefono'],
        promedio: (json['promedio'] as num).toDouble(),);

    }

  

}