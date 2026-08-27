import 'package:asesorias_fic/presentation/conocenos/conocenos.dart';
import 'package:asesorias_fic/presentation/loginScreens/inicio_sesion.dart';
import 'package:asesorias_fic/presentation/loginScreens/login_nuevo.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_diciplinares_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_par_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesorias_en_curso_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/estudiantes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/solicitudes_penidentes_screen.dart';
import 'package:asesorias_fic/presentation/selectorSistemas/selector_sistemas_screen.dart';
import 'package:asesorias_fic/presentation/sistemaAsistencias/rol_administrador_as/pagina_base_administrador_as.dart';
import 'package:asesorias_fic/presentation/sistemaAsistencias/rol_administrador_as/reportes/reportes_screen.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_administrador/asesorDiciplinar/crear_asesor_disiplinar.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_administrador/asesorPar/crear_asesor_par.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_administrador/asesorPar/informacion_asesor_par.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_administrador/pagina_base_administrador.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_asesor/pagina_base_asesor.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_estudiante/pagina_base_estudiante.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/rol_estudiante/solicitarAsesoria/informacion_asesores.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static const initialRoute = '/inicioSesion';

  static Map<String, WidgetBuilder> routes = {
    //Login actual - actualizado
    '/inicioSesion': (context) => const InicioSesion(),

    //Direccion de conocenos
    '/paginaConocenos': (conttext) => const Conocenos(),

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

    '/paginaBaseAdministrador': (context) => const HomePage(),

    //Direcciones del rol de estudiante
    '/informacionAsesores': (context) => const InformacionAsesores(),

    '/paginaBaseEstudiantes': (context) => const PaginaBaseEstudiante(),

    //Direcciones del rol de asesores
    '/paginaBaseAsesores': (context) => const PaginaBaseAsesor(),

    '/loginNuevo': (context) => const LoginNuevo(),

    //Direccion de conocenos
    '/paginaConocenos': (conttext) => const Conocenos(),

    '/inicioSesion': (context) => const InicioSesion(),

    //Selector de modulos de cada sistema
    '/selectorSistema': (context) => const SelectorSistemasScreen(),

    //Rutas del sistema de Asistencias/Chechacor

    //Paagina base del adminstrador del sistema de asistencia
    '/paginaBaseAdministradorAs': (context) =>
        const PaginaBaseAdministradorAs(),
  };
}
