import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:flutter/material.dart';

class TarjetaAsesorDiciplinarWidget extends StatelessWidget {
  const TarjetaAsesorDiciplinarWidget({super.key});


  @override
  Widget build(BuildContext context) {


    return FutureBuilder<List<AsesorDisciplinar>>(
      future: AsesoresDiciplinaresService().getAsesoresDiciplinares(), // usa el service
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar los asesores diciplinares'));
        }
        final listaAsesoresDiciplinares = snapshot.data!;
        return ListaAsesoresDiciplinares(listAsesoresDiciplinares: listaAsesoresDiciplinares);
      },
    );
  }
}



class ListaAsesoresDiciplinares extends StatelessWidget {
  const ListaAsesoresDiciplinares({
    super.key,
    required this.listAsesoresDiciplinares,
  });

  final List<AsesorDisciplinar> listAsesoresDiciplinares;

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
      
              children: listAsesoresDiciplinares.map((asesorDiciplinar) {
      
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
            
                      Text(asesorDiciplinar.nombre, style: TextStyle(color: Colors.white),),
            
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