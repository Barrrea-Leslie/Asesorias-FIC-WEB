import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/crear_solicitud.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_solicitar_asesoria.dart';
import 'package:flutter/material.dart';

class SolicitarAsesoria extends StatefulWidget {
  const SolicitarAsesoria({super.key});

  @override
  State<SolicitarAsesoria> createState() => _SolicitarAsesoriaState();
}

class _SolicitarAsesoriaState extends State<SolicitarAsesoria> {
  String query = '';
  Map<String, String?> filtrosActivos = {};
  List<dynamic> todosLosAsesores = [];
  bool cargando = true;

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
  void initState() {
    super.initState();
    _fetchAsesores();
  }

  Future<void> _fetchAsesores() async {
    try {
      final resultados = await Future.wait([
        AsesoresParService().getAsesoresPar(),
        AsesoresDiciplinaresService().getAsesoresDiciplinares()
      ]);
      setState(() {
        todosLosAsesores = [...resultados[0], ...resultados[1]];
        cargando = false;
      });
    } catch (e) {
      setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000) {
        return PantallaResponsiva(
          query: query,
          filtros: filtrosActivos,
          onTapFiltro: _abrirFiltros,
          todosLosAsesores: todosLosAsesores,
          onChanged: (value) => setState(() => query = value),
        );
      } else {
        return PantallaGrande(
          query: query,
          filtros: filtrosActivos,
          onTapFiltro: _abrirFiltros,
          todosLosAsesores: todosLosAsesores,
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
  final List<dynamic> todosLosAsesores;
  final ValueChanged<String> onChanged;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
    required this.todosLosAsesores,
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
                child: SingleChildScrollView(
                  child: TarjetaSolicitarAsesoria(query: query, filtros: filtros),
                ),
              ),
              Footer(todosLosAsesores: todosLosAsesores),
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
  final List<dynamic> todosLosAsesores;
  final ValueChanged<String> onChanged;

  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
    required this.todosLosAsesores,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TarjetaSolicitarAsesoria(query: query, filtros: filtros),
                    ],
                  ),
                ),
              ),
              Footer(todosLosAsesores: todosLosAsesores),
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
          const Text("Solicitar Asesorias",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
          SizedBox(
            width: 220,
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: 'Buscar Asesoria',
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

class Footer extends StatelessWidget {
  final List<dynamic> todosLosAsesores;
  const Footer({super.key, required this.todosLosAsesores});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CrearSolicitud(todosLosAsesores: todosLosAsesores),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.verdeClaro,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Crear Solicitud", 
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}