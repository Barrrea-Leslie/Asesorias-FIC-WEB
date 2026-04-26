import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_asesorias_estudiante.dart';
import 'package:flutter/material.dart';

class AsesoriasEnCursoEstudiante extends StatefulWidget {
  const AsesoriasEnCursoEstudiante({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  State<AsesoriasEnCursoEstudiante> createState() =>
      _AsesoriasEnCursoEstudianteState();
}

class _AsesoriasEnCursoEstudianteState
    extends State<AsesoriasEnCursoEstudiante> {
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
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              // 🔍 Buscador centrado
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
                  child: TarjetaAsesoriasEstudiante(query: query),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaGrande extends StatelessWidget {
  final String query;
  final ValueChanged<String> onChanged;
  final bool mostrarTitulo;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.onChanged,
    required this.mostrarTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              if (mostrarTitulo) SeccionArriba(onChanged: onChanged),

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
                  child: TarjetaAsesoriasEstudiante(query: query),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeccionArriba extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SeccionArriba({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final esCompacto = constraints.maxWidth < 840;

        return Padding(
          padding: const EdgeInsets.only(left: 60, top: 20, right: 60),
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
                    TextField(
                      onChanged: onChanged,
                      decoration: _buscadorDecoration(),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Asesorias en Curso",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: TextField(
                        onChanged: onChanged,
                        decoration: _buscadorDecoration(),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

InputDecoration _buscadorDecoration() {
  return InputDecoration(
    hintText: 'Buscar Asesoría',
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
