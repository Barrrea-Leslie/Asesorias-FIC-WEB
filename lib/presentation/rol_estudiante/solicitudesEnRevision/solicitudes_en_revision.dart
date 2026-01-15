import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_solicitudes_en_revision.dart';
import 'package:flutter/material.dart';

class SolicitudesEnRevisionScreen extends StatefulWidget {
  const SolicitudesEnRevisionScreen({super.key});

  @override
  State<SolicitudesEnRevisionScreen> createState() => _SolicitudesEnRevisionScreenState();
}

class _SolicitudesEnRevisionScreenState extends State<SolicitudesEnRevisionScreen> {
  // Estado para el filtro
  String filtroSeleccionado = "TODO";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000) {
        return PantallaResponsiva(
          filtro: filtroSeleccionado,
          onFiltroChanged: (nuevoValor) {
            setState(() => filtroSeleccionado = nuevoValor);
          },
        );
      } else {
        return PantallaGrande(
          filtro: filtroSeleccionado,
          onFiltroChanged: (nuevoValor) {
            setState(() => filtroSeleccionado = nuevoValor);
          },
        );
      }
    });
  }
}

class PantallaGrande extends StatelessWidget {
  final String filtro;
  final Function(String) onFiltroChanged;

  const PantallaGrande({
    super.key,
    required this.filtro,
    required this.onFiltroChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SeccionArriba(),
              
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: WidgetFiltro(filtro: filtro, onFiltroChanged: onFiltroChanged)),
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 30),
                  child: SingleChildScrollView(
                    child: TarjetaSolicitudesEnRevision(filtro: filtro),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaResponsiva extends StatelessWidget {
  final String filtro;
  final Function(String) onFiltroChanged;

  const PantallaResponsiva({
    super.key,
    required this.filtro,
    required this.onFiltroChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SeccionArriba(),
              const SizedBox(height: 20),
              WidgetFiltro(filtro: filtro, onFiltroChanged: onFiltroChanged),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 30),
                  child: SingleChildScrollView(
                    child: TarjetaSolicitudesEnRevision(filtro: filtro),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetFiltro extends StatelessWidget {
  const WidgetFiltro({
    super.key,
    required this.filtro,
    required this.onFiltroChanged,
    });

  final String filtro;
  final Function(String) onFiltroChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Filtro por estados",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                width: 340,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0), // Gris claro de la imagen
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: filtro,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    items: <String>['TODO', 'EN REVISION', 'RECHAZADA']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) onFiltroChanged(newValue);
                    },
                  ),
                ),
              ),
            ],
          );
  }
}

class SeccionArriba extends StatelessWidget {
  const SeccionArriba({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 20, right: 60.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Solicitudes en Revisión",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
          
        ],
      ),
    );
  }
}