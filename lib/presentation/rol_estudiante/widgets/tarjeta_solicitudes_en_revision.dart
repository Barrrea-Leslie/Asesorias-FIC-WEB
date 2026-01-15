import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/solicitudes_en_revision.dart';
import 'package:asesorias_fic/data/services/solicitudes_en_revision_service.dart';
import 'package:flutter/material.dart';

class TarjetaSolicitudesEnRevision extends StatelessWidget {
  final String filtro;

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
  final double alturaTarjeta = 200.0;

  Color _obtenerColorTextoEstado(String estado) {
    switch (estado.toUpperCase()) {
      case 'EN REVISION':
        return Colors.orangeAccent;
      case 'RECHAZADA':
        return Colors.redAccent;
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
            runSpacing: 20, // Aumenté el espacio vertical entre filas
            alignment: WrapAlignment.center,
            children: listaSolicitudes.map((solicitud) {
            

              return SizedBox(
                width: anchoTarjeta,
                height: alturaTarjeta,
                child: Card(
                  color: Appcolores.azulUas,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
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
                        const SizedBox(height: 2),
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
                        const SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Estado: ",
                                style: TextStyle(color: Colors.white, fontSize: 14),
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
                            BotonIzquierdo(solicitud: solicitud,),
                            const SizedBox(width: 15),
                            BotonDerecho(
                              estado: solicitud.estado,

                              onPressed: () {
                                
                                if (solicitud.estado.toUpperCase() == 'RECHAZADA') {

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _AlertaMensajeSolicitudRechazada(solicitud: solicitud,);
                                    });

                                }else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _AlertaEditarSolicitud(solicitud: solicitud);
                                    });
                                }



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

class _AlertaEditarSolicitud extends StatelessWidget {
  const _AlertaEditarSolicitud({
    required this.solicitud
  });

  final dynamic solicitud;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Offroad Kantapon"),
    );
  }
}

class _AlertaMensajeSolicitudRechazada extends StatelessWidget {
  const _AlertaMensajeSolicitudRechazada({
    required this.solicitud
  });

  final dynamic solicitud;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      
      title:Container(
        
        padding: const EdgeInsets.only(bottom: 10),
        child: Center(
          child: Text('Notas del asesor', style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),)
          ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(solicitud.notas ?? 'Sin notas', textAlign: TextAlign.center,),
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
}

// Botones se mantienen igual que en tu código anterior
class BotonIzquierdo extends StatelessWidget {

  const BotonIzquierdo({
    super.key ,
    required this.solicitud
    });

  final dynamic solicitud;

  @override
  Widget build(BuildContext context) {
    String texto = 'Ver Info';
    Color colorFondo = Appcolores.amarilloUas;


    return ElevatedButton(
      onPressed: () {

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _AlertaInformacionSolicitud(solicitud: solicitud,);
          }
          );

      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 35),
        backgroundColor: colorFondo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(texto),
    );
  }
}


class BotonDerecho extends StatelessWidget {
  final String estado;
  final VoidCallback onPressed;

  const BotonDerecho({
    super.key,
    required this.estado,
    required this.onPressed
    });

  @override
  Widget build(BuildContext context) {
    String texto = 'Editar';
    Color colorFondo = Appcolores.verdeClaro;

    switch (estado.toUpperCase()) {
      case 'RECHAZADA':
        texto = 'Notas del asesor';
        colorFondo = Colors.red;
        break;
      default:
        texto = 'Editar';
        colorFondo = Appcolores.verdeClaro;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 35),
        backgroundColor: colorFondo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(texto)
    );
  }
}


class _AlertaInformacionSolicitud extends StatelessWidget {
  const _AlertaInformacionSolicitud({
    required this.solicitud
  });

  final dynamic solicitud;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Container(
        width: 370,
        padding: const EdgeInsets.only(bottom: 10),

        child: Center(
          child: Text(
            solicitud.asesor,
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _lineaInfo("Materia:", solicitud.materia),
            _lineaInfo("Asesor", solicitud.asesor),
            _lineaInfo("Fecha", solicitud.fecha),
            _lineaInfo("Horario", solicitud.horario),
            _lineaInfo("Estado", solicitud.estado)
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