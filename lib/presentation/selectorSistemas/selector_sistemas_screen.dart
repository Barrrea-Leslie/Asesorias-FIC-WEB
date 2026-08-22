import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class SelectorSistemasScreen extends StatelessWidget {
  const SelectorSistemasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final esMovil = MediaQuery.of(context).size.width < 500;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo_inicio.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: OpcionesSistemas(esMovil: esMovil),
      ),
    );
  }
}

class OpcionesSistemas extends StatelessWidget {
  const OpcionesSistemas({super.key, required this.esMovil});

  final bool esMovil;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        //Logo
        Center(
          child: Image.asset(
            'assets/images/Logo.png',
            width: esMovil ? 200 : 210,
          ),
        ),

        SizedBox(height: 40),

        //contenedor de las opciones
        Center(
          child: Container(
            width: 800,
            height: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFC2C2C2)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Elija el modulo al que desee acceder",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: UasColores.azulOficial,
                      ),
                      child: Center(
                        child: Text(
                          "Modulo de Tutorias",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 60),
                    Container(
                      width: 250,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: UasColores.azulOficial,
                      ),
                      child: Center(
                        child: Text(
                          "Modulo de Asistencias",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
