import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
import 'package:flutter/material.dart';

class TarjetaAsesorParWidget extends StatelessWidget {
  const TarjetaAsesorParWidget({super.key});



  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<AsesorPar>>(
      future: AsesoresParService().getAsesoresPar(), // usa el service
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar los asesores par'));
        }
        final listaAsesoresPar = snapshot.data!;
        return ListaAsesoresPar(listAsesoresPar: listaAsesoresPar);
      },
    );
  }
}



class ListaAsesoresPar extends StatelessWidget {
  const ListaAsesoresPar({
    super.key,
    required this.listAsesoresPar,
  });

  final List<AsesorPar> listAsesoresPar;

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
      
              children: listAsesoresPar.map((asesorPar) {
      
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
            
                      Text(asesorPar.nombre, style: TextStyle(color: Colors.white),),
            
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