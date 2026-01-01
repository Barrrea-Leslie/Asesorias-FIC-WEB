import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_estudiante_widget.dart';
import 'package:flutter/material.dart';

class Estudiantes extends StatelessWidget {
  const Estudiantes({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1000) {
          return PantallaResponsiva();
        } else {
          return PantallaGrande();
        }
      },
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  const PantallaResponsiva({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            SizedBox(height: 60,),

              Expanded(
                      
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TarjetaEstudianteWidget()
                    ],
                  ),
                )),
        
            FooterCrearAlumno(),
          ],
        ),
      );
  }
}

//widget para pantalla completa

class PantallaGrande extends StatelessWidget {
  const PantallaGrande({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [

            //contenido
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    SeccionArribaPantallaGrande(),
                    
                    SizedBox(height: 60,),

                    Expanded(
                      
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TarjetaEstudianteWidget()
                          ],
                        ),
                      )),
                      
                      

                    FooterCrearAlumno(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeccionArribaPantallaGrande extends StatelessWidget {
  const SeccionArribaPantallaGrande({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0, top: 20, right: 60.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        
            Text("Estudiantes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),

            const SizedBox(width: 15),


            SizedBox(
              width: 220,
              child: TextField(
                
                decoration: InputDecoration(
                  
                  hintText: 'Buscar Estudiante',
                  hintStyle: TextStyle(fontSize: 12, color: Color(0xFFb4b4b4)),
                  prefixIcon: Icon(Icons.search, color: const Color(0xFFb4b4b4), size: 18,),
                  filled: true,
                  fillColor: Color(0xFFf2f3f5),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  )

                ),
              ),
            ),
        
          ],
        ),
      ),

    );
  }
}

class FooterCrearAlumno extends StatelessWidget {
  const FooterCrearAlumno({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
    
            onPressed: () async {
              final estudiantes = await EstudiantesService().getEstudiantes();
  debugPrint(estudiantes.length.toString()); // debería imprimir 5
            },

            style: ElevatedButton.styleFrom(
              
              backgroundColor: Appcolores.verdeClaro,
              foregroundColor: Colors.white,

              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5)
              )

            ),

            child: Text("Crear Estudiante", style: TextStyle(fontSize: 15),),

          ),
        ],
      ),
    );
  }
}