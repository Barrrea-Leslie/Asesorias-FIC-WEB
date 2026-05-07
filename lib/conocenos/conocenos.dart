import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class Conocenos extends StatelessWidget {
  const Conocenos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: Appcolores.azulUas,
            padding: const EdgeInsets.symmetric(horizontal: 100),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //AGREGAR UN LOGO AQUII EL DE LA UAS
                const SizedBox(width: 30),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  //Encabesado
                  children: [
                    Text(
                      'Asesorias FIC',
                      style: TextStyle(
                        color: Appcolores.gris,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Facultad de informatica Culiacan',
                      style: TextStyle(
                        color: Appcolores.gris,
                        fontSize: 27,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //Contenedor del menu horizontal
          Container(
            width: double.infinity,
            color: Appcolores.amarilloUas,
            padding: const EdgeInsets.symmetric(vertical: 10),

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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

          //parte de conocenos u acerca de nosotros
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),

            child: Column(
              children: [
                Text(
                  'Acerca de nosotros',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Sistema de tutorias FIC',
                  style: TextStyle(fontSize: 29, color: Colors.black),
                ),
              ],
            ),
          ),

          //cuerpo principal
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //primera seccion
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFE8E1CF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 120,
                      vertical: 50,
                    ),
                    child: const Text(
                      'La Universidad Autónoma de Sinaloa a través de Bienestar Universitario y la Facultad de Informática Culiacán en colaboración con el Laboratorio de Innovación, Desarrollo Académico y Tecnológico de la Facultad de Informática Culiacán, presenta el Sistema de tutorias FIC.',

                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),

                  //segundo container de tarjetitas
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Wrap(
                      spacing: 70,
                      runSpacing: 70,
                      children: [
                        _tarjetita(
                          'GERENTES DE PROYECTO',
                          'MC. Alejandro Yahir Sicairos Ochoa  C. Axel Manuel Aguilar Perez MGTI. Oscar Mejía Quintero Jose Angel Astorga Mejia',
                        ),
                        _tarjetita('GERENTES DE DESARROLLO', ''),
                        _tarjetita('ESPECIALISTAS SEO', ''),
                        _tarjetita('ANALISTAS DE DESARROLLO Y CALIDAD', ''),
                        _tarjetita('DISEÑADOR UI/UX', ''),
                      ],
                    ),
                  ),

                  //tercer contenedor
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),

                    child: Column(
                      children: [
                        Text(
                          'Nuestro proyecto',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 70),

                        Text(
                          'El Sistema de tutorías FIC es una plataforma móvil y web desarrollada para permitir la gestión de asesorías en la facultad de informática de culiacan, facilitando la interacción entre estudiantes, asesores y administradores mediante una plataforma moderna, eficiente y centralizada.\n Sus objetivos principales son automatizar la solicitud, aprobación y seguimiento de asesorías y proveer a los estudiantes un espacio para consultar horarios disponibles y enviar solicitudes para asesorías.\n En el sistema se facilita a los asesores la administración de sus horarios, asesorías, evidencias y reportes, además de la generación de historial y evidencia de cada asesoría para respaldos y evaluaciones.\n l desarrollo de este sistema busca digitalizar y automatizar el flujo completo de asesorías, tanto para estudiantes, asesores disciplinares y pares, como para administradores, mejorando la comunicación, la organización y la eficiencia operativa.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //cuarto contenedor
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),

                    child: Column(
                      children: [
                        Text(
                          '¿Quienes somos',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 70),

                        Text(
                          'Somos el Laboratorio de Innovación, Desarrollo Académico y Tecnológico de la Facultad de Informática Culiacán, un espacio dedicado a la creación de soluciones tecnológicas que impacten positivamente los procesos académicos y administrativos dentro de la universidad.\n Nuestro laboratorio está conformado por estudiantes y docentes comprometidos con la mejora continua, la transformación digital y la implementación de herramientas tecnológicas reales que resuelvan problemáticas institucionales. Trabajamos en proyectos de software, automatización de procesos, desarrollo web, sistemas de gestión y propuestas innovadoras orientadas a la eficiencia operativa.\n Más que un espacio de desarrollo, somos un equipo que busca aplicar el conocimiento adquirido en el aula para generar soluciones funcionales que beneficien directamente a la comunidad universitaria.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //tercer contenedor
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),

                    child: Column(
                      children: [
                        Text(
                          '¿Como surgio?',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 70),

                        Text(
                          'El Sistema de Tutorías FIC surgió como respuesta a la necesidad de mejorar la gestión de asesorías en la Facultad de Informática Culiacán. Observamos que muchos estudiantes enfrentaban dificultades para acceder a las asesorías y que los asesores necesitaban una herramienta eficiente para administrar sus horarios y solicitudes. Con el apoyo de Bienestar Universitario y el Laboratorio de Innovación, decidimos desarrollar una plataforma que facilite esta interacción, optimizando los procesos y promoviendo un ambiente académico más colaborativo y accesible.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //OBJETIVOS
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),

                    child: Column(
                      children: [
                        Text(
                          'Objetivos',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 70),

                        Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Alcance
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),

                    child: Column(
                      children: [
                        Text(
                          'Alcance',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 70),

                        Text(
                          'Gestión de asesorías: Permitir a los estudiantes solicitar asesorías de manera sencilla y a los asesores gestionar sus horarios y citas.\n Interacción eficiente: Facilitar la comunicación entre estudiantes, asesores y administradores a través de una plataforma centralizada. \n Automatización de procesos: Automatizar la solicitud, aprobación y seguimiento de asesorías para reducir tiempos de espera y mejorar la experiencia del usuario. \n Historial y reportes: Generar un historial de asesorías y reportes que permitan a los administradores evaluar la efectividad del sistema y realizar mejoras continuas.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //MISION Y VISION
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Mision y Vision',
                          style: TextStyle(
                            fontSize: 38,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Widgets del menu horizontal
Widget _itemMenu(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Appcolores.gris,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

//widget para tarjeta
Widget _tarjetita(String titulo, String contenido) {
  return Container(
    width: 400,
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: Appcolores.gris,
      borderRadius: BorderRadius.circular(1),

      //boxShadow: [BoxShadow(color: Colors.black, blurRadius: 0)],
    ),
    child: Column(
      children: [
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 70),

        Text(
          contenido,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
