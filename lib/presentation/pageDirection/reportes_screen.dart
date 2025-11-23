
import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/mydrawer.dart';
import 'package:flutter/material.dart';

class ReportesScreen extends StatelessWidget {
  const ReportesScreen({super.key});

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, size: 30.0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text('Reportes', style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      drawer: Mydrawer(rutaActual: '/reportes'),

      body: Center(
        child: Text('Reportes'),
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

            //menu
            Mydrawer(rutaActual: '/reportes'),

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
                      
                      child: Text('Reportes')),
                      
                      

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
        
            Text("Reportes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),

            const SizedBox(width: 15),

        
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
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
    
            onPressed: () {},

            style: ElevatedButton.styleFrom(

              backgroundColor: Appcolores.verdeClaro,
              foregroundColor: Colors.white,

              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10)
              )

            ),

            child: Text("Crear Aseosor"),

          ),
        ],
      ),
    );
  }
}
