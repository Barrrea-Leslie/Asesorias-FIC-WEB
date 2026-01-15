/* import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/asesoriasEnCurso/chat_estudiante.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/asesoriasEnCurso/material_estudiante.dart';
import 'package:flutter/material.dart';

class TarjetaAsesoriasEstudiante extends StatelessWidget {
  const TarjetaAsesoriasEstudiante({super.key, this.query = ''});

  final String query;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        AsesoresParService().getAsesoresPar(),

        AsesoresDiciplinaresService().getAsesoresDiciplinares(),
      ]),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los asesores'));
        }

        final asesoresPar = snapshot.data![0] as List<AsesorPar>;

        final asesoresDiciplinares =
            snapshot.data![1] as List<AsesorDisciplinar>;

        final asesoresParFiltrados = asesoresPar.where((ase) {
          final nombreAsesor = ase.nombre.toLowerCase();

          final search = query.toLowerCase();

          return nombreAsesor.contains(search);
        }).toList();

        final asesoresDiciplinaresFiltrados = asesoresDiciplinares.where((ase) {
          final nombreAsesor = ase.nombre.toLowerCase();

          final search = query.toLowerCase();

          return nombreAsesor.contains(search);
        }).toList();

        return ListaTarjetasSolicitar(
          listaAsesoresPar: asesoresParFiltrados,

          listaAsesoresDiciplinares: asesoresDiciplinaresFiltrados,
        );
      },
    );
  }
}

class ListaTarjetasSolicitar extends StatelessWidget {
  const ListaTarjetasSolicitar({
    super.key,

    required this.listaAsesoresPar,

    required this.listaAsesoresDiciplinares,
  });

  final List<dynamic> listaAsesoresPar;

  final List<dynamic> listaAsesoresDiciplinares;

  final double anchoTarjeta = 360.0;

  final double alturaTarjeta = 200.0;

  @override
  Widget build(BuildContext context) {
    final todosLosAsesores = [
      ...listaAsesoresPar,
      ...listaAsesoresDiciplinares,
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 00),

      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,

            runSpacing: 10,

            children: todosLosAsesores.map((asesor) {
              final item = asesor as dynamic;

              return SizedBox(
                width: anchoTarjeta,

                height: alturaTarjeta,

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

                      spacing: 5,

                      children: [
                        Text(
                          item.nombre,
                          style: TextStyle(color: Colors.white),
                        ),

                        Text(
                          "Materias: ${item.materiasAsesora.join(', ')}",
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),

                        Text(
                          "Modalidad: Presencial / Virtual",
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),

                        const SizedBox(height: 20),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            BotonChat(nombreAsesor: item.nombre,),

                            SizedBox(width: 20),

                            BotonMaterial(nombreAsesor: item.nombre,),
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

class BotonChat extends StatefulWidget {
  final String nombreAsesor;
  const BotonChat({super.key, required this.nombreAsesor});

  @override
  State<BotonChat> createState() => _BotonChatState();
}

class _BotonChatState extends State<BotonChat> {
  OverlayEntry? _overlayEntry;

  void _mostrarChat() {
    if (_overlayEntry != null) return; // Si ya está abierto, no hacer nada

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20, // Distancia desde abajo
        right: 20,  // Distancia desde la derecha (estilo Facebook)
        child: ChatEstudiante(
          nombreAsesor: widget.nombreAsesor,
          onCerrar: _cerrarChat,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _cerrarChat() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _mostrarChat,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 35),
        backgroundColor: Appcolores.amarilloUas,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Row(
        children: [
          Icon(Icons.chat),
          SizedBox(width: 10),
          Text('Chat'),
        ],
      ),
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
          builder: (context) => MaterialAsesorModal(nombreAsesor: nombreAsesor),
        );
      },

      style: ElevatedButton.styleFrom(
        minimumSize: Size(30, 35),

        backgroundColor: Appcolores.azulClaro,

        foregroundColor: Colors.white,

        elevation: 3,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
      ),

      child: Text('Material'),
    );
  }
}
 */