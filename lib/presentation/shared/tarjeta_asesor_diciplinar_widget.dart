import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicplinares.dart' show AsesoresDicplinares, AsesorDiciplinarInformacion;
import 'package:flutter/material.dart';

class TarjetaAsesorDiciplinarWidget extends StatelessWidget {
  const TarjetaAsesorDiciplinarWidget({super.key});

  //Logica lextura

  List <AsesoresDicplinares> _leerAsesoresDiciplinar(){

    return AsesorDiciplinarInformacion.asesorDiciplinar;

  }


  @override
  Widget build(BuildContext context) {

    //llamar a la logica creada arriba para obtener los datos

    final List <AsesoresDicplinares> listAsesoresDiciplinares = _leerAsesoresDiciplinar();

    return ListaAsesoresDiciplinares(listAsesoresDiciplinares: listAsesoresDiciplinares);
  }
}



class ListaAsesoresDiciplinares extends StatelessWidget {
  const ListaAsesoresDiciplinares({
    super.key,
    required this.listAsesoresDiciplinares,
  });

  final List<AsesoresDicplinares> listAsesoresDiciplinares;

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