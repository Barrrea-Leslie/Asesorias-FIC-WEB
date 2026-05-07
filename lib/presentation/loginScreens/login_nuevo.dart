import 'dart:developer';

import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class LoginNuevo extends StatelessWidget {
  const LoginNuevo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Seccion arriba con logo y titulo
        Container(
          color: Appcolores.amarilloUas,
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo_uas.png',
                width: 160,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),

        //Seccion de medio donde esta el formulario de registro
        Expanded(child: Text("Offroad")),

        //Seccion de abajo donde esta el footer
        Container(
          width: double.infinity,
          color: Appcolores.azulFuerte,
          child: Text("Daou"),
        ),
      ],
    );
  }
}
