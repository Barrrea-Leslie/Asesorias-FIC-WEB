import 'package:asesorias_fic/presentation/loginScreens/login_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_diciplinares_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesores_par_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/asesorias_en_curso_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/estudiantes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/reportes_screen.dart';
import 'package:asesorias_fic/presentation/pageDirection/solicitudes_penidentes_screen.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/crear_asesor_disiplinar.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/informacion_asesor_disciplinar.dart.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/crear_asesor_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorPar/informacion_asesor_par.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesoriasEnCurso/informacion_asesorias_en_curso.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesoriasEnCurso/material_adicional.dart';
import 'package:asesorias_fic/presentation/rol_administrador/estudiantes/informacion_estudiantes.dart';
import 'package:asesorias_fic/presentation/rol_administrador/pagina_base_administrador.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/pagina_base_estudiante.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtro_asesor_.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/filtros_asesoria.dart';
import 'package:asesorias_fic/presentation/rol_estudiante/solicitarAsesoria/informacion_asesores.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {


  static const initialRoute = '/filtroAsesor';


  static Map <String, WidgetBuilder> routes = {

    '/login': (context) => const LoginScreen(),
    
    //Direcciones del rol de administrador

    '/asesoriasEnCurso': (context) => const AsesoriasEnCursoScreen(),
    '/informacionAsesoriaEnCurso': (context) => const InformacionAsesoriaEnCurso(),
    '/materialAdicional': (context) => const MaterialAdicional(),

    '/solicitudesPendientes': (context) => const SolicitudesPenidentesScreen(),

    '/reportes': (context) => const ReportesScreen(),

    '/asesoresDiciplinares': (context) => const AsesoresDiciplinaresScreen(),
    '/informacionAsesorDisciplinar': (context) => const EditarAsesorDisciplinar(),

    '/asesoresPar': (context) => const AsesoresParScreen(),
    '/informacionAsesorPar': (context) => const InformacionAsesoresPar(),
    '/crearAsesorPar': (context) => const CrearAsesoresPar(),

    '/estudiantes': (context) => const EstudiantesScreen(),
    '/crearAsesorDisiplinar': (context) => const CrearAsesorDisiplinar(),
    '/informacionEstudiantes': (context) => const InformacionEstudiantes(),

    '/filtrosAsesoria': (context) => const FiltrosAsesoria(),
    '/filtroAsesor': (context) => const FiltroAsesor(),

    
    '/paginaBaseAdministrador': (context) => const HomePage(),

    //Direcciones del rol de estudiante

    '/informacionAsesores': (context) => const InformacionAsesores(),

    '/paginaBaseEstudiantes': (context) => const PaginaBaseEstudiante(),


  };

}

