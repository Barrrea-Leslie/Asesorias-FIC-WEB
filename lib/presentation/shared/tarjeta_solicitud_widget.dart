import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/models/solicitudes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/data/services/solicitudes_pendientes_service.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class TarjetaSolicitudWidget extends StatelessWidget {
  const TarjetaSolicitudWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        SolicitudesPendientesService().getSolicitudes(),
        EstudiantesService().getEstudiantes(),
      ]),
      // usa el service
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar las solicitudes'));
        }
        final solicitudes = snapshot.data![0] as List<SolicitudesPendientes>;
        final estudiantes = snapshot.data![1] as List<Estudiantes>;

        return ListaSolicitudes(
          listaSolicitudes: solicitudes,
          listaEstudiantes: estudiantes,
        );
      },
    );
  }
}

class ListaSolicitudes extends StatelessWidget {
  const ListaSolicitudes({
    super.key,
    required this.listaSolicitudes,
    required this.listaEstudiantes,
  });

  final List<SolicitudesPendientes> listaSolicitudes;
  final List<Estudiantes> listaEstudiantes;

  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 230.0;

  @override
  Widget build(BuildContext context) {
    final Map<int, Estudiantes> estudiantesPorId = {
      for (var e in listaEstudiantes) e.id: e,
    };

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 00),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 10,
            children: listaSolicitudes.map((solicitud) {
              final estudiante = estudiantesPorId[solicitud.idEstudiante];
              final double ancho = constraints.maxWidth < 600
                  ? double.infinity
                  : 360.0;

              return SizedBox(
                width: ancho,

                child: Card(
                  color: Appcolores.azulUas,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // <- importante, se ajusta al contenido
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alumno: ${estudiante?.nombre ?? "Estudiante no encontrado"}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Materia: ${solicitud.materia}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Fecha: ${solicitud.fechaInicio}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Horario: ${solicitud.horario}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Modalidad: ${solicitud.modalidad}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BotonRecahzar(),
                            const SizedBox(width: 20),
                            BotonAceptar(),
                          ],
                        ),
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

class BotonRecahzar extends StatelessWidget {
  const BotonRecahzar({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertaRechazar();
          },
        );
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolores.rojo,
        foregroundColor: Colors.white,
        elevation: 3,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
      ),

      child: Text('Rechazar'),
    );
  }
}

class BotonAceptar extends StatelessWidget {
  const BotonAceptar({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertaAceptar();
          },
        );
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolores.verdeClaro,
        foregroundColor: Colors.white,
        elevation: 3,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
      ),

      child: Text('Aceptar'),
    );
  }
}

class AlertaAceptar extends StatelessWidget {
  const AlertaAceptar({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmacion"),
      content: Text("Esta seguro de aceptar la solicitud?"),
      contentPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 143, 143, 143),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),

        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 74, 149, 86),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();

            MensajeConfirmacion.mostrarMensaje(
              context,
              "Se acepto la solicitud correctamente",
            );
          },
          child: Text("Aceptar"),
        ),
      ],
    );
  }
}

class AlertaRechazar extends StatelessWidget {
  const AlertaRechazar({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmacion"),
      content: Text("Esta seguro de rechazar la solicitud?"),
      contentPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 143, 143, 143),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),

        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 74, 149, 86),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();

            MensajeConfirmacion.mostrarMensaje(
              context,
              "Se rechazo la solicitud correctamente",
            );
          },
          child: Text("Aceptar"),
        ),
      ],
    );
  }
}
