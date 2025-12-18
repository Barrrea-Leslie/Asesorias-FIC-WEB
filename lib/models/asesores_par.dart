


class AsesorPar{

  final int id;
  final String numeroCuenta;
  final String nombre;
  final String licenciatura;
  final String grupo;
  final String correoInstitucional;
  final String numeroTelefono;
  final String promedio;

  AsesorPar({
    required this.id,
    required this.numeroCuenta,
    required this.nombre,
    required this.licenciatura,
    required this.grupo,
    required this.correoInstitucional,
    required this.numeroTelefono,
    required this.promedio,
  });

  

}

//en esta calse se hara un afuncion para simular los datos de los asesores

class AsesorParInformacion {

  static  List <AsesorPar> get asesorPar {

    return [

      AsesorPar(id: 1, numeroCuenta: "19519958", nombre: "Jose Angel Astorga Mejía", licenciatura: "Informatica", grupo: "4-1", correoInstitucional: "lf.velazquez22@info.uas.edu.mx", numeroTelefono: "6673456211", promedio: "9.9"),
      AsesorPar(id: 2, numeroCuenta: "19623846", nombre: "Leslie Mayram Barrera", licenciatura: "Infromatica", grupo: "4-3", correoInstitucional: "jg.tizoc22@info.uas.edu.mx", numeroTelefono: "6673423456", promedio: "10"),
      AsesorPar(id: 3, numeroCuenta: "19623846", nombre: "Luis Fernando Velazquez Araujo", licenciatura: "Infromatica", grupo: "4-3", correoInstitucional: "jg.tizoc22@info.uas.edu.mx", numeroTelefono: "6673423456", promedio: "10"),
      AsesorPar(id: 3, numeroCuenta: "19519958", nombre: "Jenifer Tizoc Lopez", licenciatura: "Informatica", grupo: "4-1", correoInstitucional: "lf.velazquez22@info.uas.edu.mx", numeroTelefono: "6673456211", promedio: "9.9"),
  
    ];

  }

}