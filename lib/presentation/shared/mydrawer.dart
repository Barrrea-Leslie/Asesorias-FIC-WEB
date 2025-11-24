import 'package:flutter/material.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key, required this.rutaActual});

  final String rutaActual;

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {

  int indexSeleccionado = 0;

  final List <String> drawerItems = const [

    'Asesorias en curso',
    'Solicitudes Pendientes',
    'Reportes',
    'Asesores Diciplinares',
    'Asesores Par',
    'Estudiantes',
    'Cerrar Sesion',
  ];

  final List <String> rutas = const [

    '/asesoriasEnCurso',
    '/solicitudesPendientes',
    '/reportes',
    '/asesoresDiciplinares',
    '/asesoresPar',
    '/estudiantes',
    '/login'
    
  ];

  final Color colorPrincipal = const Color(0xFF08338f);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      backgroundColor: colorPrincipal,

      child: ListView(

        children: [

          Padding(
            padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
            child: DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/images/logo_blanco.png',),
              ),),
            
          ),

          const SizedBox(height: 30,),

          ...drawerItems.asMap().entries.map((entry){
          int index = entry.key;
          String title = entry.value;
          String ruta = rutas[index];

          return Column(
            children: [
              if (index == drawerItems.length - 1) 
                const SizedBox(height: 50),
              
              _drawerItem(title, index, ruta),
            ],
          );

          }),

          


        ],

      ),

    );
  }

  Widget _drawerItem(String title, int index, String ruta){

     //comparar si al ruta del menu e sigual a la seleccionada en el menu
  final bool isSeleccionado = ruta == widget.rutaActual;

  //colores si e sselecionada la opcion omsi no lo es
  //final Color itemBackgroundColor = isSeleccionado ? Colors.white : colorPrincipal;
  final Color itemTextColor = isSeleccionado ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(155, 255, 255, 255);

  //saber si se le agrega el color blanco a la opcion cuando e seleccionada
  final BoxDecoration? decoracion = isSeleccionado ? const BoxDecoration(

    borderRadius: BorderRadius.horizontal(

      left: Radius.circular(3.0),
      right: Radius.circular(3.0)

    ),

    border: Border(
      left: BorderSide(
        color: Colors.white,
        width: 7.0,
      ),
    ),

  ) : null;

  //para agregarle un icono si la opcion creada fue cerrar sesion

  final bool logOutSeleccionado = index == 6;

  final Icon? icon = logOutSeleccionado ? Icon(Icons.logout, color: Color.fromARGB(155, 255, 255, 255),): null;


  return Padding(
    padding: const EdgeInsets.only(right: 40),
    child: Container(
      decoration: decoracion,
      child: ListTile(
        splashColor: Colors.transparent,
        leading: icon,
        title: Text(
          title,
          style: TextStyle(color: itemTextColor),),
          onTap: () {
            if (isSeleccionado) {
              return;
            }else{
              Navigator.pushReplacementNamed(context, ruta);
              
              
            }
          },

      ),
    ),
    
    );



  }


}