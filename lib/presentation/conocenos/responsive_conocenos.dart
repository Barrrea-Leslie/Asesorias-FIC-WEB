import 'package:flutter/material.dart';
import 'breakPoints_conocenos.dart';

class ResponsiveConocenos {
  //es movil
  static bool isMobile(BuildContext context){
    return MediaQuery.of(context).size.width < BreakpointsConocenos.mobile;
  }

  //es tablet
  static bool isTablet(BuildContext context){
    final width=MediaQuery.of(context).size.width;

    return width >= BreakpointsConocenos.mobile && width < BreakpointsConocenos.tablet;
  }

  //si es escritorio??
  static bool isDesktop(BuildContext context){
    return MediaQuery.of(context).size.width >= BreakpointsConocenos.tablet;
  }

  //padding hortizontal de las secciones
  static double horizontalPadding(BuildContext context){
    final width = MediaQuery.of(context).size.width;

    if (width < BreakpointsConocenos.mobile) {
      return 20;
    }
    if (width < BreakpointsConocenos.tablet) {
      return 40;
    }
    return 60;
  }

  //separacion de secciones
  static double sectionSpacing(BuildContext context){
    final width = MediaQuery.of(context).size.width;

    if (width < BreakpointsConocenos.mobile) {
      return 40;
    }
    if (width < BreakpointsConocenos.tablet) {
      return 60;
    }
    return 80;
  }

  //tamaño de titulos principales
  static double titleSize(BuildContext context){
    final width = MediaQuery.of(context).size.width;

    if (width < BreakpointsConocenos.mobile) {
      return 22;
    }
    if (width < BreakpointsConocenos.tablet) {
      return 26;
    }
    return 30;
  }


  //tamaño del texto
  static double textSizeBody(BuildContext context){
    final width = MediaQuery.of(context).size.width;

    if (width < BreakpointsConocenos.mobile) {
      return 16;
    }
    if (width < BreakpointsConocenos.tablet) {
      return 18;
    }
    return 20;
  }

///////ANCHO MAX DEL CONTENEDOR//////
static double maxContenedor(BuildContext context){
  final width = MediaQuery.of(context).size.width;

  if (width < BreakpointsConocenos.mobile) {
    return double.infinity;
  }
  if (width < BreakpointsConocenos.tablet) {
    return 900;
  }
  return 1100;
}



}