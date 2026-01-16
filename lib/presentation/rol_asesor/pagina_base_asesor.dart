import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_asesor/asesoriasEnCurso/asesorias_en_curso_asesor.dart';
import 'package:asesorias_fic/presentation/rol_asesor/historialDeAsesorias/historial_asesorias_asesor.dart';
import 'package:asesorias_fic/presentation/rol_asesor/solicitudesPendientes/solicitudes_pendientes_asesor.dart';
import 'package:flutter/material.dart';

class PaginaBaseAsesor extends StatefulWidget {
  const PaginaBaseAsesor({super.key});

  @override
  State<PaginaBaseAsesor> createState() => _PaginaBaseAsesorState();
}

class _PaginaBaseAsesorState extends State<PaginaBaseAsesor> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    SolicitudesPendientesAsesor(),
    AsesoriasEnCursoAsesor(),
    HistorialAsesoriasAsesor(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              if (index == 3) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertaCerrarSesion();
                  },
                );
              } else {
                setState(() => _selectedIndex = index);
              }
            },
          ),

          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}

class AlertaCerrarSesion extends StatelessWidget {
  const AlertaCerrarSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmacion"),
      content: Text("Esta seguro de cerrar sesion?"),
      contentPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 143, 143, 143),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),

        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 235, 40, 26),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text("Aceptar"),
        ),
      ],
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final Function(int) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,

      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Appcolores.azulUas,
        /* borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
            ), */
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          // LOGO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset('assets/images/fic_logo.png', height: 130),
          ),

          const SizedBox(height: 20),

          _menuItem(Icons.pending_actions, 'Solicitudes pendientes', 0),
          _menuItem(Icons.assignment, 'Asesorias en curso', 1),
          _menuItem(Icons.history, 'Historial de asesorias', 2),

          const Spacer(),

          _menuItem(Icons.logout, 'Cerrar sesión', 3),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String text, int index) {
    final bool selected = index == selectedIndex;

    return InkWell(
      onTap: () => onItemSelected(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Appcolores.azulFuerte : Colors.white),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: selected ? Appcolores.azulFuerte : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
