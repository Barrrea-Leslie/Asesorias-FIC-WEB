import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_asesorias_estudiante.dart';
import 'package:flutter/material.dart';

class AsesoriasEnCursoEstudiante extends StatelessWidget {
  const AsesoriasEnCursoEstudiante({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1000) {
          return PantallaResponsiva();
        }
        else {
          return PantallaGrande();
        }
      });
  }
}

class PantallaGrande extends StatelessWidget {
  const PantallaGrande({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SeccionArriba(),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SingleChildScrollView(
                    child: Text("Tarjetas proximamente")
                     //TarjetaAsesoriasEstudiante()
                    ),
                )
                )
            ],
          ),
        ),
        ),
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  const PantallaResponsiva({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SeccionArriba(),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SingleChildScrollView(
                    child: Text("Tarjetas proximamente")
                    //TarjetaAsesoriasEstudiante()
                    ),
                )
                ),
              
            ],
          ),
        ),
        ),
    );
  }
}



class SeccionArriba extends StatelessWidget {
  
  const SeccionArriba({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 20, right: 60.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Asesorias en Curso",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
          
        ],
      ),
    );
  }
}