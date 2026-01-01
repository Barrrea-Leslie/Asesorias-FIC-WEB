import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_estudiante_widget.dart';
import 'package:flutter/material.dart';

class Estudiantes extends StatefulWidget {
  const Estudiantes({super.key});

  @override
  State<Estudiantes> createState() => _EstudiantesState();
}

class _EstudiantesState extends State<Estudiantes> {
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
    return Center(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  SeccionArribaPantallaGrande(onChanged: onChanged),
                  const SizedBox(height: 30),
                  
                  TarjetaEstudianteWidget(query: query)
                ],
              ),
            ),
          ),
          const FooterCrearAlumno(),
        ],
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
                            TarjetaEstudianteWidget(query: query)
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
            const Text("Estudiantes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
            const SizedBox(width: 15),
            SizedBox(
              width: 220,
              child: TextField(
                onChanged: onChanged, // Conectado al setState del padre
                decoration: InputDecoration(
                  hintText: 'Buscar Estudiante',
                  hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFb4b4b4)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFb4b4b4), size: 18),
                  filled: true,
                  fillColor: const Color(0xFFf2f3f5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Appcolores.azulUas),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
            onPressed: () async {
              final estudiantes = await EstudiantesService().getEstudiantes();
              debugPrint(estudiantes.length.toString());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.verdeClaro,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            child: const Text("Crear Estudiante", style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}