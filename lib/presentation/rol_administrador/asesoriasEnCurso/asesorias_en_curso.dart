import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesoriasEnCurso/crear_asesoria_modal.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_asesorias_widget.dart';
import 'package:flutter/material.dart';

class AsesoriasEnCurso extends StatefulWidget {
  const AsesoriasEnCurso({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  State<AsesoriasEnCurso> createState() => _AsesoriasEnCursoState();
}

class _AsesoriasEnCursoState extends State<AsesoriasEnCurso> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva(
            query: query,
            onChanged: (value) => setState(() => query = value),
          );
        } else {
          return PantallaGrande(
            query: query,
            onChanged: (value) => setState(() => query = value),
            mostrarTitulo: widget.mostrarTitulo,
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
              // Buscador fijo de 360
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Center(
                  child: SizedBox(
                    width: 360,
                    child: TextField(
                      onChanged: onChanged,
                      decoration: _buscadorDecoration(),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [TarjetaAsesoriasWidget(query: query)],
                  ),
                ),
              ),

              const FooterCrearAlumno(),
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaGrande extends StatelessWidget {
  const PantallaGrande({
    super.key,
    required this.query,
    required this.onChanged,
    this.mostrarTitulo = false,
  });

  final String query;
  final ValueChanged<String> onChanged;
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
                    if (mostrarTitulo)
                      SeccionArribaPantallaGrande(onChanged: onChanged),

                    if (!mostrarTitulo)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: TextField(
                          onChanged: onChanged,
                          decoration: _buscadorDecoration(),
                        ),
                      ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: TarjetaAsesoriasWidget(query: query),
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

InputDecoration _buscadorDecoration() {
  return InputDecoration(
    hintText: 'Buscar Asesoria',
    hintStyle: const TextStyle(fontSize: 15, color: Color(0xFFb4b4b4)),
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
  );
}

class SeccionArribaPantallaGrande extends StatelessWidget {
  const SeccionArribaPantallaGrande({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool esCompacto = constraints.maxWidth < 840;

        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 60.0, top: 20, right: 60.0),
            child: esCompacto
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Asesorias en Curso",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        child: TextField(
                          onChanged: onChanged,
                          decoration: _buscadorDecoration(),
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Asesorias en Curso",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 220,
                        child: TextField(
                          onChanged: onChanged,
                          decoration: _buscadorDecoration(),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
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
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    content: Container(
                      width: 900,
                      height: 600,
                      color: Colors.white,
                      child: const CrearAsesoriaPage(),
                    ),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.verdeClaro,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text("Crear Asesoria", style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
