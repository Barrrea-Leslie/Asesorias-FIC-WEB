import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class Reportes extends StatelessWidget {
  const Reportes({super.key, this.mostrarTitulo = false});

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
          child: const Center(child: Text('Reportes')),
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

                    const Expanded(child: Center(child: Text('Sin Reportes'))),
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
              "Reportes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
