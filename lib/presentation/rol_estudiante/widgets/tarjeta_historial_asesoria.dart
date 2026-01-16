import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/asesoriasEnCurso/material_estudiante.dart';
import 'package:flutter/material.dart';

class TarjetaHistorialAsesoria extends StatelessWidget {
  const TarjetaHistorialAsesoria({
    super.key, 
    this.query = '', 
    this.filtros = const {}
  });

  final String query;
  final Map<String, String?> filtros;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        AsesoresParService().getAsesoresPar(),
        AsesoresDiciplinaresService().getAsesoresDiciplinares()
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final asesoresPar = snapshot.data![0] as List<AsesorPar>;
        final asesoresDiciplinares = snapshot.data![1] as List<AsesorDisciplinar>;
        final todos = [...asesoresPar, ...asesoresDiciplinares];

        // LÓGICA DE FILTRADO COMBINADA
        final listaFiltrada = todos.where((ase) {
          final item = ase as dynamic;
          
          // Filtro por nombre (Buscador)
          final matchesQuery = item.nombre.toLowerCase().contains(query.toLowerCase());
          
          // Filtro por Materia
          final matchesMateria = filtros['materia'] == null ||
              item.materiasAsesora.contains(filtros['materia']);
              
          // Filtro por Horario
          final matchesHorario = filtros['horario'] == null || 
              item.horariosAsesora.contains(filtros['horario']);

          return matchesQuery && matchesMateria && matchesHorario;
        }).toList();

        return ListaTarjetasHistorial(
          listaAsesoresPar: listaFiltrada.whereType<AsesorPar>().toList(),
          listaAsesoresDiciplinares: listaFiltrada.whereType<AsesorDisciplinar>().toList(),
        );
      },
    );
  }
}

class ListaTarjetasHistorial extends StatelessWidget {
  const ListaTarjetasHistorial({
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
    final todosLosAsesores = [...listaAsesoresPar, ...listaAsesoresDiciplinares];

    if (todosLosAsesores.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No se encontraron asesorías con esos criterios.", 
            style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: todosLosAsesores.map((asesor) {
              final item = asesor as dynamic;

              return SizedBox(
                width: anchoTarjeta,
                height: alturaTarjeta,
                child: Card(
                  color: Appcolores.azulUas,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nombre,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text("Materias: ${item.materiasAsesora.join(', ')}", 
                          style: const TextStyle(color: Colors.white70, fontSize: 13), 
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                        const Text("Modalidad: Presencial / Virtual", 
                          style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text("Horario: ${item.horariosAsesora.isNotEmpty ? item.horariosAsesora[0] : 'No asignado'}", 
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _BotonAccionHistorial(
                              texto: 'Ver info',
                              color: Appcolores.amarilloUas,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => _AlertaInformacionAsesor(asesor: item),
                                );
                              },
                            ),
                            const SizedBox(width: 15),
                            _BotonAccionHistorial(
                              texto: 'Material',
                              color: Appcolores.verdeClaro,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => MaterialAsesorModal(nombreAsesor: item.nombre),
                                );
                              },
                            ),
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

class _BotonAccionHistorial extends StatelessWidget {
  final String texto;
  final Color color;
  final VoidCallback onPressed;
  const _BotonAccionHistorial({required this.texto, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 3,
      ),
      child: Text(texto),
    );
  }
}

class _AlertaInformacionAsesor extends StatelessWidget {
  final dynamic asesor;
  const _AlertaInformacionAsesor({required this.asesor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(asesor.nombre, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _lineaInfo("Correo:", asesor.correoInstitucional),
            _lineaInfo("Teléfono:", asesor.numeroTelefono),
            _lineaInfo("Materias:", asesor.materiasAsesora.join(', ')),
            if (asesor.runtimeType.toString().contains('AsesorPar')) ...[
              _lineaInfo("Licenciatura:", asesor.licenciatura),
              _lineaInfo("Grupo:", asesor.grupo),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cerrar")),
      ],
    );
  }

  Widget _lineaInfo(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(etiqueta, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(valor, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}