import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:flutter/material.dart';

class TarjetaAsesorDiciplinarWidget extends StatelessWidget {
  final String query;

  const TarjetaAsesorDiciplinarWidget({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AsesorDisciplinar>>(
      // CAMBIO 1: Ahora llamamos a buscarAsesores pasando el query directamente
      // Esto hace que la filtración ocurra en tu base de datos (Node.js/Postgres)
      future: AsesoresDiciplinaresService().buscarAsesores(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los asesores disciplinares'));
        }

        // CAMBIO 2: Ya no necesitamos filtrar manualmente con .where()
        // porque el Service ya trae los datos filtrados por el backend.
        final filteredAsesores = snapshot.data ?? [];

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

  @override
  Widget build(BuildContext context) {
    if (listAsesoresDiciplinares.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "No se encontraron asesores.",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        children: listAsesoresDiciplinares.map((asesorDiciplinar) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context, 
                '/informacionAsesorDisciplinar', 
                arguments: asesorDiciplinar,
              );
            },
            child: SizedBox(
              width: anchoTarjeta,
              height: alturaTarjeta,
              child: Card(
                color: Appcolores.azulUas,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Image.asset('assets/images/foto_icon.png', width: 60),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // CAMBIO 3: Puedes mostrar Nombre y Apellido si gustas
                              "${asesorDiciplinar.nombre} ${asesorDiciplinar.apellidoPaterno}",
                              style: const TextStyle(
                                color: Colors.white, 
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              asesorDiciplinar.correo,
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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

/* import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
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
          return const Center(child: Text('Error al cargar los asesores disciplinares'));
        }

        final allAsesores = snapshot.data!;
        
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

  @override
  Widget build(BuildContext context) {
    if (listAsesoresDiciplinares.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "No se encontraron asesores con ese nombre.",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        children: listAsesoresDiciplinares.map((asesorDiciplinar) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context,'/informacionAsesorDisciplinar', arguments: asesorDiciplinar,);
            },
            child: SizedBox(
              width: anchoTarjeta,
              height: alturaTarjeta,
              child: Card(
                color: Appcolores.azulUas,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Image.asset('assets/images/foto_icon.png', width: 60),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          asesorDiciplinar.nombre,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
} */