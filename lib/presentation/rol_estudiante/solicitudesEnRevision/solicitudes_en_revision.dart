import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/widgets/tarjeta_solicitudes_en_revision.dart';
import 'package:flutter/material.dart';

class SolicitudesEnRevisionScreen extends StatefulWidget {
  const SolicitudesEnRevisionScreen({super.key, this.mostrarTitulo = false});

  final bool mostrarTitulo;

  @override
  State<SolicitudesEnRevisionScreen> createState() =>
      _SolicitudesEnRevisionScreenState();
}

class _SolicitudesEnRevisionScreenState
    extends State<SolicitudesEnRevisionScreen> {
  String filtroSeleccionado = "TODO";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return PantallaResponsiva(
            filtro: filtroSeleccionado,
            onFiltroChanged: (v) => setState(() => filtroSeleccionado = v),
          );
        } else {
          return PantallaGrande(
            filtro: filtroSeleccionado,
            onFiltroChanged: (v) => setState(() => filtroSeleccionado = v),
            mostrarTitulo: widget.mostrarTitulo,
          );
        }
      },
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
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 🔽 Filtro centrado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: WidgetFiltro(
                  filtro: filtro,
                  onFiltroChanged: onFiltroChanged,
                ),
              ),

              SizedBox(height: 40),

              Expanded(
                child: SingleChildScrollView(
                  child: TarjetaSolicitudesEnRevision(filtro: filtro),
                ),
              ),

              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaGrande extends StatelessWidget {
  final String filtro;
  final Function(String) onFiltroChanged;
  final bool mostrarTitulo;

  const PantallaGrande({
    super.key,
    required this.filtro,
    required this.onFiltroChanged,
    required this.mostrarTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              if (mostrarTitulo)
                SeccionArriba(onFiltroChanged: onFiltroChanged, filtro: filtro),

              if (!mostrarTitulo)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: WidgetFiltro(
                    filtro: filtro,
                    onFiltroChanged: onFiltroChanged,
                  ),
                ),

              const SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: TarjetaSolicitudesEnRevision(filtro: filtro),
                ),
              ),

              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SeccionArriba extends StatelessWidget {
  final String filtro;
  final Function(String) onFiltroChanged;

  const SeccionArriba({
    super.key,
    required this.filtro,
    required this.onFiltroChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final esCompacto = constraints.maxWidth < 840;

        return Padding(
          padding: const EdgeInsets.only(left: 60, top: 20, right: 60),
          child: esCompacto
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Solicitudes en Revisión",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(height: 12),
                    WidgetFiltro(
                      filtro: filtro,
                      onFiltroChanged: onFiltroChanged,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Solicitudes en Revisión",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      width: 260,
                      child: WidgetFiltro(
                        filtro: filtro,
                        onFiltroChanged: onFiltroChanged,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class WidgetFiltro extends StatelessWidget {
  final String filtro;
  final Function(String) onFiltroChanged;

  const WidgetFiltro({
    super.key,
    required this.filtro,
    required this.onFiltroChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Filtro por estados",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: filtro,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              items: [
                'TODO',
                'EN REVISION',
                'RECHAZADA',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) {
                if (v != null) onFiltroChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
