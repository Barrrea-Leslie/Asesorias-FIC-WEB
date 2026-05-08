import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Conocenos extends StatelessWidget {
  const Conocenos({super.key});

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(
    //   builder: context, constraints){
    //   final bool esMovil = constraints.maxWidth < 700;
    // }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Appcolores.azulUas,
              padding: EdgeInsets.symmetric(horizontal: 100),

              child: Row(
                children: [
                  SizedBox(width: 550),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Asesorias FIC',
                        style: TextStyle(
                          color: Appcolores.gris,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Facultad de informatica Culiacan',
                        style: TextStyle(
                          color: Appcolores.gris,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
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
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _itemMenu('Nuestro equipo'),
                  _itemMenu('Nuestro proyecto'),
                  _itemMenu('¿Quienes somos?'),
                  _itemMenu('¿Como surgio?'),
                  _itemMenu('Objetivos'),
                  _itemMenu('Mision y Vision'),
                  _itemMenu('Vinculacion'),
                  _itemMenu('Agradecimiento'),
                  _itemMenu('Contacto'),
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
                  width: double.infinity,
                  color: const Color(0xFFE8E1CF),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 50
                  ),

                  child: Center(
                    child: SizedBox(
                      width: 900,

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
                    children: [
                      _tarjetita(
                        'GERENTES DE PROYECTO',
                        'MC. Alejandro Yahir Sicairos Ochoa  C. Axel Manuel Aguilar Perez MGTI.\n Oscar Mejía Quintero \nJose Angel Astorga Mejia',
                      ),
                      _tarjetita('GERENTES DE DESARROLLO', ''),
                      _tarjetita('ESPECIALISTAS SEO', ''),
                      _tarjetita('ANALISTAS DE DESARROLLO Y CALIDAD', ''),
                      _tarjetita('DISEÑADOR UI/UX', ''),
                    ],
                  ),
                ),

                const SizedBox(height: 80), //espacio entre el bloque
                //TERCER CONTENEDOR
                Container(
                  width: double.infinity,
                  color: const Color(0xffb6c3db),
                  padding: const EdgeInsets.symmetric(horizontal: 120,
                    vertical: 50),

                  child: Column(
                    children: [
                      const Text(
                        'Nuestro proyecto',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: 900,
                        child: const Text(
                          'El Sistema de tutorías FIC es una plataforma móvil y web desarrollada para permitir la gestión de asesorías en la facultad de informática de culiacan, facilitando la interacción entre estudiantes, asesores y administradores mediante una plataforma moderna, eficiente y centralizada.\n\n'
                          'Sus objetivos principales son automatizar la solicitud, aprobación y seguimiento de asesorías y proveer a los estudiantes un espacio para consultar horarios disponibles y enviar solicitudes para asesorías.\n\n'
                          'En el sistema se facilita a los asesores la administración de sus horarios, asesorías, evidencias y reportes, además de la generación de historial y evidencia de cada asesoría para respaldos y evaluaciones.\n\n'
                          'El desarrollo de este sistema busca digitalizar y automatizar el flujo completo de asesorías, tanto para estudiantes, asesores disciplinares y pares, como para administradores, mejorando la comunicación, la organización y la eficiencia operativa.',

                          textAlign: TextAlign.justify,

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),

                //Quienes somos
                Container(
                  width: double.infinity,
                  color: const Color(0xffb6c3db),
                  padding: const EdgeInsets.symmetric(horizontal: 120,
                    vertical: 50),

                  child: Column(
                    children: [
                      const Text(
                        '¿Quienes somos?',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 70),

                      SizedBox(
                        width: 900,
                        child: const Text(
                          'Somos el Laboratorio de Innovación, Desarrollo Académico y Tecnológico de la Facultad de Informática Culiacán, un espacio dedicado a la creación de soluciones tecnológicas que impacten positivamente los procesos académicos y administrativos dentro de la universidad.\n\n'
                          'Nuestro laboratorio está conformado por estudiantes y docentes comprometidos con la mejora continua, la transformación digital y la implementación de herramientas tecnológicas reales que resuelvan problemáticas institucionales. Trabajamos en proyectos de software, automatización de procesos, desarrollo web, sistemas de gestión y propuestas innovadoras orientadas a la eficiencia operativa.\n\n'
                          'Más que un espacio de desarrollo, somos un equipo que busca aplicar el conocimiento adquirido en el aula para generar soluciones funcionales que beneficien directamente a la comunidad universitaria.',

                          textAlign: TextAlign.justify,

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),

                //como surgio
                Container(
                  width: double.infinity,
                  color: const Color(0xffb6c3db),
                  padding: const EdgeInsets.symmetric(horizontal: 120,
                    vertical: 50),

                  child: Column(
                    children: [
                      const Text(
                        '¿Como surgio?',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 70),

                      SizedBox(
                        width: 900,
                        child: const Text(
                          'El Sistema de Tutorías FIC surgió como respuesta a la necesidad de mejorar la gestión de asesorías en la Facultad de Informática Culiacán. Observamos que muchos estudiantes enfrentaban dificultades para acceder a las asesorías y que los asesores necesitaban una herramienta eficiente para administrar sus horarios y solicitudes. Con el apoyo de Bienestar Universitario y el Laboratorio de Innovación, decidimos desarrollar una plataforma que facilite esta interacción, optimizando los procesos y promoviendo un ambiente académico más colaborativo y accesible.',

                          textAlign: TextAlign.justify,

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 70),

                //objetivos
                Container(
                  width: double.infinity,
                  color: const Color(0xffb6c3db),
                  padding: const EdgeInsets.symmetric(horizontal: 120,
                    vertical: 50),

                  child: Column(
                    children: [
                      const Text(
                        'Objetivos',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 70),

                      SizedBox(
                        width: 900,
                        child: const Text(
                          '',

                          textAlign: TextAlign.justify,

                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),

                //Alcance
                Container(
                  width: double.infinity,
                  color: const Color(0xffb6c3db),
                  padding: const EdgeInsets.symmetric(horizontal: 120,
                    vertical: 50),

                  child: Column(
                    children: [
                      const Text(
                        'Alcance',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 50),

                      SizedBox(
                        width: 900,
                        child: const Text(
                          'Gestión de asesorías: Permitir a los estudiantes solicitar asesorías de manera sencilla y a los asesores gestionar sus horarios y citas.\n\n'
                          'Interacción eficiente: Facilitar la comunicación entre estudiantes, asesores y administradores a través de una plataforma centralizada. \n\n'
                          'Automatización de procesos: Automatizar la solicitud, aprobación y seguimiento de asesorías para reducir tiempos de espera y mejorar la experiencia del usuario. \n\n '
                          'Historial y reportes: Generar un historial de asesorías y reportes que permitan a los administradores evaluar la efectividad del sistema y realizar mejoras continuas.',

                          textAlign: TextAlign.justify,

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Mision y vision
                Container(
                  padding: const EdgeInsets.all(30),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Mision y Vision',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 70),

                      Wrap(
                        spacing: 70,
                        runSpacing: 70,
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
                  width: double.infinity,
                  color: const Color(0xFFF3F3F3),
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
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
                      const SizedBox(height: 50),

                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,

                        children: [],
                      ),
                    ],
                  ),
                ),
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

//Widgets del menu horizontal
Widget _itemMenu(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: TextButton(
      onPressed: () {},
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

      width: 350,
      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: const Color(0xFFE7E7E7),
        borderRadius: BorderRadius.circular(5),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
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
