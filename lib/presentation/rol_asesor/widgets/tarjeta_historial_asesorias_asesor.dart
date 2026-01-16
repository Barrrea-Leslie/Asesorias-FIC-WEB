import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/asesorias_service.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesoriasEnCurso/informacion_asesorias_en_curso.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/asesoriasEnCurso/chat_estudiante.dart';
import 'package:flutter/material.dart';

class TarjetaHistorialAsesoriasAsesor extends StatelessWidget {
  const TarjetaHistorialAsesoriasAsesor({super.key, this.query = ''});

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
          return const Center(child: Text('Error al cargar el historial'));
        }

        final asesoriasRaw = snapshot.data![0] as List<Asesorias>;
        final estudiantes = snapshot.data![1] as List<Estudiantes>;
        final Map<int, Estudiantes> estudiantesMap = {for (var e in estudiantes) e.id: e};

        // Filtramos por búsqueda
        final asesoriasFiltradas = asesoriasRaw.where((ase) {
          final nombreEstudiante = estudiantesMap[ase.idEstudiante]?.nombre.toLowerCase() ?? '';
          final materia = ase.materia.toLowerCase();
          final search = query.toLowerCase();
          return materia.contains(search) || nombreEstudiante.contains(search);
        }).toList();

        return ListaHistorial(
          listaAsesorias: asesoriasFiltradas,
          listaEstudiantes: estudiantes,
        );
      },
    );
  }
}

class ListaHistorial extends StatelessWidget {
  const ListaHistorial({
    super.key,
    required this.listaAsesorias,
    required this.listaEstudiantes,
  });

  final List<Asesorias> listaAsesorias;
  final List<Estudiantes> listaEstudiantes;

  @override
  Widget build(BuildContext context) {
    final Map<int, Estudiantes> estudiantesPorId = {for (var e in listaEstudiantes) e.id: e};

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: listaAsesorias.map((asesoria) {
              final estudiante = estudiantesPorId[asesoria.idEstudiante];
              final String nombreAlumno = estudiante?.nombre ?? "Estudiante";

              return SizedBox(
                width: 360,
                height: 190, // Altura reducida ya que tiene menos botones
                child: Card(
                  color: Appcolores.azulUas,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alumno: $nombreAlumno', style: const TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 5),
                        Text('Materia: ${asesoria.materia}', style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 5),
                        Text('Fecha: ${asesoria.fechaInicio} - ${asesoria.fechaFin}', style: const TextStyle(color: Colors.white)),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Botón Información (Estilo amarillo/dorado según tu imagen)
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => InformacionAsesoriaEnCurso(asesoria: asesoria),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolores.azulClaro,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Informacion"),
                            ),
                            const SizedBox(width: 15),
                            // Botón Chat (Estilo blanco según tu imagen)
                            BotonChatHistorial(nombreAsesor: nombreAlumno),
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

class BotonChatHistorial extends StatefulWidget {
  final String nombreAsesor;
  const BotonChatHistorial({super.key, required this.nombreAsesor});

  @override
  State<BotonChatHistorial> createState() => _BotonChatHistorialState();
}

class _BotonChatHistorialState extends State<BotonChatHistorial> {
  OverlayEntry? _overlayEntry;

  void _mostrarChat() {
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        right: 20,
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
    return ElevatedButton.icon(
      onPressed: _mostrarChat,
      icon: const Icon(Icons.chat),
      label: const Text("Chat"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolores.amarilloUas,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}