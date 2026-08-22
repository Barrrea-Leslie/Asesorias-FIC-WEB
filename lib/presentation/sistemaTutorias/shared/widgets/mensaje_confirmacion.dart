import 'package:flutter/material.dart';

class MensajeConfirmacion {
  MensajeConfirmacion(me);


  static void mostrarMensaje(BuildContext context, String mensaje){

    final snackBar = SnackBar(
      content:
            Text(
            mensaje,
            style: TextStyle(color: Colors.white),
            ),

            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

}
