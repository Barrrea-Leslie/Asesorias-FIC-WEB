import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_asesor_par_widget.dart';
import 'package:flutter/material.dart';

class AsesoresPar extends StatefulWidget {
  const AsesoresPar({super.key});

  @override
  State<AsesoresPar> createState() => _AsesoresParState();
}

class _AsesoresParState extends State<AsesoresPar> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1000) {
          return PantallaResponsiva(
            query: query,
            onChanged: (value) => setState(() => query = value),
          );
        } else {
          return PantallaGrande(
            query: query,
            onChanged: (value) => setState(() => query = value),
          );
        }
      },
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  final String query;
  final ValueChanged<String> onChanged;

  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SeccionArribaPantallaGrande(onChanged: onChanged),
                    const SizedBox(height: 30),
                    TarjetaAsesorParWidget(query: query)
                  ],
                ),
              ),
            ),
            const FooterCrearAlumno(),
          ],
        ),
      ),
    );
  }
}

class PantallaGrande extends StatelessWidget {
  final String query;
  final ValueChanged<String> onChanged;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.onChanged,
  });

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
                    SeccionArribaPantallaGrande(onChanged: onChanged),
                    const SizedBox(height: 60),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TarjetaAsesorParWidget(query: query)
                          ],
                        ),
                      ),
                    ),
                    const FooterCrearAlumno(),
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
  final ValueChanged<String> onChanged;

  const SeccionArribaPantallaGrande({
    super.key,
    required this.onChanged,
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
            const Text("Asesores Par", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
            const SizedBox(width: 15),
            SizedBox(
              width: 220,
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Buscar Asesor',
                  hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFb4b4b4)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFb4b4b4), size: 18),
                  filled: true,
                  fillColor: const Color(0xFFf2f3f5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Appcolores.azulUas),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Crear Asesor"),
                    content: const Text('Formulario para nuevo asesor par'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Aceptar')),
                    ],
                  );
                }
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.verdeClaro,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
            ),
            child: const Text("Crear Asesor", style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}