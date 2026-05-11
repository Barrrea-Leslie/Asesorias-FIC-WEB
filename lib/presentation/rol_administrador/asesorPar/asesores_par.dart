import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/carga_nuevo_asesor_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/crear_asesor_par.dart';
import 'package:asesorias_fic/presentation/shared/tarjeta_asesor_par_widget.dart';
import 'package:flutter/material.dart';

class AsesoresPar extends StatefulWidget {
  const AsesoresPar({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  State<AsesoresPar> createState() => _AsesoresParState();
}

class _AsesoresParState extends State<AsesoresPar> {
  String query = '';
  String? filtroGrupo;
  String? filtroCarrera;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva(
            query: query,
            filtroGrupo: filtroGrupo,
            filtroCarrera: filtroCarrera,
            onChanged: (value) => setState(() => query = value),
            onGrupoChanged: (value) => setState(() => filtroGrupo = value),
            onCarreraChanged: (value) => setState(() => filtroCarrera = value),
          );
        } else {
          return PantallaGrande(
            query: query,
            filtroGrupo: filtroGrupo,
            filtroCarrera: filtroCarrera,
            onChanged: (value) => setState(() => query = value),
            onGrupoChanged: (value) => setState(() => filtroGrupo = value),
            onCarreraChanged: (value) => setState(() => filtroCarrera = value),
            mostrarTitulo: widget.mostrarTitulo,
          );
        }
      },
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  final String query;
  final String? filtroGrupo;
  final String? filtroCarrera;
  final ValueChanged<String> onChanged;
  final ValueChanged<String?> onGrupoChanged;
  final ValueChanged<String?> onCarreraChanged;

  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.onChanged,
    required this.onGrupoChanged,
    required this.onCarreraChanged,
    this.filtroGrupo,
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
                      decoration: _buscadorDecoration('Buscar Asesor'),
                    ),
                    const SizedBox(height: 8),
                    _FiltrosDropdowns(
                      filtroGrupo: filtroGrupo,
                      filtroCarrera: filtroCarrera,
                      onGrupoChanged: onGrupoChanged,
                      onCarreraChanged: onCarreraChanged,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TarjetaAsesorParWidget(
                        query: query,
                        filtroGrupo: filtroGrupo,
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
  final String? filtroGrupo;
  final String? filtroCarrera;
  final ValueChanged<String> onChanged;
  final ValueChanged<String?> onGrupoChanged;
  final ValueChanged<String?> onCarreraChanged;
  final bool mostrarTitulo;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.onChanged,
    required this.onGrupoChanged,
    required this.onCarreraChanged,
    this.filtroGrupo,
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
                        onGrupoChanged: onGrupoChanged,
                        onCarreraChanged: onCarreraChanged,
                        filtroGrupo: filtroGrupo,
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
                              decoration: _buscadorDecoration('Buscar Asesor'),
                            ),
                            const SizedBox(height: 8),
                            _FiltrosDropdowns(
                              filtroGrupo: filtroGrupo,
                              filtroCarrera: filtroCarrera,
                              onGrupoChanged: onGrupoChanged,
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
                            TarjetaAsesorParWidget(
                              query: query,
                              filtroGrupo: filtroGrupo,
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
  final ValueChanged<String?> onGrupoChanged;
  final ValueChanged<String?> onCarreraChanged;
  final String? filtroGrupo;
  final String? filtroCarrera;

  const SeccionArribaPantallaGrande({
    super.key,
    required this.onChanged,
    required this.onGrupoChanged,
    required this.onCarreraChanged,
    this.filtroGrupo,
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
                        "Asesores Par",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: onChanged,
                        decoration: _buscadorDecoration('Buscar Asesor'),
                      ),
                      const SizedBox(height: 8),
                      _FiltrosDropdowns(
                        filtroGrupo: filtroGrupo,
                        filtroCarrera: filtroCarrera,
                        onGrupoChanged: onGrupoChanged,
                        onCarreraChanged: onCarreraChanged,
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Asesores Par",
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
                              decoration: _buscadorDecoration('Buscar Asesor'),
                            ),
                          ),
                          _FiltrosDropdowns(
                            filtroGrupo: filtroGrupo,
                            filtroCarrera: filtroCarrera,
                            onGrupoChanged: onGrupoChanged,
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

class _FiltrosDropdowns extends StatelessWidget {
  final String? filtroGrupo;
  final String? filtroCarrera;
  final ValueChanged<String?> onGrupoChanged;
  final ValueChanged<String?> onCarreraChanged;

  const _FiltrosDropdowns({
    required this.filtroGrupo,
    required this.filtroCarrera,
    required this.onGrupoChanged,
    required this.onCarreraChanged,
  });

  InputDecoration _dropdownDeco() => InputDecoration(
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
  );

  @override
  Widget build(BuildContext context) {
    final grupos = [
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

    final carreras = [
      "Licenciatura en informatica",
      "Licenciatura en informatica virtual",
      "Licenciatura en ingenieria en ciencias de datos",
      "Licenciatura en ITSE",
    ];

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
                value: filtroGrupo,
                isExpanded: true,
                hint: const Text('Grupo'),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Todos'),
                  ),
                  ...grupos.map(
                    (g) => DropdownMenuItem<String>(value: g, child: Text(g)),
                  ),
                ],
                onChanged: onGrupoChanged,
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
                value: filtroCarrera,
                isExpanded: true,
                hint: const Text('Carrera'),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Todas'),
                  ),
                  ...carreras.map(
                    (c) => DropdownMenuItem<String>(
                      value: c,
                      child: Text(c, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
                onChanged: onCarreraChanged,
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
                      width: 400,
                      height: 300,
                      color: Colors.white,
                      child: const CargaNuevoAsesorPar(),
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
            child: const Text("Crear Asesor", style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
