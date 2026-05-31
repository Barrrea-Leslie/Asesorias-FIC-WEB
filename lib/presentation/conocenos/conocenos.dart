import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/conocenos/dependencias_conocenos.dart';
import 'package:asesorias_fic/presentation/conocenos/info_conocenos.dart';
import 'package:asesorias_fic/presentation/conocenos/menu_conocenos.dart';
import 'package:asesorias_fic/presentation/conocenos/tarjetas_conocenos.dart';
import 'package:asesorias_fic/presentation/loginScreens/inicio_sesion.dart';
import 'package:flutter/material.dart';
import 'footer_conocenos.dart';

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
    final width = MediaQuery.of(context).size.width;

    final bool esMovil = width < 700;
    final bool esTablet = width >= 700 && width < 1100;
    final bool esDesktop = width >= 1100;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(minHeight: esMovil ? 110 : 140),

              color: UasColores.azulOficial,
              padding: EdgeInsets.symmetric(
                horizontal: esMovil ? 16 : 60,
                vertical: esMovil ? 8 : 10,
              ),

              child: Row(
                children: [
                  navegacioLoginTwo(context),

                  SizedBox(width: esMovil ? 20 : 20),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: esMovil
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,

                      children: [
                        Text(
                          'Asesorias FIC',
                          textAlign: esMovil
                              ? TextAlign.start
                              : TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 245, 246, 247),
                            fontSize: esMovil ? 22 : 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Facultad de informatica Culiacan',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 228, 232, 238),
                            fontSize: esMovil ? 13 : 22,
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
            backgroundColor: Color(0xFFc49e0d),
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
                padding: EdgeInsets.symmetric(horizontal: esMovil ? 5 : 40),
                children: [
                  itemMenu(
                    'Nuestro equipo',
                    () => irASection(nuestroEquipooKey),
                  ),
                  itemMenu(
                    'Nuestro proyecto',
                    () => irASection(nuestroProyectoKey),
                  ),
                  itemMenu(
                    '¿Quienes somos?',
                    () => irASection(quienesSomosKey),
                  ),
                  itemMenu('¿Como surgio?', () => irASection(comoSurgioKey)),
                  itemMenu('Objetivos', () => irASection(objetivosKey)),
                  itemMenu('Mision y Vision', () => irASection(misionVKey)),
                  itemMenu('Vinculacion', () => irASection(vinculacionKey)),
                  itemMenu(
                    'Agradeciniento',
                    () => irASection(agradecimientosKey),
                  ),
                  itemMenu('Contacto', () => irASection(contactoKey)),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 70),
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
                  color: Color(0xFFC59525).withOpacity(0.15),
                  padding: EdgeInsets.symmetric(
                    horizontal: esMovil ? 20 : 80,
                    vertical: esMovil ? 40 : 70,
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

                const SizedBox(height: 70),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 70,
                    runSpacing: 50,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      tarjetita(
                        'GERENTES DE PROYECTO',
                        'Evelia Inzunza García\n'
                            'MC. Alejandro Yahir Sicairos Ochoa\n'
                            'Oscar Mejía Quintero\n'
                            'Jose Angel Astorga Mejia',
                      ),

                      tarjetita(
                        'GERENTES DE DESARROLLO',
                        'Jose Angel Astorga Mejia\n'
                            'Leslie Mayram Barrera Rodriguez\n'
                            'Raquel del Pilar Ibarra Meza\n'
                            'Bhrandon Nedel Medina Hernandez\n'
                            'Erick Fernando Sanchez Barraza\n'
                            'Jenifer Guadalupe Tizoc Lopez',
                      ),

                      tarjetita('ESPECIALISTAS SEO', ''),
                      tarjetita('ANALISTAS DE DESARROLLO Y CALIDAD', ''),
                      tarjetita('DISEÑADOR UI/UX', ''),
                    ],
                  ),
                ),

                const SizedBox(height: 80), //espacio entre el bloque
                //TERCER CONTENEDOR
                contenedorTexto(
                  key: nuestroProyectoKey,

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

                  titulo: '¿Como surgio?',
                  contenido:
                      'El Sistema de Tutorías FIC surgió como respuesta a la necesidad de mejorar la gestión de asesorías en la Facultad de Informática Culiacán. Observamos que muchos estudiantes enfrentaban dificultades para acceder a las asesorías y que los asesores necesitaban una herramienta eficiente para administrar sus horarios y solicitudes. Con el apoyo de Bienestar Universitario y el Laboratorio de Innovación, decidimos desarrollar una plataforma que facilite esta interacción, optimizando los procesos y promoviendo un ambiente académico más colaborativo y accesible.',
                ),

                const SizedBox(height: 80),

                //objetivos
                contenedorTexto(
                  key: objetivosKey,

                  titulo: 'Objetivos',
                  contenido: '',
                ),
                const SizedBox(height: 80),

                //Alcance
                contenedorTexto(
                  key: agradecimientosKey,

                  titulo: 'Alcance',

                  contenido:
                      'Gestión de asesorías: Permitir a los estudiantes solicitar asesorías de manera sencilla y a los asesores gestionar sus horarios y citas.\n\n'
                      'Interacción eficiente: Facilitar la comunicación entre estudiantes, asesores y administradores a través de una plataforma centralizada. \n\n'
                      'Automatización de procesos: Automatizar la solicitud, aprobación y seguimiento de asesorías para reducir tiempos de espera y mejorar la experiencia del usuario. \n\n '
                      'Historial y reportes: Generar un historial de asesorías y reportes que permitan a los administradores evaluar la efectividad del sistema y realizar mejoras continuas.',
                ),

                SizedBox(height: 135),

                //Mision y vision
                Container(
                  key: misionVKey,
                  padding: EdgeInsets.symmetric(horizontal: esMovil ? 20 : 80),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 40,
                        runSpacing: 40,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          tarjetaMision(
                            'Mision',
                            'Nuestra misión es proporcionar una plataforma digital que facilite la gestión de asesorías en la Facultad de Informática de Culiacán, promoviendo la interacción efectiva entre estudiantes y asesores y contribuyendo al desarrollo académico de los estudiantes mediante el acceso a recursos de asesoría de calidad.',
                          ),
                          tarjetaMision(
                            'Vision',
                            'Nuestra visión es ser un referente en la implementación de soluciones tecnológicas en el ámbito académico, transformando la manera en que se gestionan las asesorías y mejorando la experiencia educativa de los estudiantes. Buscamos innovar continuamente para adaptarnos a las necesidades cambiantes de la comunidad universitaria.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 70),

                //Depenencias
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70),
                  child: Container(
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
                            logosDependencia(
                              'assets/images/dependencias/logofic.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/lidatfic.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/bienestar.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/biblioteca.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/serviciosocial.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/adiuas.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/sau.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/dgvri.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/piefad.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/culturauaslogo.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/direccionartistica.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/psicologia.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/medicina.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/dgep.jpeg',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/logo_dsgc.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/logo_prodep.jpeg',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/radio_uas.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/ciencias.jpg',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/ccu.jpeg',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/logo_odontologia.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/EMPRENDEUAS.png',
                            ),

                            logosDependencia(
                              'assets/images/dependencias/logo_dges.png',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //SECCION DE FOOTER
                SectionFooterTwo(key: contactoKey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//widget para la navegacion login
Widget navegacioLoginTwo(BuildContext context) {
  final esMovil = MediaQuery.of(context).size.width < 700;


  return MouseRegion(
    cursor: SystemMouseCursors.click,

    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InicioSesion()),
        );
      },

      //la imagen y tamaño de la imagen (LOGO)
      child: Image.asset(
        'assets/images/logo_uas.png',
        width: esMovil ? 55: 90,
        height: esMovil ? 55 : 90,
        fit: BoxFit.contain,
      ),
    ),
  );
}


//tarjeta de msion y vision

Widget tarjetaMision(String titulo, String contenido) {
  return Container(
    width: 500,
    height: 390,

    constraints: const BoxConstraints(minHeight: 320),

    padding: const EdgeInsets.all(35),

    decoration: BoxDecoration(
      color: const Color(0xFF08338f),
      borderRadius: BorderRadius.circular(5),

      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 4),
      ],
    ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 229, 223, 223),
          ),
        ),
        const SizedBox(height: 25),

        Text(
          contenido,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 18,
            height: 1.7,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 229, 223, 223),
          ),
        ),
      ],
    ),
  );
}
