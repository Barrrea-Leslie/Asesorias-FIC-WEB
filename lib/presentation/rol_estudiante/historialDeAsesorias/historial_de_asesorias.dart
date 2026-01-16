import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_historial_asesoria.dart';
import 'package:flutter/material.dart';

class HistorialDeAsesorias extends StatefulWidget {
  const HistorialDeAsesorias({super.key});

  @override
  State<HistorialDeAsesorias> createState() => _HistorialDeAsesoriasState();
}

class _HistorialDeAsesoriasState extends State<HistorialDeAsesorias> {
  String query = '';
  Map<String, String?> filtrosActivos = {};
  bool cargando = false; // Cambiado a false ya que la tarjeta tiene su propio FutureBuilder

  void _abrirFiltros() async {
    final resultado = await showDialog<Map<String, String?>>(
      context: context,
      builder: (context) => const FiltrosAsesoria(),
    );

    if (resultado != null) {
      setState(() {
        filtrosActivos = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000) {
        return PantallaResponsiva(
          query: query,
          filtros: filtrosActivos,
          onTapFiltro: _abrirFiltros,
          onChanged: (value) => setState(() => query = value),
        );
      } else {
        return PantallaGrande(
          query: query,
          filtros: filtrosActivos,
          onTapFiltro: _abrirFiltros,
          onChanged: (value) => setState(() => query = value),
        );
      }
    });
  }
}

class PantallaGrande extends StatelessWidget {
  final String query;
  final Map<String, String?> filtros;
  final VoidCallback onTapFiltro;
  final ValueChanged<String> onChanged;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
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
              SeccionArriba(onChanged: onChanged),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onTapFiltro,
                child: const Padding(
                  padding: EdgeInsets.only(left: 80.0, bottom: 20),
                  child: Row(
                    children: [
                      Text("Filtro", style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.filter_alt)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SingleChildScrollView(
                    child: TarjetaHistorialAsesoria(
                      query: query,     // PASAMOS EL QUERY
                      filtros: filtros, // PASAMOS LOS FILTROS
                    ),
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

class PantallaResponsiva extends StatelessWidget {
  final String query;
  final Map<String, String?> filtros;
  final VoidCallback onTapFiltro;
  final ValueChanged<String> onChanged;

  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
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
              SeccionArriba(onChanged: onChanged),
              // Agregado botón de filtro para móvil
              TextButton.icon(
                onPressed: onTapFiltro, 
                icon: const Icon(Icons.filter_list), 
                label: const Text("Filtrar")
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TarjetaHistorialAsesoria(
                          query: query,
                          filtros: filtros,
                        ),
                      ],
                    ),
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
  const SeccionArriba({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 20, right: 60.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Historial Asesorias",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
          SizedBox(
            width: 220,
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: 'Buscar por nombre...',
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
    );
  }
}