import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_historial_asesoria.dart';
import 'package:flutter/material.dart';

class HistorialDeAsesorias extends StatefulWidget {
  const HistorialDeAsesorias({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  State<HistorialDeAsesorias> createState() => _HistorialDeAsesoriasState();
}

class _HistorialDeAsesoriasState extends State<HistorialDeAsesorias> {
  String query = '';
  Map<String, String?> filtrosActivos = {};

  void _abrirFiltros() async {
    final resultado = await showDialog<Map<String, String?>>(
      context: context,
      builder: (_) => const FiltrosAsesoria(),
    );

    if (resultado != null) {
      setState(() => filtrosActivos = resultado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva(
            query: query,
            filtros: filtrosActivos,
            onChanged: (v) => setState(() => query = v),
            onTapFiltro: _abrirFiltros,
          );
        } else {
          return PantallaGrande(
            query: query,
            filtros: filtrosActivos,
            onChanged: (v) => setState(() => query = v),
            onTapFiltro: _abrirFiltros,
            mostrarTitulo: widget.mostrarTitulo,
          );
        }
      },
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  final String query;
  final Map<String, String?> filtros;
  final ValueChanged<String> onChanged;
  final VoidCallback onTapFiltro;

  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.filtros,
    required this.onChanged,
    required this.onTapFiltro,
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
              const SizedBox(height: 20),

              // 🔍 Buscador centrado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

              TextButton.icon(
                onPressed: onTapFiltro,
                icon: const Icon(Icons.filter_list),
                label: const Text("Filtrar"),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: TarjetaHistorialAsesoria(
                    query: query,
                    filtros: filtros,
                  ),
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
  final Map<String, String?> filtros;
  final ValueChanged<String> onChanged;
  final VoidCallback onTapFiltro;
  final bool mostrarTitulo;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.filtros,
    required this.onChanged,
    required this.onTapFiltro,
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
              if (mostrarTitulo)
                SeccionArriba(onChanged: onChanged, onTapFiltro: onTapFiltro),

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
                  child: TarjetaHistorialAsesoria(
                    query: query,
                    filtros: filtros,
                  ),
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
  final VoidCallback onTapFiltro;

  const SeccionArriba({
    super.key,
    required this.onChanged,
    required this.onTapFiltro,
  });

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
                      "Historial de Asesorías",
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
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: onTapFiltro,
                      child: const Row(
                        children: [
                          Text(
                            "Filtro",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.filter_alt),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Historial de Asesorías",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 220,
                          child: TextField(
                            onChanged: onChanged,
                            decoration: _buscadorDecoration(),
                          ),
                        ),
                        const SizedBox(width: 15),
                        IconButton(
                          onPressed: onTapFiltro,
                          icon: const Icon(Icons.filter_alt),
                        ),
                      ],
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
    hintText: 'Buscar...',
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
