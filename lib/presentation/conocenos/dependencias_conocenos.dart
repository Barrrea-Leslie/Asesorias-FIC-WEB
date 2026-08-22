import 'package:flutter/material.dart';


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

