import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_asesor/widgets/tarjeta_historial_asesorias_asesor.dart';
import 'package:flutter/material.dart';

class HistorialAsesoriasAsesor extends StatelessWidget {
  const HistorialAsesoriasAsesor({super.key});

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

                    SizedBox(height: 60),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [TarjetaHistorialAsesoriasAsesor()]),
                      ),
                    ),
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

                    SizedBox(height: 60),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [TarjetaHistorialAsesoriasAsesor()]),
                      ),
                    ),

                  
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
  const SeccionArribaPantallaGrande({super.key});

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
            Text(
              "Historial de Asesorias",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),

            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}