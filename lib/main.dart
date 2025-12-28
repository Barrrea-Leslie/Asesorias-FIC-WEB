import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/rol_administrador/informacion_asesorias_en_curso.dart';
import 'package:asesorias_fic/routes/app_routes.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,

      onGenerateRoute: (settings) {
        if (settings.name == "/informacionAsesoriaEnCurso") {
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const InformacionAsesoriasEnCurso(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final slide = Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              );

              return SlideTransition(
                position: slide,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          );
        }
        return null; // deja que Flutter use routes normales
      },

      theme: ThemeData(
        primaryColor: Appcolores.azulUas,
        brightness: Brightness.light,
        focusColor: Appcolores.azulUas
      ),
      themeMode: ThemeMode.system,
    );
  }
}