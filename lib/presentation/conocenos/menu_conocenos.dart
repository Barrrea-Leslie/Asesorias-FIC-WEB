import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/conocenos/responsive_conocenos.dart';
import 'package:flutter/material.dart';

////////////////// agregado hoy viernes
class MenuConocenos extends StatelessWidget {
  final GlobalKey nuestroEquipooKey;
  final GlobalKey nuestroProyectoKey;
  final GlobalKey quienesSomosKey;
  final GlobalKey comoSurgioKey;
  final GlobalKey objetivosKey;
  final GlobalKey misionVKey;
  final GlobalKey vinculacionKey;
  final GlobalKey agradecimientosKey;
  final GlobalKey contactoKey;

  final void Function(GlobalKey key)
  irASection; //funcion que esta en conocenos.dart

  const MenuConocenos({
    super.key,
    required this.nuestroEquipooKey,
    required this.nuestroProyectoKey,
    required this.quienesSomosKey,
    required this.comoSurgioKey,
    required this.objetivosKey,
    required this.misionVKey,
    required this.vinculacionKey,
    required this.agradecimientosKey,
    required this.contactoKey,

    required this.irASection,
  });

  @override
  Widget build(BuildContext context) {
    final isMovil = ResponsiveConocenos.isMobile(context);

    return SliverAppBar(
      backgroundColor: const Color(0xFFc49e0d),

      pinned: !isMovil,
      floating: isMovil,  //si es movil

      automaticallyImplyLeading: false,
      titleSpacing: 0,

      toolbarHeight: isMovil ? 40 : 60,
      centerTitle: true,

      title: Transform.translate(
        offset: Offset(0, isMovil ? -10 : 0),
      child: Center(
        child: SizedBox(
        height: isMovil ? 40 : 60,
        width: double.infinity,
        

        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,

                  children: [
                    itemMenu('Nuestro equipo', () => irASection(nuestroEquipooKey),isMovil),

                    itemMenu( 'Nuestro proyecto', () => irASection(nuestroProyectoKey),isMovil),

                    itemMenu('¿Quienes somos?',() => irASection(quienesSomosKey),isMovil),

                    itemMenu('¿Como surgio?', () => irASection(comoSurgioKey),isMovil),

                    itemMenu('Objetivos', () => irASection(objetivosKey),isMovil),

                    itemMenu( 'Agradecimiento',() => irASection(agradecimientosKey),isMovil),

                    itemMenu('Misión y Visión', () => irASection(misionVKey),isMovil),


                    itemMenu('Vinculacion', () => irASection(vinculacionKey),isMovil),

                    itemMenu('Contacto', () => irASection(contactoKey),isMovil),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      ),
      ),
    );
    
  }
}

////////////////////////////////////

//Widgets del menu horizontal
Widget itemMenu(String text, VoidCallback onTap, bool isMovil) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal:isMovil ? 5 : 10),  //ESPACIO ENTRE LOS OBJETOS DEL MENU

    child: TextButton(
      onPressed: onTap,

      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal:  10),

         minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, 
        alignment: Alignment.center
      ),

      child: Text(
        text,
        maxLines: 1,
        softWrap: false, 

        style: const TextStyle(
          color: Appcolores.gris,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          height: 1.0,
        ),
      ),
    ),
  );
}
