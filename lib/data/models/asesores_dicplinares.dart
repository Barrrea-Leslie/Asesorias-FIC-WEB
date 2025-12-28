

class AsesoresDicplinares{

  final int id;
  final String numeroCuenta;
  final String nombre;
  final String licenciatura;
  final String grupo;
  final String correoInstitucional;
  final String numeroTelefono;
  final String promedio;

  AsesoresDicplinares({
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

class AsesorDiciplinarInformacion {

  static  List <AsesoresDicplinares> get asesorDiciplinar {

    return [

      AsesoresDicplinares(id: 1, numeroCuenta: "19519958", nombre: "Leslie Mayram Barrera Rodriguez", licenciatura: "Informatica", grupo: "4-1", correoInstitucional: "lf.velazquez22@info.uas.edu.mx", numeroTelefono: "6673456211", promedio: "9.9"),
      AsesoresDicplinares(id: 2, numeroCuenta: "19623846", nombre: "Jenifer Guadalupe Tizoc Lopez", licenciatura: "Infromatica", grupo: "4-3", correoInstitucional: "jg.tizoc22@info.uas.edu.mx", numeroTelefono: "6673423456", promedio: "10"),
      
    ];

  }

}