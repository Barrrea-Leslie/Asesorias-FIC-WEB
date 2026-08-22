import 'package:flutter/material.dart';


const List<String> dependencias = [
'assets/images/dependencias/logofic.png',
'assets/images/dependencias/lidatfic.png',
 'assets/images/dependencias/bienestar.png',
 'assets/images/dependencias/biblioteca.png',
  'assets/images/dependencias/serviciosocial.png',
  'assets/images/dependencias/adiuas.png',
   'assets/images/dependencias/sau.png',
   'assets/images/dependencias/dgvri.png',
   'assets/images/dependencias/piefad.png',
   'assets/images/dependencias/culturauaslogo.png',
   'assets/images/dependencias/direccionartistica.png',
   'assets/images/dependencias/psicologia.png',
   'assets/images/dependencias/medicina.png',
   'assets/images/dependencias/dgep.jpeg',
    'assets/images/dependencias/logo_dsgc.png',
    'assets/images/dependencias/logo_prodep.jpeg',
     'assets/images/dependencias/radio_uas.png',
     'assets/images/dependencias/ciencias.jpg',
     'assets/images/dependencias/ccu.jpeg',
'assets/images/dependencias/logo_odontologia.png',
 'assets/images/dependencias/EMPRENDEUAS.png',
  'assets/images/dependencias/logo_dges.png',
];


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

Widget seccionDependencias({
  required GlobalKey key,
}) {
  return Padding(padding: const EdgeInsetsGeometry.symmetric(vertical: 70),
  child: Container(key: key,
  width: double.infinity,
  padding: const EdgeInsets.symmetric(
    vertical: 60,
    horizontal: 30,
  ),
  child: Column(children: [
    const Text('Dependencias Vinculadas',
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

      children: dependencias .map((ruta) => logosDependencia(ruta),).toList(),  //crea las tarjetas
      

      
    ),
  ],
  ),
  ),
  );
}

