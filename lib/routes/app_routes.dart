
/*
import 'package:asesorias_fic/presentation/conocenos/conocenos.dart';
import 'package:asesorias_fic/presentation/loginScreens/inicio_sesion.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_diciplinares_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_par_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesorias_en_curso_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/estudiantes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/reportes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/solicitudes_penidentes_screen.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/crear_asesor_disiplinar.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/crear_asesor_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/informacion_asesor_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/pagina_base_administrador.dart';
import 'package:asesorias_fic/presentation/rol_asesor/pagina_base_asesor.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/pagina_base_estudiante.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/informacion_asesores.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static const initialRoute = '/inicioSesion';

  // ZONA PÚBLICA (Cualquiera puede entrar sin loguearse)
  static final Map<String, WidgetBuilder> publicRoutes = {
    '/inicioSesion': (context) => const InicioSesion(),
    '/paginaConocenos': (context) => const Conocenos(),
  };

  // ZONA ADMINISTRADOR (Solo Roles 4 y 2)
  static final Map<String, WidgetBuilder> adminRoutes = {
    '/panelAdmin': (context) => const HomePage(),
    '/asesoriasEnCurso': (context) => const AsesoriasEnCursoScreen(),
    '/solicitudesPendientes': (context) => const SolicitudesPenidentesScreen(),
    '/reportes': (context) => const ReportesScreen(),
    '/asesoresDiciplinares': (context) => const AsesoresDiciplinaresScreen(),
    '/asesoresPar': (context) => const AsesoresParScreen(),
    '/informacionAsesorPar': (context) => const InformacionAsesoresPar(),
    '/crearAsesorPar': (context) => const CrearAsesoresPar(),
    '/estudiantes': (context) => const EstudiantesScreen(),
    '/crearAsesorDisiplinar': (context) => const CrearAsesorDisiplinar(),
  };

  // ZONA ESTUDIANTE (Solo Rol 4)
  static final Map<String, WidgetBuilder> estudianteRoutes = {
    '/panelEstudiante': (context) => const PaginaBaseEstudiante(),
    '/filtrosAsesoria': (context) => const FiltrosAsesoria(),
    '/informacionAsesores': (context) => const InformacionAsesores(),
  };

  // ZONA ASESOR (Solo Roles 3 y 5)
  static final Map<String, WidgetBuilder> asesorRoutes = {
    '/panelAsesor': (context) => const PaginaBaseAsesor(),
  };

  // UNION GLOBAL (Une todos los mapas para que Flutter los reconozca al iniciar)
  static final Map<String, WidgetBuilder> routes = {
    ...publicRoutes,
    ...adminRoutes,
    ...estudianteRoutes,
    ...asesorRoutes,
  };
}
*/




import 'package:asesorias_fic/presentation/conocenos/conocenos.dart';
import 'package:asesorias_fic/presentation/loginScreens/inicio_sesion.dart';
import 'package:asesorias_fic/presentation/loginScreens/login_nuevo.dart';
import 'package:asesorias_fic/presentation/loginScreens/login_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_diciplinares_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_par_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesorias_en_curso_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/estudiantes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/reportes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/solicitudes_penidentes_screen.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/crear_asesor_disiplinar.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/crear_asesor_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/informacion_asesor_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/pagina_base_administrador.dart';
import 'package:asesorias_fic/presentation/rol_asesor/pagina_base_asesor.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/pagina_base_estudiante.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/informacion_asesores.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static const initialRoute = '/inicioSesion';

  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => const LoginScreen(),

    //Direcciones del rol de administrador
    '/asesoriasEnCurso': (context) => const AsesoriasEnCursoScreen(),

    '/solicitudesPendientes': (context) => const SolicitudesPenidentesScreen(),

    '/reportes': (context) => const ReportesScreen(),

    '/asesoresDiciplinares': (context) => const AsesoresDiciplinaresScreen(),

    '/asesoresPar': (context) => const AsesoresParScreen(),
    '/informacionAsesorPar': (context) => const InformacionAsesoresPar(),
    '/crearAsesorPar': (context) => const CrearAsesoresPar(),

    '/estudiantes': (context) => const EstudiantesScreen(),
    '/crearAsesorDisiplinar': (context) => const CrearAsesorDisiplinar(),

    '/filtrosAsesoria': (context) => const FiltrosAsesoria(),

    '/panelAdmin': (context) => const HomePage(),

    //Direcciones del rol de estudiante
    '/informacionAsesores': (context) => const InformacionAsesores(),

    '/panelEstudiante': (context) => const PaginaBaseEstudiante(),

    //Direcciones del rol de asesores
    '/panelAsesor': (context) => const PaginaBaseAsesor(),

    '/loginNuevo': (context) => const LoginNuevo(),

    //Direccion de conocenos
    '/paginaConocenos': (conttext) => const Conocenos(),

    '/inicioSesion': (context) => const InicioSesion(),
  };
}
