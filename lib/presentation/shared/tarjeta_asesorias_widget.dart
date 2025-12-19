import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/models/asesorias.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class TarjetaAsesoriasWidget extends StatelessWidget {
  const TarjetaAsesoriasWidget({super.key});

  //Logica lextura

  List <Asesorias> _leerAsesorias(){

    return AsesoriasInformacion.asesorias;

  }


  @override
  Widget build(BuildContext context) {

    //llamar a la logica creada arriba para obtener los datos

    final List <Asesorias> listaAsesorias = _leerAsesorias();

    return ListaAsesorias(listaAsesorias: listaAsesorias);
  }
}



class ListaAsesorias extends StatelessWidget {
  const ListaAsesorias({
    super.key,
    required this.listaAsesorias,
  });

  final List<Asesorias> listaAsesorias;

  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 280.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 00),
      child: LayoutBuilder(
        builder: (context, constraints) {
          
        
          return Wrap(
      
              spacing: 20,
              runSpacing: 10,
      
              children: listaAsesorias.map((asesorias) {
      
                return SizedBox(
                  width: anchoTarjeta,
                  height: alturaTarjeta,
                  child: Card(
                    color: Appcolores.azulUas,
                    
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                    child: Column(
                      
                        
                      children: [
                    
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                    
                            Text('Alumno: ${asesorias.nombre}', style: TextStyle(color: Colors.white),),
                            Text('Materia: ${asesorias.materia}', style: TextStyle(color: Colors.white),),
                            Text('Fecha: ${asesorias.fecha}', style: TextStyle(color: Colors.white),),
                            Text('Horario: ${asesorias.hoario}', style: TextStyle(color: Colors.white),),
                            Text('Modalidad: ${asesorias.modalidad}', style: TextStyle(color: Colors.white),),
                    
                          ],
                                
                        ),
                    
                        const SizedBox(height: 20,),
                    
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              BotonInfo(),
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
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {},
    
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