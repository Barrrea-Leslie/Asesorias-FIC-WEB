import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';


//Widgets del menu horizontal
Widget itemMenu(String text, VoidCallback onTap) {
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