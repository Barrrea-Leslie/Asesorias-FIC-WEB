import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_vista_estudiante.dart';
import 'package:asesorias_fic/data/models/catalogos_model.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/solicitar_asesoria_directa.dart';
import 'package:flutter/material.dart';

class TarjetaSolicitarAsesoria extends StatelessWidget {
  final String query;
  final Map<String, String?> filtros;
  final List<asesores_vista_estudiante> todosLosAsesores;
  final CatalogosModel? catalogos;

  const TarjetaSolicitarAsesoria({
    super.key,
    this.query = '',
    this.filtros = const {},
    required this.todosLosAsesores,
    this.catalogos,
  });

  @override
  Widget build(BuildContext context) {
    final listaFiltrada = todosLosAsesores.where((asesor) {
      final nombreCompleto =
          '${asesor.nombre} ${asesor.apellidoPaterno} ${asesor.apellidoMaterno}'
              .toLowerCase();
      final matchesQuery = nombreCompleto.contains(query.toLowerCase());

      final matchesMateria =
          filtros['materia'] == null ||
          asesor.materiasList.contains(filtros['materia']);

      final matchesHorario =
          filtros['horario'] == null ||
          asesor.horariosList.contains(filtros['horario']);

      return matchesQuery && matchesMateria && matchesHorario;
    }).toList();

    return ListaTarjetasSolicitar(
      listaAsesores: listaFiltrada,
      catalogos: catalogos,
    );
  }
}

class ListaTarjetasSolicitar extends StatelessWidget {
  final List<asesores_vista_estudiante> listaAsesores;
  final CatalogosModel? catalogos;

  const ListaTarjetasSolicitar({
    super.key,
    required this.listaAsesores,
    this.catalogos,
  });

  @override
  Widget build(BuildContext context) {
    if (listaAsesores.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "No se encontraron asesores.",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: listaAsesores.map((asesor) {
              final inicial = asesor.nombre.isNotEmpty
                  ? asesor.nombre[0].toUpperCase()
                  : 'A';

              return Container(
                width: 360.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              UasColores.azulOficial.withOpacity(0.12),
                          child: Text(
                            inicial,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: UasColores.azulOficial,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            '${asesor.nombre} ${asesor.apellidoPaterno}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      asesor.correo,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Materias: ${asesor.materiasList.join(', ')}",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BotonInformacion(asesor: asesor),
                        const SizedBox(width: 12),
                        BotonSolicitar(
                          asesor: asesor,
                          catalogos: catalogos,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class BotonInformacion extends StatelessWidget {
  final asesores_vista_estudiante asesor;

  const BotonInformacion({super.key, required this.asesor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _AlertaInformacionAsesor(asesor: asesor);
          },
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(90, 36),
        backgroundColor: Appcolores.amarilloUas,
        foregroundColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Ver Info',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BotonSolicitar extends StatelessWidget {
  final asesores_vista_estudiante asesor;
  final CatalogosModel? catalogos;

  const BotonSolicitar({
    super.key,
    required this.asesor,
    this.catalogos,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SolicitarAsesoriaDirecta(
            asesor: asesor,
            catalogos: catalogos,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(130, 36),
        backgroundColor: Appcolores.verdeClaro,
        foregroundColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Solicitar Asesoría',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _AlertaInformacionAsesor extends StatelessWidget {
  final asesores_vista_estudiante asesor;

  const _AlertaInformacionAsesor({required this.asesor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: SizedBox(
        width: 370,
        child: Center(
          child: Text(
            '${asesor.nombre} ${asesor.apellidoPaterno} ${asesor.apellidoMaterno}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _lineaInfo("Correo:", asesor.correo),
            _lineaInfo("Materias:", asesor.materiasList.join(', ')),
            _lineaInfo("Horarios:", asesor.horariosList.join('\n')),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Appcolores.azulUas,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cerrar"),
        ),
      ],
    );
  }

  Widget _lineaInfo(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            etiqueta,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black,
            ),
          ),
          Text(
            valor.isEmpty ? 'No especificado' : valor,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}