import 'package:asesorias_fic/presentation/loginScreens/login_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_diciplinares_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_par_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesorias_en_curso_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/base_paginas_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/estudiantes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/reportes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/solicitudes_penidentes_screen.dart';
import 'package:asesorias_fic/presentation/rol_administrador/informacion_asesorias_en_curso.dart';
import 'package:asesorias_fic/presentation/rol_administrador/modalesAdministrador/crear_asesor_disiplinar.dart';
import 'package:asesorias_fic/presentation/rol_administrador/pagina_base.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {


  static const initialRoute = '/paginaBase';


  static Map <String, WidgetBuilder> routes = {

    '/login': (context) => const LoginScreen(),
    
    '/asesoriasEnCurso': (context) => const AsesoriasEnCursoScreen(),
    '/solicitudesPendientes': (context) => const SolicitudesPenidentesScreen(),
    '/reportes': (context) => const ReportesScreen(),
    '/asesoresDiciplinares': (context) => const AsesoresDiciplinaresScreen(),
    '/asesoresPar': (context) => const AsesoresParScreen(),
    '/estudiantes': (context) => const EstudiantesScreen(),
    '/crearAsesorDisiplinar': (context) => const CrearAsesorDisiplinar(),

    '/informacionAsesoriaEnCurso': (context) => const InformacionAsesoriaEnCurso(),

    '/basePaginas': (context) => const BasePaginasScreen(),
    
    '/paginaBase': (context) => const HomePage(),

    


  };

}

