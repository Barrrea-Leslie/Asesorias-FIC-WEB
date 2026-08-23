import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_vista_estudiante.dart';
import 'package:asesorias_fic/data/models/catalogos_model.dart';
import 'package:asesorias_fic/data/repositories/catalogos_repository.dart';
import 'package:asesorias_fic/data/services/asesores_service.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/crear_solicitud.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_solicitar_asesoria.dart';
import 'package:flutter/material.dart';

class SolicitarAsesoria extends StatefulWidget {
  const SolicitarAsesoria({super.key, this.mostrarTitulo = false});
  final bool mostrarTitulo;

  @override
  State<SolicitarAsesoria> createState() => _SolicitarAsesoriaState();
}

class _SolicitarAsesoriaState extends State<SolicitarAsesoria> {
  String query = '';
  Map<String, String?> filtrosActivos = {};
  List<asesores_vista_estudiante> todosLosAsesores = [];
  CatalogosModel? catalogos;
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarDatosIniciales();
  }

  // Carga de asesores y catálogos en paralelo
  Future<void> _cargarDatosIniciales() async {
    try {
      // 1. Ejecutamos ambas peticiones HTTP al mismo tiempo
      final resultados = await Future.wait([
        AsesoresService().obtenerAsesores(),
        CatalogosRepository().getCatalogos(),
      ]);

      // 2. Extraemos los resultados asignando su tipo de dato correspondiente
      final asesoresObtenidos = resultados[0] as List<asesores_vista_estudiante>;
      final catalogosObtenidos = resultados[1] as CatalogosModel;

      /*

      // 3. Imprimimos en la consola de desarrollador para verificar la llegada de datos
      print('==================================================');
      print('✅ DATOS CARGADOS DESDE EL BACKEND');
      print('Total de Asesores: ${asesoresObtenidos.length}');
      print('--------------------------------------------------');
      print('Razones de asesoría: ${catalogosObtenidos.razonAsesoria}');
      print('Modalidades disponibles: ${catalogosObtenidos.modalidades}');
      print('Total de materias en el catálogo: ${catalogosObtenidos.materias}');
      print('Total de horarios en el catálogo: ${catalogosObtenidos.horarios}');
      print('==================================================');

      */

      // 4. Guardamos los datos en el estado y desactivamos el indicador de carga
      setState(() {
        todosLosAsesores = asesoresObtenidos;
        catalogos = catalogosObtenidos;
        cargando = false;
      });
    } catch (e) {
      // 5. En caso de error, mostramos el detalle en la consola
      /*
      print('==================================================');
      print('❌ ERROR AL OBTENER DATOS DE LA API:');
      print(e);
      print('==================================================');
      */
      setState(() => cargando = false);
    }
  }

  void _abrirFiltros() async {
    final resultado = await showDialog<Map<String, String?>>(
      context: context,
      builder: (context) => FiltrosAsesoria(catalogos: catalogos),
    );
    if (resultado != null) {
      setState(() {
        filtrosActivos = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva(
            query: query,
            filtros: filtrosActivos,
            onTapFiltro: _abrirFiltros,
            todosLosAsesores: todosLosAsesores,
            catalogos: catalogos,
            onChanged: (value) => setState(() => query = value),
          );
        } else {
          return PantallaGrande(
            query: query,
            filtros: filtrosActivos,
            onTapFiltro: _abrirFiltros,
            todosLosAsesores: todosLosAsesores,
            catalogos: catalogos,
            mostrarTitulo: widget.mostrarTitulo,
            onChanged: (value) => setState(() => query = value),
          );
        }
      },
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  final String query;
  final Map<String, String?> filtros;
  final VoidCallback onTapFiltro;
  final List<asesores_vista_estudiante> todosLosAsesores;
  final CatalogosModel? catalogos;
  final ValueChanged<String> onChanged;

  const PantallaResponsiva({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
    required this.todosLosAsesores,
    required this.catalogos,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UasColores.azulOficial,
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: onChanged,
                        decoration: _buscadorDecoration(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.filter_alt, color: UasColores.azulOficial),
                      onPressed: onTapFiltro,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TarjetaSolicitarAsesoria(
                        query: query,
                        filtros: filtros,
                        todosLosAsesores: todosLosAsesores,
                        catalogos: catalogos,
                      ),
                    ],
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
  final VoidCallback onTapFiltro;
  final List<asesores_vista_estudiante> todosLosAsesores;
  final CatalogosModel? catalogos;
  final ValueChanged<String> onChanged;
  final bool mostrarTitulo;

  const PantallaGrande({
    super.key,
    required this.query,
    required this.filtros,
    required this.onTapFiltro,
    required this.todosLosAsesores,
    required this.catalogos,
    required this.onChanged,
    this.mostrarTitulo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UasColores.azulOficial,
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
                    
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: onTapFiltro,
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                    "Filtro",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.filter_alt, size: 20),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          SizedBox(
                            width: 250,
                            child: TextField(
                              onChanged: onChanged,
                              decoration: _buscadorDecoration(),
                            ),
                          ),
                          const Spacer(),

                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => CrearSolicitud(
                                  todosLosAsesores: todosLosAsesores,
                                  catalogos: catalogos,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolores.verdeClaro,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Crear Solicitud",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Expanded(
                      child: SingleChildScrollView(
                        child: TarjetaSolicitarAsesoria(
                          query: query,
                          filtros: filtros,
                          todosLosAsesores: todosLosAsesores,
                          catalogos: catalogos,
                        ),
                      ),
                    ),
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
  const SeccionArribaPantallaGrande({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 60.0, top: 20, right: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Solicitar Asesorías",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ],
      ),
    );
  }
}

InputDecoration _buscadorDecoration() {
  return InputDecoration(
    hintText: 'Buscar Asesor',
    hintStyle: const TextStyle(fontSize: 15, color: Color(0xFFb4b4b4)),
    prefixIcon: const Icon(Icons.search, color: Color(0xFFb4b4b4), size: 18),
    filled: true,
    fillColor: const Color(0xFFf2f3f5),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: UasColores.azulOficial),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}