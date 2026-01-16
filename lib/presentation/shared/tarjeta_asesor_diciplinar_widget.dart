import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/informacion_asesor_disciplinar.dart.dart';
import 'package:flutter/material.dart';

class TarjetaAsesorDiciplinarWidget extends StatelessWidget {
  final String query;

  const TarjetaAsesorDiciplinarWidget({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AsesorDisciplinar>>(
      future: AsesoresDiciplinaresService().getAsesoresDiciplinares(),
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
          return nombre.contains(search);
        }).toList();

        return ListaAsesoresDiciplinares(listAsesoresDiciplinares: filteredAsesores);
      },
    );
  }
}

class ListaAsesoresDiciplinares extends StatelessWidget {
  const ListaAsesoresDiciplinares({
    super.key,
    required this.listAsesoresDiciplinares,
  });

  final List<AsesorDisciplinar> listAsesoresDiciplinares;
  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 100.0;

  // FUNCIÓN PARA ABRIR EL MODAL
  void _abrirModalEdicion(BuildContext context, AsesorDisciplinar asesor) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          content: Container(
            width: 900,
            height: 600,
            color: Colors.white,
            child: EditarAsesorDisciplinar(asesor: asesor),
          ),
        );
      }
      
    );
  }

  @override
  Widget build(BuildContext context) {
    if (listAsesoresDiciplinares.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No se encontraron asesores.", style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        children: listAsesoresDiciplinares.map((asesor) {
          return GestureDetector(
            onTap: () => _abrirModalEdicion(context, asesor),
            child: SizedBox(
              width: anchoTarjeta,
              height: alturaTarjeta,
              child: Card(
                color: Appcolores.azulUas,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Image.asset('assets/images/foto_icon.png', width: 60),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          asesor.nombre,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      const SizedBox(width: 15),
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