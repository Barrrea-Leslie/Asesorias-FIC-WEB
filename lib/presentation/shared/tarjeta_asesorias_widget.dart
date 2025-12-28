import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/asesorias_service.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class TarjetaAsesoriasWidget extends StatelessWidget {
  const TarjetaAsesoriasWidget({super.key});


  @override
  Widget build(BuildContext context) {

    //llamar a la logica creada arriba para obtener los datos

/*     final List <Asesorias> listaAsesorias = _leerAsesorias();
 */
    return  FutureBuilder(
      future: Future.wait([
        AsesoriasService().getAsesorias(),
        EstudiantesService().getEstudiantes()
      ]),
       // usa el service
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar las asesorías'));
        }
        final asesorias = snapshot.data![0] as List<Asesorias>;
        final estudiantes = snapshot.data![1] as List<Estudiantes>;
        return ListaAsesorias(listaAsesorias: asesorias, listaEstudiantes: estudiantes);
      },
    );
  }
}



class ListaAsesorias extends StatelessWidget {
  const ListaAsesorias({
    super.key,
    required this.listaAsesorias,
    required this.listaEstudiantes,
  });

  final List<Asesorias> listaAsesorias;
  final List<Estudiantes> listaEstudiantes;

  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 280.0;

  @override
  Widget build(BuildContext context) {

    final Map<int, Estudiantes> estudiantesPorId = {
      for (var e in listaEstudiantes) e.id: e
    };
    
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 00),
      child: LayoutBuilder(
        builder: (context, constraints) {
          
        
          return Wrap(
      
              spacing: 20,
              runSpacing: 10,
      
              children: listaAsesorias.map((asesorias) {

                final estudiante = estudiantesPorId[asesorias.idEstudiante];
      
                return SizedBox(
                  width: anchoTarjeta,
                  height: alturaTarjeta,
                  child: Card(
                    color: Appcolores.azulUas,
                    
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        
                      children: [
                    
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                    
/*                             /* Text('Alumno: ${asesorias.nombre}', style: TextStyle(color: Colors.white),),
 */                            Text('Materia: ${asesorias.materia}', style: TextStyle(color: Colors.white),),
/*                             Text('Fecha: ${asesorias.fecha}', style: TextStyle(color: Colors.white),),
/*  */                            Text('Horario: ${asesorias.hoario}', style: TextStyle(color: Colors.white),),
 */                            Text('Modalidad: ${asesorias.modalidad}', style: TextStyle(color: Colors.white),), */
                                Text('Alumno: ${estudiante?.nombre ?? "Estudiante no encontrado"}', style: TextStyle(color: Colors.white),),
                                Text('Materia: ${asesorias.materia}', style: TextStyle(color: Colors.white)),
                                Text('Inicio: ${asesorias.fechaInicio}', style: TextStyle(color: Colors.white)),
                                Text('Horario: ${asesorias.horario}', style: TextStyle(color: Colors.white)),
                                Text('Modalidad: ${asesorias.modalidad}', style: TextStyle(color: Colors.white)),                    
                          ],
                                
                        ),
                    
                        const SizedBox(height: 20,),
                    
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              BotonInfo(asesoria: asesorias,),
                              BotonCompletada(),
                    
                            ],
                    
                        ),

                        const SizedBox(height: 13,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BotonMaterial()
                          ],
                        )
                    
                      ],
                    
                    ),
                  )
                  ),
                );
      
              }).toList(),
      
            );
      
        
        
        },
      
      ),
    );
  }
}

class BotonMaterial extends StatelessWidget {
  const BotonMaterial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {},
    
    style: ElevatedButton.styleFrom(
      minimumSize: Size(30, 35),
      backgroundColor: Appcolores.amarilloUas,
      foregroundColor: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5)
      )
    ),

    child: Text('Material adicional'),
    );
  }
}

class BotonInfo extends StatelessWidget {
  const BotonInfo({
    super.key,
    required this.asesoria
  });

  final Asesorias asesoria;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, "/informacionAsesoriaEnCurso", arguments: asesoria);
    },
    
    style: ElevatedButton.styleFrom(
      minimumSize: Size(30, 35),
      backgroundColor: Appcolores.azulClaro,
      foregroundColor: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5)
      )
    ),

    child: Text('Informacion'),
    );
  }
}

class BotonCompletada extends StatelessWidget {
  const BotonCompletada({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {
      showDialog(context: context, builder: (BuildContext context){
        return AlertaCompletar();
      });
    },
    
    style: ElevatedButton.styleFrom(
      minimumSize: Size(30, 35),
      backgroundColor: Appcolores.verdeClaro,
      foregroundColor: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5)
      )
    ),

    child: Text('Completada'),
    );
  }
}

class AlertaCompletar extends StatelessWidget {
  const AlertaCompletar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmacion"),
      content: Text("Esta seguro de completar la asesoria?"),
      contentPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 143, 143, 143),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            textStyle: TextStyle(fontWeight: FontWeight.bold)
          ),
          onPressed: () {
              Navigator.of(context).pop();
            },
          child: Text("Cancelar")),
    
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 74, 149, 86),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            textStyle: TextStyle(fontWeight: FontWeight.bold)
          ),
          onPressed: () {
            Navigator.of(context).pop();

            MensajeConfirmacion.mostrarMensaje(context, "Se completo la tarea correctamente");

          },
          child: Text("Aceptar")),
        
      ],
    );
  }
}