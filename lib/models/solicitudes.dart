class Solicitudes {

  final int id;
  final String nombre;
  final String materia;
  final String fecha;
  final String hoario;
  final String modalidad;

  Solicitudes({
    required this.id,
    required this.nombre,
    required this.materia,
    required this.fecha,
    required this.hoario,
    required this.modalidad
  });

}

class SolicitudesInofrmacion {


  static List <Solicitudes> get solicitudes{

    return [

      Solicitudes(id: 1, nombre: 'Jose Angel Astorga Mejia', materia: 'Programacion', fecha: '25/SEP/2025', hoario: '18:00 - 19:00', modalidad: 'Virtual'),
      Solicitudes(id: 2, nombre: 'Jose Angel Astorga Mejia', materia: 'Programacion', fecha: '25/SEP/2025', hoario: '18:00 - 19:00', modalidad: 'Virtual'),

    ];

  }

  

}