import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Conocenos extends StatefulWidget {
  const Conocenos({super.key});

  @override
  State<Conocenos> createState() => _ConocenosState();
}

class _ConocenosState extends State<Conocenos> {
  final GlobalKey nuestroEquipooKey = GlobalKey();
  final GlobalKey nuestroProyectoKey = GlobalKey();
  final GlobalKey quienesSomosKey = GlobalKey();
  final GlobalKey comoSurgioKey = GlobalKey();
  final GlobalKey objetivosKey = GlobalKey();
  final GlobalKey misionVKey = GlobalKey();
  final GlobalKey vinculacionKey = GlobalKey();
  final GlobalKey agradecimientosKey = GlobalKey();
  final GlobalKey contactoKey = GlobalKey();

  void irASection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tamanoPantalla = MediaQuery.of(context).size.width;

    final bool esMovil = tamanoPantalla < 700;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: const Color.fromARGB(255, 0, 34, 106),
              padding: EdgeInsets.symmetric(horizontal: 100),

              child: Row(
                children: [
                  Image.asset('assets/images/logo_uas.png', height: 60),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          'Asesorias FIC',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 245, 246, 247),
                            fontSize: esMovil ? 22 : 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          'Facultad de informatica Culiacan',
                          style: TextStyle(
                            color: Appcolores.gris,
                            fontSize: esMovil ? 22 : 28,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Menu Horizontal
          SliverAppBar(
            backgroundColor: Appcolores.amarilloUas,
            pinned: true,
            floating: false,
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            titleSpacing: 100,

            title: SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: esMovil ? 10 : 100),
                children: [
                  _itemMenu(
                    'Nuestro equipo',
                    () => irASection(nuestroEquipooKey),
                  ),
                  _itemMenu(
                    'Nuestro proyecto',
                    () => irASection(nuestroProyectoKey),
                  ),
                  _itemMenu(
                    '¿Quienes somos?',
                    () => irASection(quienesSomosKey),
                  ),
                  _itemMenu('¿Como surgio?', () => irASection(comoSurgioKey)),
                  _itemMenu('Objetivos', () => irASection(objetivosKey)),
                  _itemMenu('Mision y Vision', () => irASection(misionVKey)),
                  _itemMenu('Vinculacion', () => irASection(vinculacionKey)),
                  _itemMenu(
                    'Agradeciniento',
                    () => irASection(agradecimientosKey),
                  ),
                  _itemMenu('Contacto', () => irASection(contactoKey)),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Text(
                        'Acerca de nosotros',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Sistema de tutorias UAS',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),

                //primer contenedor
                Container(
                  key: nuestroEquipooKey,
                  width: double.infinity,
                  color: const Color.fromARGB(107, 156, 118, 28),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 50,
                  ),

                  child: Center(
                    child: SizedBox(
                      width: 1000,

                      child: const Text(
                        'La Universidad Autónoma de Sinaloa a través de Bienestar Universitario y la Facultad de Informática Culiacán en colaboración con el Laboratorio de Innovación, Desarrollo Académico y Tecnológico de la Facultad de Informática Culiacán, presenta el Sistema de tutorias FIC.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 70,
                    runSpacing: 70,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      _tarjetita(
                        'GERENTES DE PROYECTO',
                        'MC. Alejandro Yahir Sicairos Ochoa\n'
                            'C. Axel Manuel Aguilar Perez MGTI.\n'
                            'Oscar Mejía Quintero\n'
                            'Jose Angel Astorga Mejia',
                      ),

                      _tarjetita(
                        'GERENTES DE DESARROLLO',
                        'Jose Angel Astorga Mejia\n'
                            'Leslie Mayram Barrera Rodriguez\n'
                            'Raquel del Pilar Ibarra Meza\n'
                            'Bhrandon Nedel Medina Hernandez\n'
                            'Erick Fernando Sanchez Barraza\n'
                            'Jenifer Guadalupe Tizoc Lopez',
                      ),

                      _tarjetita('ESPECIALISTAS SEO', ''),
                      _tarjetita('ANALISTAS DE DESARROLLO Y CALIDAD', ''),
                      _tarjetita('DISEÑADOR UI/UX', ''),
                    ],
                  ),
                ),

                const SizedBox(height: 80), //espacio entre el bloque
                //TERCER CONTENEDOR
                contenedorTexto(
                  key: nuestroProyectoKey,
                  color: const Color(0xffb6c3db),

                  titulo: 'Nuestro proyecto',
                  contenido:
                      'El Sistema de tutorías FIC es una plataforma móvil y web desarrollada para permitir la gestión de asesorías en la facultad de informática de culiacan, facilitando la interacción entre estudiantes, asesores y administradores mediante una plataforma moderna, eficiente y centralizada.\n\n'
                      'Sus objetivos principales son automatizar la solicitud, aprobación y seguimiento de asesorías y proveer a los estudiantes un espacio para consultar horarios disponibles y enviar solicitudes para asesorías.\n\n'
                      'En el sistema se facilita a los asesores la administración de sus horarios, asesorías, evidencias y reportes, además de la generación de historial y evidencia de cada asesoría para respaldos y evaluaciones.\n\n'
                      'El desarrollo de este sistema busca digitalizar y automatizar el flujo completo de asesorías, tanto para estudiantes, asesores disciplinares y pares, como para administradores, mejorando la comunicación, la organización y la eficiencia operativa.',
                ),

                const SizedBox(height: 80),

                //Quienes somos
                contenedorTexto(
                  key: quienesSomosKey,
                  color: const Color(0xffb6c3db),

                  titulo: '¿Quienes somos?',
                  contenido:
                      'Somos el Laboratorio de Innovación, Desarrollo Académico y Tecnológico de la Facultad de Informática Culiacán, un espacio dedicado a la creación de soluciones tecnológicas que impacten positivamente los procesos académicos y administrativos dentro de la universidad.\n\n'
                      'Nuestro laboratorio está conformado por estudiantes y docentes comprometidos con la mejora continua, la transformación digital y la implementación de herramientas tecnológicas reales que resuelvan problemáticas institucionales. Trabajamos en proyectos de software, automatización de procesos, desarrollo web, sistemas de gestión y propuestas innovadoras orientadas a la eficiencia operativa.\n\n'
                      'Más que un espacio de desarrollo, somos un equipo que busca aplicar el conocimiento adquirido en el aula para generar soluciones funcionales que beneficien directamente a la comunidad universitaria.',
                ),

                const SizedBox(height: 80),

                //como surgio
                contenedorTexto(
                  key: comoSurgioKey,
                  color: const Color(0xffb6c3db),

                  titulo: '¿Como surgio?',
                  contenido:
                      'El Sistema de Tutorías FIC surgió como respuesta a la necesidad de mejorar la gestión de asesorías en la Facultad de Informática Culiacán. Observamos que muchos estudiantes enfrentaban dificultades para acceder a las asesorías y que los asesores necesitaban una herramienta eficiente para administrar sus horarios y solicitudes. Con el apoyo de Bienestar Universitario y el Laboratorio de Innovación, decidimos desarrollar una plataforma que facilite esta interacción, optimizando los procesos y promoviendo un ambiente académico más colaborativo y accesible.',
                ),

                const SizedBox(height: 70),

                //objetivos
                contenedorTexto(
                  key: objetivosKey,
                  color: const Color(0xffb6c3db),

                  titulo: 'Objetivos',
                  contenido: '',
                ),
                const SizedBox(height: 80),

                //Alcance
                contenedorTexto(
                  key: agradecimientosKey,

                  color: const Color(0xffb6c3db),

                  titulo: 'Alcance',
                  contenido:
                      'Gestión de asesorías: Permitir a los estudiantes solicitar asesorías de manera sencilla y a los asesores gestionar sus horarios y citas.\n\n'
                      'Interacción eficiente: Facilitar la comunicación entre estudiantes, asesores y administradores a través de una plataforma centralizada. \n\n'
                      'Automatización de procesos: Automatizar la solicitud, aprobación y seguimiento de asesorías para reducir tiempos de espera y mejorar la experiencia del usuario. \n\n '
                      'Historial y reportes: Generar un historial de asesorías y reportes que permitan a los administradores evaluar la efectividad del sistema y realizar mejoras continuas.',
                ),

                //Mision y vision
                Container(
                  key: misionVKey,
                  padding: EdgeInsets.symmetric(horizontal: esMovil ? 20 : 80),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70),

                      Wrap(
                        spacing: 40,
                        runSpacing: 40,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          _tarjetita(
                            'Mision',
                            'Nuestra misión es proporcionar una plataforma digital que facilite la gestión de asesorías en la Facultad de Informática de Culiacán, promoviendo la interacción efectiva entre estudiantes y asesores y contribuyendo al desarrollo académico de los estudiantes mediante el acceso a recursos de asesoría de calidad.',
                          ),
                          _tarjetita(
                            'Vision',
                            'Nuestra visión es ser un referente en la implementación de soluciones tecnológicas en el ámbito académico, transformando la manera en que se gestionan las asesorías y mejorando la experiencia educativa de los estudiantes. Buscamos innovar continuamente para adaptarnos a las necesidades cambiantes de la comunidad universitaria.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Depenencias
                Container(
                  key: vinculacionKey,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 60,
                    horizontal: 30,
                  ),

                  child: Column(
                    children: [
                      const Text(
                        'Dependencias Vinculadas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),

                      Wrap(
                        spacing: 40,
                        runSpacing: 40,
                        alignment: WrapAlignment.center,

                        children: [
                          logosDependencia('assets/images/dependencias/logofic.png'),

                          logosDependencia('assets/images/dependencias/lidatfic.png'),

                          logosDependencia('assets/images/dependencias/bienestar.png'),

                          logosDependencia('assets/images/dependencias/biblioteca.png'),

                          logosDependencia('assets/images/dependencias/serviciosocial.png'),

                          logosDependencia('assets/images/dependencias/adiuas.png'),
                          
                          logosDependencia('assets/images/dependencias/sau.png'),

                          logosDependencia('assets/images/dependencias/dgvri.png'),

                          logosDependencia('assets/images/dependencias/piefad.png'),

                          logosDependencia('assets/images/dependencias/culturauaslogo.png'),

                          logosDependencia('assets/images/dependencias/direccionartistica.png'),

                          logosDependencia('assets/images/dependencias/psicologia.png'),

                          logosDependencia('assets/images/dependencias/medicina.png'),

                          logosDependencia('assets/images/dependencias/dgep.jpeg'),

                          logosDependencia('assets/images/dependencias/logo_dsgc.png'),

                          logosDependencia('assets/images/dependencias/logo_prodep.jpeg'),

                          logosDependencia('assets/images/dependencias/ciencias.jpg'),

                          logosDependencia('assets/images/dependencias/ccu.jpeg'),

                          logosDependencia('assets/images/dependencias/logo_odontologia.png'),

                          logosDependencia('assets/images/dependencias/EMPRENDEUAS.png'),

                          logosDependencia('assets/images/dependencias/logo_dges.png'),



                          
                        ],
                      ),
                    ],
                  ),
                ),
                SectionFooterTwo(key: contactoKey),
              ],
            ),
          ),

          /* Container(
            width: double.infinity,
            color: Appcolores.azulFuerte,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //Texto inferior
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Contacto',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Facultad de informatica Culiacan\n\n'
                      'C. Josefa Ortiz de Domínguez S/N, Cd Universitaria, CIUDAD UNIVERSITARIA, 80013 Culiacán',
                      style: TextStyle(color: Colors.white, 
                      fontSize: 16),
                    ),

                    const SizedBox(height: 8),
                    const Text(
                      'sitema@correo.com',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.pink,
                          child: Icon()
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ), */
        ],
      ),
    );
  }
}

//contenedor con texto y titulo
Widget contenedorTexto({
  required Key key,
  required String titulo,
  required String contenido,
  Color? color,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool esMovil = constraints.maxWidth < 700;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: esMovil ? 20 : 190),

        child: Container(
          key: key,
          width: double.infinity,

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, 15),
              ),
            ],
          ),

          padding: EdgeInsets.symmetric(
            horizontal: esMovil ? 20 : 60,
            vertical: esMovil ? 35 : 60,
          ),

          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: esMovil ? double.infinity : 900,
              ),
              child: Column(
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: esMovil ? 22 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: esMovil ? 30 : 50),

                  Text(
                    contenido,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: esMovil ? 16 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

//Widgets del menu horizontal
Widget _itemMenu(String text, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(color: Appcolores.gris, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

//widget para tarjeta
Widget _tarjetita(String titulo, String contenido) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,

    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,

      width: 340,
      height: 450,
      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration( 
        color: const Color(0xFFE7E7E7),
        borderRadius: BorderRadius.circular(5),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Titulo de la tarjeta
          Text(
            titulo,
            textAlign: TextAlign.center,

            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 30), //entre el titulo y texto

          Text(
            contenido,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    ),
  );
}

//parte de abajo de la pagina FOOTER
class SectionFooterTwo extends StatelessWidget {
  const SectionFooterTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,

      decoration: BoxDecoration(
        color: Color(0xFF0E0231),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 55, right: 55, top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contacto',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  const Text(
                    'Facultad de Informática Culiacán \n'
                    'C. Josefa Ortiz de Domínguez S/N, Cd Universitaria, CIUDAD UNIVERSITARIA, 80013 Culiacán\n',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      height: 1.5,
                    ),
                  ),
                  const Text(
                    'sitema@correo.com',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 18,
                        ),
                      ),

                      SizedBox(height: 20),

                      CircleAvatar(
                        radius: 16,
                        backgroundColor: const Color.fromARGB(255,255,255,255,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 18,
                        ),
                      ),

                      SizedBox(width: 40),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          '',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Dependencia
Widget logosDependencia(String ruta) {
  return Container(
    width: 90,
    height: 70,
    padding: EdgeInsets.all(10),

    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(8),

      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 5),
      ],
    ),
    child: Image.asset(ruta),
  );
}
