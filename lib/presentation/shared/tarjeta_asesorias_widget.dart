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
        EstudiantesService().getEstudiantes()
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

        final Map<int, Estudiantes> estudiantesMap = {for (var e in estudiantes) e.id: e};

        final asesoriasFiltradas = asesoriasRaw.where((ase) {
          final nombreEstudiante = estudiantesMap[ase.idEstudiante]?.nombre.toLowerCase() ?? '';
          final materia = ase.materia.toLowerCase();
          final search = query.toLowerCase();
          
          return materia.contains(search) || nombreEstudiante.contains(search);
        }).toList();

        return ListaAsesorias(
          listaAsesorias: asesoriasFiltradas, 
          listaEstudiantes: estudiantes
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
  final double alturaTarjeta = 280.0;

  @override
  Widget build(BuildContext context) {
    final Map<int, Estudiantes> estudiantesPorId = {
      for (var e in listaEstudiantes) e.id: e
    };
    
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 10,
            children: listaAsesorias.map((asesorias) {
              final estudiante = estudiantesPorId[asesorias.idEstudiante];
              return SizedBox(
                width: anchoTarjeta,
                height: alturaTarjeta,
                child: Card(
                  color: Appcolores.azulUas,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Alumno: ${estudiante?.nombre ?? "Estudiante no encontrado"}', style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 5),
                            Text('Materia: ${asesorias.materia}', style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 5),
                            Text('Inicio: ${asesorias.fechaInicio}', style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 5),
                            Text('Horario: ${asesorias.horario}', style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 5),
                            Text('Modalidad: ${asesorias.modalidad}', style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BotonInfo(asesoria: asesorias),
                            const SizedBox(width: 20),
                            const BotonCompletada(),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BotonMaterial(nombreAsesor: asesorias.materia)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class BotonInfo extends StatelessWidget {
  const BotonInfo({
    super.key,
    required this.asesoria
  });

  final Asesorias asesoria;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // CAMBIO: Ahora abre un Dialog en lugar de navegar
        showDialog(
          context: context,
          builder: (context) => InformacionAsesoriaEnCurso(asesoria: asesoria),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 35),
        backgroundColor: Appcolores.azulClaro,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
      ),
      child: const Text('Informacion'),
    );
  }
}

// ... BotonMaterial, BotonCompletada y AlertaCompletar se mantienen igual ...
class BotonMaterial extends StatelessWidget {
  final String nombreAsesor;
  const BotonMaterial({super.key, required this.nombreAsesor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => MaterialAdicionalAsesorias(nombreAsesor: nombreAsesor),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 35),
        backgroundColor: Appcolores.amarilloUas,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
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
        showDialog(context: context, builder: (BuildContext context) => const AlertaCompletar());
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 35),
        backgroundColor: Appcolores.verdeClaro,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancelar")
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 74, 149, 86),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            MensajeConfirmacion.mostrarMensaje(context, "Se completo la tarea correctamente");
          },
          child: const Text("Aceptar")
        ),
      ],
    );
  }
}