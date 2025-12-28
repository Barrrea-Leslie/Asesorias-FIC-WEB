import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:flutter/material.dart';

class TarjetaEstudianteWidget extends StatelessWidget {
  const TarjetaEstudianteWidget({super.key});


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Estudiantes>>(
      future: EstudiantesService().getEstudiantes(), // usa el service
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar los estudiantes'));
        }
        final listaEstudiantes = snapshot.data!;
        return ListaEstudiantesWeb(listaEstudiantes: listaEstudiantes);
      },
    );
    }
}



class ListaEstudiantesWeb extends StatelessWidget {
  const ListaEstudiantesWeb({
    super.key,
    required this.listaEstudiantes,
  });

  final List<Estudiantes> listaEstudiantes;

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