import 'package:asesorias_fic/presentation/loginScreens/inicio_sesion.dart';
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

//widget para la navegacion login
Widget navegacioLoginTwo(BuildContext context) {
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
        width: 90,
        height: 90,
        fit: BoxFit.contain,
      ),
    ),
  );
}
