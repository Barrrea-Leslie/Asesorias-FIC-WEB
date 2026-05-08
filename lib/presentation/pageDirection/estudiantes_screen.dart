import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/shared/mydrawer.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_estudiante_widget.dart';
import 'package:flutter/material.dart';

class EstudiantesScreen extends StatelessWidget {
  const EstudiantesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1000) {
          return const PantallaResponsiva();
        } else {
          return const PantallaGrande();
        }
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Pantalla responsiva (móvil)
// ---------------------------------------------------------------------------
class PantallaResponsiva extends StatefulWidget {
  const PantallaResponsiva({super.key});

  @override
  State<PantallaResponsiva> createState() => _PantallaResponsivaState();
}

class _PantallaResponsivaState extends State<PantallaResponsiva> {
  String _query = '';
  String? _filtroAnio;
  String? _filtroCarrera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            icon: const Icon(Icons.menu, size: 30.0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'Estudiantes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Mydrawer(rutaActual: '/estudiantes'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Barra de búsqueda + filtros para móvil
            _BarraBusquedaFiltros(
              onQueryChanged: (v) => setState(() => _query = v),
              onAnioChanged: (v) => setState(() => _filtroAnio = v),
              onCarreraChanged: (v) => setState(() => _filtroCarrera = v),
              filtroAnio: _filtroAnio,
              filtroCarrera: _filtroCarrera,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: TarjetaEstudianteWidget(
                  query: _query,
                  filtroAnio: _filtroAnio,
                  filtroCarrera: _filtroCarrera,
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

// ---------------------------------------------------------------------------
// Pantalla grande (escritorio)
// ---------------------------------------------------------------------------
class PantallaGrande extends StatefulWidget {
  const PantallaGrande({super.key});

  @override
  State<PantallaGrande> createState() => _PantallaGrandeState();
}

class _PantallaGrandeState extends State<PantallaGrande> {
  String _query = '';
  String? _filtroAnio;
  String? _filtroCarrera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Mydrawer(rutaActual: '/estudiantes'),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SeccionArribaPantallaGrande(
                      onQueryChanged: (v) => setState(() => _query = v),
                      onAnioChanged: (v) => setState(() => _filtroAnio = v),
                      onCarreraChanged: (v) =>
                          setState(() => _filtroCarrera = v),
                      filtroAnio: _filtroAnio,
                      filtroCarrera: _filtroCarrera,
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: TarjetaEstudianteWidget(
                          query: _query,
                          filtroAnio: _filtroAnio,
                          filtroCarrera: _filtroCarrera,
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

// ---------------------------------------------------------------------------
// Sección superior (pantalla grande): buscador + dropdowns
// ---------------------------------------------------------------------------
class SeccionArribaPantallaGrande extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String?> onAnioChanged;
  final ValueChanged<String?> onCarreraChanged;
  final String? filtroAnio;
  final String? filtroCarrera;

  const SeccionArribaPantallaGrande({
    super.key,
    required this.onQueryChanged,
    required this.onAnioChanged,
    required this.onCarreraChanged,
    this.filtroAnio,
    this.filtroCarrera,
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
            const Text(
              "Off",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(width: 15),
            // Barra de búsqueda + filtros
            _BarraBusquedaFiltros(
              onQueryChanged: onQueryChanged,
              onAnioChanged: onAnioChanged,
              onCarreraChanged: onCarreraChanged,
              filtroAnio: filtroAnio,
              filtroCarrera: filtroCarrera,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widget reutilizable: TextField de búsqueda + dos DropdownButton de filtro
// Los valores de los dropdowns se cargan dinámicamente desde el servicio.
// ---------------------------------------------------------------------------
class _BarraBusquedaFiltros extends StatefulWidget {
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String?> onAnioChanged;
  final ValueChanged<String?> onCarreraChanged;
  final String? filtroAnio;
  final String? filtroCarrera;

  const _BarraBusquedaFiltros({
    required this.onQueryChanged,
    required this.onAnioChanged,
    required this.onCarreraChanged,
    this.filtroAnio,
    this.filtroCarrera,
  });

  @override
  State<_BarraBusquedaFiltros> createState() => _BarraBusquedaFiltrosState();
}

class _BarraBusquedaFiltrosState extends State<_BarraBusquedaFiltros> {
  List<String> _anios = [];
  List<String> _carreras = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarOpciones();
  }

  Future<void> _cargarOpciones() async {
    try {
      final estudiantes = await EstudiantesService().getEstudiantes();

      final aniosSet = <String>{};
      final carrerasSet = <String>{};

      for (final e in estudiantes) {
        final anio = e.grupo.split('-').first;
        aniosSet.add(anio);
        carrerasSet.add(e.licenciatura);
      }

      final aniosOrdenados = aniosSet.toList()..sort();
      final carrerasOrdenadas = carrerasSet.toList()..sort();

      setState(() {
        _anios = aniosOrdenados;
        _carreras = carrerasOrdenadas;
        _cargando = false;
      });
    } catch (_) {
      setState(() => _cargando = false);
    }
  }

  InputDecoration _inputDeco(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFb4b4b4)),
    filled: true,
    fillColor: const Color(0xFFf2f3f5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return const SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // --- Buscador por nombre ---
        SizedBox(
          width: 220,
          height: 42,
          child: TextField(
            onChanged: widget.onQueryChanged,
            decoration: _inputDeco('Buscar Estudiante').copyWith(
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFFb4b4b4),
                size: 18,
              ),
            ),
          ),
        ),

        // --- Filtro por año ---
        SizedBox(
          width: 130,
          height: 42,
          child: InputDecorator(
            decoration: _inputDeco(''),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.filtroAnio,
                isExpanded: true,
                hint: const Text(
                  'Año',
                  style: TextStyle(fontSize: 12, color: Color(0xFFb4b4b4)),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFb4b4b4),
                  size: 18,
                ),
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Todos', style: TextStyle(fontSize: 12)),
                  ),
                  ..._anios.map(
                    (a) => DropdownMenuItem<String>(
                      value: a,
                      child: Text(
                        'Año $a',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
                onChanged: widget.onAnioChanged,
              ),
            ),
          ),
        ),

        // --- Filtro por carrera ---
        SizedBox(
          width: 220,
          height: 42,
          child: InputDecorator(
            decoration: _inputDeco(''),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.filtroCarrera,
                isExpanded: true,
                hint: const Text(
                  'Carrera',
                  style: TextStyle(fontSize: 12, color: Color(0xFFb4b4b4)),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFb4b4b4),
                  size: 18,
                ),
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Todas', style: TextStyle(fontSize: 12)),
                  ),
                  ..._carreras.map(
                    (c) => DropdownMenuItem<String>(
                      value: c,
                      child: Text(
                        c,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
                onChanged: widget.onCarreraChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.verdeClaro,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
            ),
            child: const Text(
              "Crear Estudiante",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
