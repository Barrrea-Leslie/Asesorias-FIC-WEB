import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/estudiantes/carga_nuevo_estudiante.dart';
import 'package:asesorias_fic/presentation/rol_administrador/estudiantes/crear_estudiantes.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_estudiante_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as fp;

class Estudiantes extends StatefulWidget {
  const Estudiantes({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  State<Estudiantes> createState() => _EstudiantesState();
}

class _EstudiantesState extends State<Estudiantes> {
  String query = '';
  String? filtroAnio;
  String? filtroCarrera;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva(
            query: query,
            filtroAnio: filtroAnio,
            filtroCarrera: filtroCarrera,
            onChanged: (v) => setState(() => query = v),
            onAnioChanged: (v) => setState(() => filtroAnio = v),
            onCarreraChanged: (v) => setState(() => filtroCarrera = v),
          );
        } else {
          return PantallaGrande(
            query: query,
            filtroAnio: filtroAnio,
            filtroCarrera: filtroCarrera,
            onChanged: (v) => setState(() => query = v),
            onAnioChanged: (v) => setState(() => filtroAnio = v),
            onCarreraChanged: (v) => setState(() => filtroCarrera = v),
            mostrarTitulo: widget.mostrarTitulo,
          );
        }
      },
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  final String query;
  final String? filtroAnio;
  final String? filtroCarrera;
  final ValueChanged<String> onChanged;
  final ValueChanged<String?> onAnioChanged;
  final ValueChanged<String?> onCarreraChanged;

  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.onChanged,
    required this.onAnioChanged,
    required this.onCarreraChanged,
    this.filtroAnio,
    this.filtroCarrera,
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    TextField(
                      onChanged: onChanged,
                      decoration: _buscadorDecoration('Buscar Estudiantes'),
                    ),
                    const SizedBox(height: 8),
                    _FiltrosDropdowns(
                      filtroAnio: filtroAnio,
                      filtroCarrera: filtroCarrera,
                      onAnioChanged: onAnioChanged,
                      onCarreraChanged: onCarreraChanged,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TarjetaEstudianteWidget(
                        query: query,
                        filtroAnio: filtroAnio,
                        filtroCarrera: filtroCarrera,
                      ),
                    ],
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
  final String query;
  final String? filtroAnio;
  final String? filtroCarrera;
  final ValueChanged<String> onChanged;
  final ValueChanged<String?> onAnioChanged;
  final ValueChanged<String?> onCarreraChanged;
  final bool mostrarTitulo;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.onChanged,
    required this.onAnioChanged,
    required this.onCarreraChanged,
    this.filtroAnio,
    this.filtroCarrera,
    this.mostrarTitulo = false,
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
                    if (mostrarTitulo)
                      SeccionArribaPantallaGrande(
                        onChanged: onChanged,
                        onAnioChanged: onAnioChanged,
                        onCarreraChanged: onCarreraChanged,
                        filtroAnio: filtroAnio,
                        filtroCarrera: filtroCarrera,
                      ),
                    if (!mostrarTitulo)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Column(
                          children: [
                            TextField(
                              onChanged: onChanged,
                              decoration: _buscadorDecoration(
                                'Buscar Estudiante',
                              ),
                            ),
                            const SizedBox(height: 8),
                            _FiltrosDropdowns(
                              filtroAnio: filtroAnio,
                              filtroCarrera: filtroCarrera,
                              onAnioChanged: onAnioChanged,
                              onCarreraChanged: onCarreraChanged,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TarjetaEstudianteWidget(
                              query: query,
                              filtroAnio: filtroAnio,
                              filtroCarrera: filtroCarrera,
                            ),
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
  final ValueChanged<String?> onAnioChanged;
  final ValueChanged<String?> onCarreraChanged;
  final String? filtroAnio;
  final String? filtroCarrera;

  const SeccionArribaPantallaGrande({
    super.key,
    required this.onChanged,
    required this.onAnioChanged,
    required this.onCarreraChanged,
    this.filtroAnio,
    this.filtroCarrera,
  });

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
                        "Estudiantes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: onChanged,
                        decoration: _buscadorDecoration('Buscar Estudiante'),
                      ),
                      const SizedBox(height: 8),
                      _FiltrosDropdowns(
                        filtroAnio: filtroAnio,
                        filtroCarrera: filtroCarrera,
                        onAnioChanged: onAnioChanged,
                        onCarreraChanged: onCarreraChanged,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Estudiantes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: 220,
                            child: TextField(
                              onChanged: onChanged,
                              decoration: _buscadorDecoration(
                                'Buscar Estudiante',
                              ),
                            ),
                          ),
                          _FiltrosDropdowns(
                            filtroAnio: filtroAnio,
                            filtroCarrera: filtroCarrera,
                            onAnioChanged: onAnioChanged,
                            onCarreraChanged: onCarreraChanged,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _FiltrosDropdowns extends StatefulWidget {
  final String? filtroAnio;
  final String? filtroCarrera;
  final ValueChanged<String?> onAnioChanged;
  final ValueChanged<String?> onCarreraChanged;

  const _FiltrosDropdowns({
    required this.filtroAnio,
    required this.filtroCarrera,
    required this.onAnioChanged,
    required this.onCarreraChanged,
  });

  @override
  State<_FiltrosDropdowns> createState() => _FiltrosDropdownsState();
}

class _FiltrosDropdownsState extends State<_FiltrosDropdowns> {
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

      final gruposFijos = [
        '1-1',
        '1-2',
        '2-1',
        '2-2',
        '3-1',
        '3-2',
        '4-1',
        '4-2',
        '4-3',
      ];

      final carrerasFijas = [
        "Licenciatura en informatica",
        "Licenciatura en informatica virtual",
        "Licenciatura en ingenieria en ciencias de datos",
        "Licenciatura en ITSE",
      ];

      final aniosSet = <String>{};
      final carrerasSet = <String>{};

      for (final e in estudiantes) {
        aniosSet.add(e.grupo);
        carrerasSet.add(e.licenciatura);
      }

      aniosSet.addAll(gruposFijos);
      carrerasSet.addAll(carrerasFijas);

      setState(() {
        _anios = aniosSet.toList()..sort();
        _carreras = carrerasSet.toList()..sort();
        _cargando = false;
      });
    } catch (_) {
      setState(() => _cargando = false);
    }
  }

  InputDecoration _dropdownDeco() => InputDecoration(
    filled: true,
    fillColor: const Color(0xFFf2f3f5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return Wrap(
      spacing: 10,
      children: [
        SizedBox(
          width: 120,
          height: 48,
          child: InputDecorator(
            decoration: _dropdownDeco(),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.filtroAnio,
                isExpanded: true,
                hint: const Text('Grupo'),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Todos'),
                  ),
                  ..._anios.map(
                    (a) => DropdownMenuItem<String>(value: a, child: Text(a)),
                  ),
                ],
                onChanged: widget.onAnioChanged,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 48,
          child: InputDecorator(
            decoration: _dropdownDeco(),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.filtroCarrera,
                isExpanded: true,
                hint: const Text('Carrera'),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Todas'),
                  ),
                  ..._carreras.map(
                    (c) => DropdownMenuItem<String>(
                      value: c,
                      child: Text(c, overflow: TextOverflow.ellipsis),
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

InputDecoration _buscadorDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
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

class FooterCrearAlumno extends StatelessWidget {
  const FooterCrearAlumno({super.key});

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

                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.white,

                    content: Container(
                      width: 400,
                      height: 300,
                      color: Colors.white,
                      child: const CargaNuevoEstudiante(),
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
            child: const Text("Crear Estudiante"),
          ),
        ],
      ),
    );
  }
}
