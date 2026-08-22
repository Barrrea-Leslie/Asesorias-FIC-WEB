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
        SizedBox(height: 70),
        //Logo
        Center(
          child: Image.asset(
            'assets/images/Logo.png',
            width: esMovil ? 150 : 210,
          ),
        ),

        SizedBox(height: 40),

        //contenedor de las opciones
        Center(
          child: Container(
            width: esMovil ? 330 : 800,
            height: esMovil ? 530 : 380,
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
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Flex(
                  direction: esMovil ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OpcionModulo(
                      esMovil: esMovil,
                      nombreOpcion: "Modulo de Tutorias",
                      rutaOpcion: '/paginaBaseAdministrador',
                    ),
                    SizedBox(width: esMovil ? 0 : 60, height: esMovil ? 50 : 0),
                    OpcionModulo(
                      esMovil: esMovil,
                      nombreOpcion: "Modulo de Asistencias",
                      rutaOpcion: '/paginaBaseAdministradorAs',
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

class OpcionModulo extends StatelessWidget {
  const OpcionModulo({
    super.key,
    required this.esMovil,
    required this.nombreOpcion,
    required this.rutaOpcion,
  });

  final bool esMovil;
  final String nombreOpcion;
  final String rutaOpcion;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, rutaOpcion);
        },
        child: Container(
          width: esMovil ? 210 : 250,
          height: esMovil ? 110 : 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: UasColores.azulOficial,
          ),
          child: Center(
            child: Text(
              nombreOpcion,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: esMovil ? 16 : 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
