import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/solicitudes_en_revision.dart';
import 'package:asesorias_fic/data/services/solicitudes_en_revision_service.dart';
import 'package:flutter/material.dart';

class TarjetaSolicitudesEnRevision extends StatelessWidget {
  final String filtro; // Recibe el filtro seleccionado

  const TarjetaSolicitudesEnRevision({super.key, required this.filtro});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SolicitudesEnRevision>>(
      future: SolicitudesEnRevisionService().getSolicitudesRevision(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar las asesorías'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay solicitudes registradas'));
        }

        List<SolicitudesEnRevision> solicitudesCargadas = snapshot.data!;
        
        // LÓGICA DE FILTRADO
        List<SolicitudesEnRevision> listaFiltrada;
        if (filtro == "TODO") {
          listaFiltrada = solicitudesCargadas;
        } else {
          listaFiltrada = solicitudesCargadas
              .where((s) => s.estado.toUpperCase() == filtro.toUpperCase())
              .toList();
        }

        if (listaFiltrada.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text('No hay solicitudes con este estado'),
            ),
          );
        }

        return ListaSolicitudesEnRevision(
          listaSolicitudes: listaFiltrada,
        );
      },
    );
  }
}

class ListaSolicitudesEnRevision extends StatelessWidget {
  const ListaSolicitudesEnRevision({super.key, required this.listaSolicitudes});

  final List<SolicitudesEnRevision> listaSolicitudes;
  final double anchoTarjeta = 340.0;
  final double alturaTarjeta = 220.0;

  Color _obtenerColorTextoEstado(String estado) {
    switch (estado.toUpperCase()) {
      case 'EN REVISION':
        return Colors.orangeAccent;
      case 'RECHAZADA':
        return Colors.redAccent;
      case 'CAMBIO SUGERIDO':
        return Colors.lightBlueAccent;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 10,
            children: listaSolicitudes.map((solicitud) {
              return SizedBox(
                width: anchoTarjeta,
                height: alturaTarjeta,
                child: Card(
                  color: Appcolores.azulUas,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Materia: ${solicitud.materia}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Asesor: ${solicitud.asesor}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Fecha: ${solicitud.fecha}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Horario: ${solicitud.horario}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Estado: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: solicitud.estado,
                                style: TextStyle(
                                  color: _obtenerColorTextoEstado(solicitud.estado),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const BotonVerInfo(),
                            const SizedBox(width: 15),
                            const BotonEditar(),
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

class BotonVerInfo extends StatelessWidget {
  const BotonVerInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 35),
        backgroundColor: Appcolores.amarilloUas,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Text('Ver Info'),
    );
  }
}

class BotonEditar extends StatelessWidget {
  const BotonEditar({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 35),
        backgroundColor: Appcolores.verdeClaro,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit, size: 16),
          SizedBox(width: 5),
          Text('Editar'),
        ],
      ),
    );
  }
}