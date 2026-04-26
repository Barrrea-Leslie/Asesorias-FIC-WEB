import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/asesorias_service.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesoriasEnCurso/material_adicional.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

import '../rol_administrador/asesoriasEnCurso/informacion_asesorias_en_curso.dart';

class TarjetaAsesoriasWidget extends StatelessWidget {
  const TarjetaAsesoriasWidget({super.key, this.query = ''});

  final String query;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        AsesoriasService().getAsesorias(),
        EstudiantesService().getEstudiantes(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar las asesorías'));
        }

        final asesoriasRaw = snapshot.data![0] as List<Asesorias>;
        final estudiantes = snapshot.data![1] as List<Estudiantes>;

        final Map<int, Estudiantes> estudiantesMap = {
          for (var e in estudiantes) e.id: e,
        };

        final asesoriasFiltradas = asesoriasRaw.where((ase) {
          final nombreEstudiante =
              estudiantesMap[ase.idEstudiante]?.nombre.toLowerCase() ?? '';
          final materia = ase.materia.toLowerCase();
          final search = query.toLowerCase();
          return materia.contains(search) || nombreEstudiante.contains(search);
        }).toList();

        return ListaAsesorias(
          listaAsesorias: asesoriasFiltradas,
          listaEstudiantes: estudiantes,
        );
      },
    );
  }
}

class ListaAsesorias extends StatelessWidget {
  const ListaAsesorias({
    super.key,
    required this.listaAsesorias,
    required this.listaEstudiantes,
  });

  final List<Asesorias> listaAsesorias;
  final List<Estudiantes> listaEstudiantes;

  final double anchoTarjeta = 360.0;

  @override
  Widget build(BuildContext context) {
    final Map<int, Estudiantes> estudiantesPorId = {
      for (var e in listaEstudiantes) e.id: e,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: listaAsesorias.map((asesorias) {
              final estudiante = estudiantesPorId[asesorias.idEstudiante];
              final String nombreAMostrar =
                  estudiante?.nombre ?? "Estudiante no encontrado";

              final double ancho = constraints.maxWidth < 600
                  ? double.infinity
                  : anchoTarjeta;

              return SizedBox(
                width: ancho,
                child: Card(
                  color: Appcolores.azulUas,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 30,
                      right: 30,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Alumno: $nombreAMostrar',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Materia: ${asesorias.materia}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Inicio: ${asesorias.fechaInicio}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Horario: ${asesorias.horario}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Modalidad: ${asesorias.modalidad}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: BotonInfo(asesoria: asesorias)),
                            const SizedBox(width: 10),
                            Expanded(child: BotonCompletada()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        BotonMaterial(nombreAsesor: asesorias.materia),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class BotonInfo extends StatelessWidget {
  const BotonInfo({super.key, required this.asesoria});

  final Asesorias asesoria;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => InformacionAsesoriaEnCurso(asesoria: asesoria),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 45),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        backgroundColor: Appcolores.azulClaro,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Text('Informacion'),
    );
  }
}

class BotonMaterial extends StatelessWidget {
  final String nombreAsesor;
  const BotonMaterial({super.key, required this.nombreAsesor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) =>
              MaterialAdicionalAsesorias(nombreAsesor: nombreAsesor),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 45),
        backgroundColor: Appcolores.amarilloUas,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Text('Material adicional'),
    );
  }
}

class BotonCompletada extends StatelessWidget {
  const BotonCompletada({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => const AlertaCompletar(),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 45),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        backgroundColor: Appcolores.verdeClaro,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Text('Completada'),
    );
  }
}

class AlertaCompletar extends StatelessWidget {
  const AlertaCompletar({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmacion"),
      content: const Text("Esta seguro de completar la asesoria?"),
      contentPadding: const EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 143, 143, 143),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancelar"),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 74, 149, 86),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            MensajeConfirmacion.mostrarMensaje(
              context,
              "Se completo la tarea correctamente",
            );
          },
          child: const Text("Aceptar"),
        ),
      ],
    );
  }
}
