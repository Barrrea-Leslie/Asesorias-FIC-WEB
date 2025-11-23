import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/models/estudiante.dart';
import 'package:flutter/material.dart';

class TarjetaEstudianteWidget extends StatelessWidget {
  const TarjetaEstudianteWidget({super.key});

  //Logica lextura

  List <Estudiante> _leerEstudiantes(){

    return EstudiantesInformacion.estudiantes;

  }


  @override
  Widget build(BuildContext context) {

    //llamar a la logica creada arriba para obtener los datos

    final List <Estudiante> listaEstudiantes = _leerEstudiantes();

    return ListaEstudiantesWeb(listaEstudiantes: listaEstudiantes);
  }
}



class ListaEstudiantesWeb extends StatelessWidget {
  const ListaEstudiantesWeb({
    super.key,
    required this.listaEstudiantes,
  });

  final List<Estudiante> listaEstudiantes;

  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 100.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 00),
      child: LayoutBuilder(
        builder: (context, constraints) {
          
        
          return Wrap(
      
              spacing: 20,
              runSpacing: 10,
      
              children: listaEstudiantes.map((estudiante) {
      
                return SizedBox(
                  width: anchoTarjeta,
                  height: alturaTarjeta,
                  child: Card(
                    color: Appcolores.azulUas,
              
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
            
                      Image.asset('assets/images/foto_icon.png', width: 60,),
            
                      Text(estudiante.nombre, style: TextStyle(color: Colors.white),),
            
                    ],
            
                  ),
                  ),
                );
      
              }).toList(),
      
            );
      
        
        
        },
      
      ),
    );
  }
}