import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/models/solicitudes.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class TarjetaSolicitudWidget extends StatelessWidget {
  const TarjetaSolicitudWidget({super.key});

  //Logica lextura

  List <Solicitudes> _leerSolicitudes(){

    return SolicitudesInofrmacion.solicitudes;

  }


  @override
  Widget build(BuildContext context) {

    //llamar a la logica creada arriba para obtener los datos

    final List <Solicitudes> listaSolicitudes = _leerSolicitudes();

    return ListaSolicitudes(listaSolicitudes: listaSolicitudes);
  }
}



class ListaSolicitudes extends StatelessWidget {
  const ListaSolicitudes({
    super.key,
    required this.listaSolicitudes,
  });

  final List<Solicitudes> listaSolicitudes;

  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 230.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 00),
      child: LayoutBuilder(
        builder: (context, constraints) {
          
        
          return Wrap(
      
              spacing: 20,
              runSpacing: 10,
      
              children: listaSolicitudes.map((solicitud) {
      
                return SizedBox(
                  width: anchoTarjeta,
                  height: alturaTarjeta,
                  child: Card(
                    color: Appcolores.azulUas,
                    
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      
                        
                      children: [
                    
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                    
                            Text('Alumno: ${solicitud.nombre}', style: TextStyle(color: Colors.white),),
                            Text('Materia: ${solicitud.materia}', style: TextStyle(color: Colors.white),),
                            Text('Fecha: ${solicitud.fecha}', style: TextStyle(color: Colors.white),),
                            Text('Horario: ${solicitud.hoario}', style: TextStyle(color: Colors.white),),
                            Text('Modalidad: ${solicitud.modalidad}', style: TextStyle(color: Colors.white),),
                    
                          ],
                                
                        ),
                    
                        const SizedBox(height: 20,),
                    
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              BotonRecahzar(),
                              BotonAceptar(),
                    
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

class BotonRecahzar extends StatelessWidget {
  const BotonRecahzar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {

      showDialog(context: context, builder: (BuildContext context){
        return AlertaRechazar();
      });

    },
    
    style: ElevatedButton.styleFrom(
      backgroundColor: Appcolores.rojo,
      foregroundColor: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5)
      )
    ),

    child: Text('Rechazar'),
    );
  }
}

class BotonAceptar extends StatelessWidget {
  const BotonAceptar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {},
    
    style: ElevatedButton.styleFrom(
      backgroundColor: Appcolores.verdeClaro,
      foregroundColor: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5)
      )
    ),

    child: Text('Aceptar'),
    );
  }
}

class AlertaRechazar extends StatelessWidget {
  const AlertaRechazar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmacion"),
      content: Text("Esta seguro de rechazar la solicitud?"),
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

            MensajeConfirmacion.mostrarMensaje(context, "Se rexhazo la solicitud correctamente");

          },
          child: Text("Aceptar")),
        
      ],
    );
  }
}