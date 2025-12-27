import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesores_diciplinares.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesores_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorias_en_curso.dart';
import 'package:asesorias_fic/presentation/rol_administrador/estudiantes.dart';
import 'package:asesorias_fic/presentation/rol_administrador/reportes.dart';
import 'package:asesorias_fic/presentation/rol_administrador/solicitudes_pendientes.dart';
import 'package:flutter/material.dart';



/* class HomePageR extends StatefulWidget {
  const HomePageR({super.key});

  @override
  State<HomePageR> createState() => _HomePageRState();
}

class _HomePageRState extends State<HomePageR> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AsesoriasEnCurso(),
    SolicitudesPendientes(),
    Reportes(),
    AsesoresDiciplinares(),
    AsesoresPar(),
    Estudiantes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
            backgroundColor: Appcolores.azulUas,
            minWidth: 170,
            
            onDestinationSelected: (index) {
              // CERRAR SESIÓN → ACCIÓN
              if (index == 6) {
                Navigator.pushReplacementNamed(context, '/login');
                return;
              }

              // CAMBIO NORMAL DE PÁGINA
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20, right: 10, left: 10),
              child: Image.asset(
                'assets/images/fic_logo.png',
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            unselectedIconTheme: IconThemeData(color: const Color.fromARGB(128, 255, 255, 255)),
            selectedIconTheme: IconThemeData(color: Appcolores.azulUas),
            selectedLabelTextStyle: TextStyle(color: Colors.white),
            unselectedLabelTextStyle: TextStyle(color: const Color.fromARGB(128, 255, 255, 255)),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.assignment_turned_in_rounded),
                label: Text('Asesorias en Curso'),
                padding: EdgeInsets.only(top: 10)
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment_late),
                label: Text('Solicitudes'),
                padding: EdgeInsets.only(top: 10)
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment),
                label: Text('Reportes'),
                padding: EdgeInsets.only(top: 10)
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_box),
                label: Text('Diciplinares'),
                padding: EdgeInsets.only(top: 10)
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_box),
                label: Text('Par'),
                padding: EdgeInsets.only(top: 10)
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_circle_rounded),
                label: Text('Estudiantes'),
                padding: EdgeInsets.only(top: 10)
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout_rounded),
                label: Text('Cerrar Sesion'),
                padding: EdgeInsets.only(top: 20)
              ),
            ],
          ),

          const VerticalDivider(thickness: 1, width: 1),

          // CONTENIDO CAMBIANTE
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
 */



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AsesoriasEnCurso(),
    SolicitudesPendientes(),
    Reportes(),
    AsesoresDiciplinares(),
    AsesoresPar(),
    Estudiantes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu( 
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              if (index == 6) {
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

          _menuItem(Icons.assignment_turned_in, 'Asesorías', 0),
          _menuItem(Icons.assignment_late, 'Solicitudes', 1),
          _menuItem(Icons.assignment_rounded, 'Reportes', 2),
          _menuItem(Icons.people, 'Asesores Disciplinares', 3),
          _menuItem(Icons.group, 'Asesores Par', 4),
          _menuItem(Icons.school, 'Estudiantes', 5),

          const Spacer(),

          _menuItem(Icons.logout, 'Cerrar sesión', 6),
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