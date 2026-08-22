import 'breakPoints_conocenos.dart'; 
import 'package:asesorias_fic/presentation/conocenos/responsive_conocenos.dart';
import 'package:flutter/material.dart';

Widget tarjetaMision(BuildContext context, String titulo, String contenido) {
  final width = MediaQuery.of(context).size.width;

  double tarjetaSize;

  if (width < BreakpointsConocenos.mobile) {
    tarjetaSize = width - 40;
  } else if(width < BreakpointsConocenos.tablet) {
    tarjetaSize = 600;
  }else{
    tarjetaSize = 500;
  }

  return Container(
    width: tarjetaSize,
    constraints: const BoxConstraints(
      minHeight: 320
    ),
    padding: const EdgeInsets.all(35),

    decoration: BoxDecoration(
      color: const Color(0xFF08338f),
      borderRadius: BorderRadius.circular(5),

      boxShadow: [BoxShadow(color: Colors.black..withOpacity(0.8),
      blurRadius: 4,
      )],
    ),

    child: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(titulo,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: ResponsiveConocenos.titleSize(context),
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 229, 223, 223),
      ),
      ),
      const SizedBox(height: 25),

      Text(
        contenido,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: ResponsiveConocenos.textSizeBody(context),
          height: 1.7,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 229, 223, 223),
        ),
      )

    ],
    ),
  );
}