import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/solicitar_asesoria_directa.dart';
import 'package:flutter/material.dart';


class TarjetaSolicitarAsesoria extends StatelessWidget {
  const TarjetaSolicitarAsesoria({super.key, this.query = ''});

  final String query;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        AsesoresParService().getAsesoresPar(),
        AsesoresDiciplinaresService().getAsesoresDiciplinares()
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los asesores'));
        }

        final asesoresPar = snapshot.data![0] as List<AsesorPar>;
        final asesoresDiciplinares = snapshot.data![1] as List<AsesorDisciplinar>;


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
          listaAsesoresDiciplinares: asesoresDiciplinaresFiltrados
        );

      });
  }
}

class ListaTarjetasSolicitar extends StatelessWidget {
  const ListaTarjetasSolicitar({
    super.key,
    required this.listaAsesoresPar,
    required this.listaAsesoresDiciplinares
    });

  final List<dynamic> listaAsesoresPar;
  final List<dynamic> listaAsesoresDiciplinares;

  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 200.0;

  @override
  Widget build(BuildContext context) {

    final todosLosAsesores = [...listaAsesoresPar, ...listaAsesoresDiciplinares];

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
                      padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text(item.nombre, style: TextStyle(color: Colors.white),),
                            Text("Materias: ${item.materiasAsesora.join(', ')}",style: const TextStyle(color: Colors.white70), maxLines: 2,),
                            Text("Modalidad: Presencial / Virtual",style: const TextStyle(color: Colors.white70), maxLines: 2,),

                            const SizedBox(height: 20,),

                            
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BotonInformacion(asesor: item,),
                                  SizedBox(width: 20,),
                                  BotonSolicitar(asesor: item)
                                ],
                              ),
                            

                          ],
                      ),

                      

                      ),
                  ),
              );
            }).toList(),

          );

        }),
      );
  }
}

class BotonInformacion extends StatelessWidget {
  const BotonInformacion({
    super.key,
    required this.asesor
  });

  final dynamic asesor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _AlertaInformacionAsesor(asesor: asesor);
          },
        );
      },
      style: ElevatedButton.styleFrom(
      minimumSize: Size(30, 35),
      backgroundColor: Appcolores.amarilloUas,
      foregroundColor: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5)
      )
    ),
      child: Text('Ver Info'));
  }
}

class BotonSolicitar extends StatelessWidget {
  final dynamic asesor; // <--- Agregamos la variable

  const BotonSolicitar({
    super.key,
    required this.asesor, // <--- Requerimos el asesor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SolicitarAsesoriaDirecta(asesor: asesor), // Pasas el objeto del asesor aquí
        );
      },
      style: ElevatedButton.styleFrom(
      minimumSize: Size(30, 35),
      backgroundColor: Appcolores.verdeClaro,
      foregroundColor: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5)
      )
    ),
      child: Text('Solicitar Asesoria'));
  }
}

class _AlertaInformacionAsesor extends StatelessWidget {
  final dynamic asesor;

  const _AlertaInformacionAsesor({required this.asesor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Container(
        width: 370,
        padding: const EdgeInsets.only(bottom: 10),
        //border: const Border(bottom: BorderSide(color: Appcolores.amarilloUas, width: 2)),
        child: Center(
          child: Text(
            asesor.nombre,
            
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _lineaInfo("Correo:", asesor.correoInstitucional),
            _lineaInfo("Teléfono:", asesor.numeroTelefono),
            _lineaInfo("Materias:", asesor.materiasAsesora.join(', ')),
            _lineaInfo("Horarios:", asesor.horariosAsesora.join('\n')),
            
            // Si el objeto tiene licenciatura (es Asesor Par), lo mostramos
            if (asesor.runtimeType.toString().contains('AsesorPar')) ...[
              _lineaInfo("Licenciatura:", asesor.licenciatura),
              _lineaInfo("Grupo:", asesor.grupo),
            ],
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Appcolores.azulUas,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cerrar"),
        ),
      ],
    );
  }

  // Widget auxiliar para las filas de texto
  Widget _lineaInfo(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(etiqueta, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color.fromARGB(255, 0, 0, 0))),
          Text(valor, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        ],
      ),
    );
  }
}