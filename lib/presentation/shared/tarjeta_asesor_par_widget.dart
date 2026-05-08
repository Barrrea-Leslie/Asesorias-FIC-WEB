import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/informacion_asesor_par.dart';
import 'package:flutter/material.dart';

class TarjetaAsesorParWidget extends StatelessWidget {
  final String query;
  final String? filtroGrupo;
  final String? filtroCarrera;

  const TarjetaAsesorParWidget({
    super.key,
    this.query = '',
    this.filtroGrupo,
    this.filtroCarrera,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AsesorPar>>(
      future: AsesoresParService().getAsesoresPar(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar: ${snapshot.error}'));
        }

        final allAsesores = snapshot.data ?? [];

        final filteredAsesores = allAsesores.where((asesor) {
          final nombre = asesor.nombre.toLowerCase();
          final search = query.toLowerCase();

          if (!nombre.contains(search)) return false;

          // Filtro por grupo completo
          if (filtroGrupo != null && filtroGrupo!.isNotEmpty) {
            if (asesor.grupo.trim() != filtroGrupo!.trim()) {
              return false;
            }
          }

          // Filtro por carrera
          if (filtroCarrera != null && filtroCarrera!.isNotEmpty) {
            if (asesor.licenciatura != filtroCarrera) {
              return false;
            }
          }

          return true;
        }).toList();

        return ListaAsesoresPar(listAsesoresPar: filteredAsesores);
      },
    );
  }
}

class ListaAsesoresPar extends StatelessWidget {
  const ListaAsesoresPar({super.key, required this.listAsesoresPar});

  final List<AsesorPar> listAsesoresPar;
  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 100.0;

  void _abrirModalEdicion(BuildContext context, AsesorPar asesor) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Container(
            width: 900,
            height: 635,
            color: Colors.white,
            child: InformacionAsesoresPar(asesor: asesor),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listAsesoresPar.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "No se encontraron asesores par.",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        children: listAsesoresPar.map((asesorPar) {
          return GestureDetector(
            onTap: () => _abrirModalEdicion(context, asesorPar),
            child: SizedBox(
              width: anchoTarjeta,
              height: alturaTarjeta,
              child: Card(
                color: Appcolores.azulUas,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    children: [
                      Image.asset('assets/images/foto_icon.png', width: 60),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          asesorPar.nombre,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
