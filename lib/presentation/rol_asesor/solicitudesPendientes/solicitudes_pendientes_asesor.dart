import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_solicitud_widget.dart';
import 'package:flutter/material.dart';

class SolicitudesPendientesAsesor extends StatelessWidget {
  const SolicitudesPendientesAsesor({super.key});

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
                        child: Column(children: [TarjetaSolicitudWidget()]),
                      ),
                    ),

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
                        child: Column(children: [TarjetaSolicitudWidget()]),
                      ),
                    ),

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
              "Solicitudes Pendientes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),

            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class FooterCrearAlumno extends StatelessWidget {
  const FooterCrearAlumno({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
