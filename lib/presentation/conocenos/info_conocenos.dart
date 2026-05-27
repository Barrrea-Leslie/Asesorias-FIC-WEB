import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';


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
            borderRadius: BorderRadius.circular(5),
            color: UasColores.azulOficial,
            

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
                maxWidth: esMovil ? double.infinity : 950,
              ),
              child: Column(
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: esMovil ? 22 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: esMovil ? 30 : 50),

                  Text(
                    contenido,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: esMovil ? 16 : 20,
                      fontWeight: FontWeight.bold,
                       color:  Colors.white,
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