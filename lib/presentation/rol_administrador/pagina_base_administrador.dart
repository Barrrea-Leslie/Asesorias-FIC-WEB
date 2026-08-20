import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/auth_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/asesores_diciplinares.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/asesores_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesoriasEnCurso/asesorias_en_curso.dart';
import 'package:asesorias_fic/presentation/rol_administrador/catalogos.dart';
import 'package:asesorias_fic/presentation/rol_administrador/estudiantes/estudiantes.dart';
import 'package:asesorias_fic/presentation/rol_administrador/reportes.dart';
import 'package:asesorias_fic/presentation/rol_administrador/solicitudes_pendientes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _estaVerificando = true; //variable para mostrar pantalla en blanco mientras vemos lo del token

  //Instancia del storage
  final _storage = const FlutterSecureStorage(
    webOptions: WebOptions(dbName: 'AsesoriasFIC', publicKey: 'SecretKeyFIC'),
  );

  final List<String> _titles = [
    'Asesorías',
    'Solicitudes',
    'Reportes',
    'Asesores Disciplinares',
    'Asesores Par',
    'Estudiantes',
    "Catalogos",
  ];

  @override
  void initState() {
    super.initState();
    _verificarToken(); // se ejecuta la funcion del candado
  }

  Future<void> _verificarToken() async {
    String? token = await _storage.read(key: "jwt_token");

    if (token == null) {
      print("regresando a login");
      if (mounted) {
        // limpiar historial
        Navigator.pushNamedAndRemoveUntil(context, '/inicioSesion', (route) => false);
      }
    } else {
      print("Bienvenido al Panel de tutorias");
      if (mounted) {
        setState(() {
          _estaVerificando = false; //se verifico todo
        });
      }
    }
  }

  List<Widget> _buildPages(bool isMobile) => [
    AsesoriasEnCurso(mostrarTitulo: !isMobile),
    SolicitudesPendientes(mostrarTitulo: !isMobile),
    Reportes(mostrarTitulo: !isMobile),
    AsesoresDiciplinares(mostrarTitulo: !isMobile),
    AsesoresPar(mostrarTitulo: !isMobile),
    //PantallaEstudiantes(),
    Estudiantes(mostrarTitulo: !isMobile),
    Catalogos(mostrarTitulo: !isMobile,),
  ];

  void _onItemSelected(BuildContext context, int index) {
    if (index == 7) {
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
    if (_estaVerificando) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: UasColores.azulOficial),
        ),
      );
    }


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
        backgroundColor: UasColores.azulOficial,
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
          backgroundColor: UasColores.azulOficial,
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
      backgroundColor: UasColores.azulOficial,
      body: Row(
        children: [
          Builder(
            builder: (context) => Container(
              width: 260,
              color: UasColores.azulOficial,
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
}

class AlertaCerrarSesion extends StatelessWidget {
  const AlertaCerrarSesion({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
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
          onPressed: () async {
            await authService.logout();
              Navigator.pushNamedAndRemoveUntil(context, '/inicioSesion', (route) => false);
          },
              
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
        _menuItem(Icons.assignment_turned_in, 'Asesorías', 0),
        _menuItem(Icons.assignment_late, 'Solicitudes', 1),
        _menuItem(Icons.assignment_rounded, 'Reportes', 2),
        _menuItem(Icons.people, 'Asesores Disciplinares', 3),
        _menuItem(Icons.group, 'Asesores Par', 4),
        _menuItem(Icons.school, 'Estudiantes', 5),
        _menuItem(Icons.book, 'Catalogos', 6),
        const Spacer(),
        _menuItem(Icons.logout, 'Cerrar sesión', 7),
        const SizedBox(height: 12),
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
