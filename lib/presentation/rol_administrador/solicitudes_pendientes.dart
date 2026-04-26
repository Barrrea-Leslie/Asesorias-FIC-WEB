import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_solicitud_widget.dart';
import 'package:flutter/material.dart';

class SolicitudesPendientes extends StatelessWidget {
  const SolicitudesPendientes({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva();
        } else {
          return PantallaGrande(mostrarTitulo: mostrarTitulo);
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
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
    );
  }
}

class PantallaGrande extends StatelessWidget {
  const PantallaGrande({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    if (mostrarTitulo) SeccionArribaPantallaGrande(),

                    const SizedBox(height: 60),

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
            const Text(
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
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
