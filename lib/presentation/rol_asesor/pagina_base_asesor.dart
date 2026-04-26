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

  List<Widget> _buildPages(bool isMobile) => [
    SolicitudesPendientesAsesor(mostrarTitulo: !isMobile),
    AsesoriasEnCursoAsesor(mostrarTitulo: !isMobile),
    HistorialAsesoriasAsesor(mostrarTitulo: !isMobile),
  ];

  final List<String> _titles = [
    'Solicitudes Pendientes',
    'Asesorías en Curso',
    'Historial de Asesorías',
  ];

  void _onItemSelected(BuildContext context, int index) {
    if (index == 3) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      showDialog(context: context, builder: (_) => AlertaCerrarSesion());
    } else {
      setState(() => _selectedIndex = index);
      if (Scaffold.of(context).isDrawerOpen) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;
        final pages = _buildPages(isMobile);

        if (isMobile) {
          return _buildMobile(pages);
        } else {
          return _buildDesktop(pages);
        }
      },
    );
  }

  Widget _buildMobile(List<Widget> pages) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Appcolores.azulUas,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Builder(
        builder: (context) => Drawer(
          width: 260,
          backgroundColor: Appcolores.azulUas,
          child: SafeArea(
            child: _SideMenuContent(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) => _onItemSelected(context, index),
            ),
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: pages),
    );
  }

  Widget _buildDesktop(List<Widget> pages) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      body: Row(
        children: [
          Builder(
            builder: (context) => Container(
              width: 260,
              color: Appcolores.azulUas,
              child: _SideMenuContent(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) => _onItemSelected(context, index),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: IndexedStack(index: _selectedIndex, children: pages),
            ),
          ),
        ],
      ),
    );
  }
} // <- este } faltaba

class AlertaCerrarSesion extends StatelessWidget {
  const AlertaCerrarSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmacion"),
      content: const Text("Esta seguro de cerrar sesion?"),
      contentPadding: const EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 143, 143, 143),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancelar"),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 235, 40, 26),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          child: const Text("Aceptar"),
        ),
      ],
    );
  }
}

class _SideMenuContent extends StatelessWidget {
  const _SideMenuContent({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final Function(int) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
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
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _menuItem(IconData icon, String text, int index) {
    final bool selected = index == selectedIndex;
    return InkWell(
      onTap: () => onItemSelected(index),
      borderRadius: BorderRadius.circular(12),
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
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: selected ? Appcolores.azulFuerte : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
