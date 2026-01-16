import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/asesoriasEnCurso/asesorias_en_curso_estudiante.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/historialDeAsesorias/historial_de_asesorias.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/solicitar_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitudesEnRevision/solicitudes_en_revision.dart';
import 'package:flutter/material.dart';


class PaginaBaseEstudiante extends StatefulWidget {
    const PaginaBaseEstudiante({super.key});

    @override
    State<PaginaBaseEstudiante> createState() => _PaginaBaseEstudianteState();
}

class _PaginaBaseEstudianteState extends State<PaginaBaseEstudiante> {
    
    int _selectedIndex = 0;
    
    final List<Widget> _pages = [
        SolicitarAsesoria(),
        AsesoriasEnCursoEstudiante(),
        SolicitudesEnRevisionScreen(),
        HistorialDeAsesorias(),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        body: Row(
            children: [
            SideMenu(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                if (index == 4) {
                    showDialog(
                    context: context,
                    builder: (BuildContext context){
                        return AlertaCerrarSesion();
                    });
                    
                } else {
                    setState(() => _selectedIndex = index);
                }
                },
            ),

            Expanded(
                child: IndexedStack(
                index: _selectedIndex,
                children: _pages,
                ),
            ),
            ],
        ),
        );
    }
    }

    class AlertaCerrarSesion extends StatelessWidget {
    const AlertaCerrarSesion({
        super.key,
    });

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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                textStyle: TextStyle(fontWeight: FontWeight.bold)
            ),
            onPressed: () {
                Navigator.of(context).pop();
                },
            child: Text("Cancelar")),
        
            TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 235, 40, 26),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                textStyle: TextStyle(fontWeight: FontWeight.bold)
            ),
            onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text("Aceptar")),
            
        ],
        );
    }
    }

    class SideMenu extends StatelessWidget {
    const SideMenu({super.key, required this.selectedIndex, required this.onItemSelected});

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
            boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
            ),
            ],
        ),
        child: Column(
            children: [
            // LOGO
            Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset('assets/images/fic_logo.png', height: 130),
            ),

            const SizedBox(height: 20),

            _menuItem(Icons.assignment_add, 'Solicitar Asesorias', 0),
            _menuItem(Icons.assignment, 'Asesorias', 1),
            _menuItem(Icons.pending_actions, 'Solicitudes en revisión', 2),
            _menuItem(Icons.history, 'Historial de asesorias', 3),
            

            const Spacer(),

            _menuItem(Icons.logout, 'Cerrar sesión', 4),
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