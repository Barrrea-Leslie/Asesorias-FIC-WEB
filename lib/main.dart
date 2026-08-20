
/*
import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/auth_service.dart';
import 'package:asesorias_fic/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      
      // 👑 CAMBIO CLAVE: En lugar de usar initialRoute, usamos 'home' con un FutureBuilder global.
      // Esto evalúa el token una sola vez al arrancar la app o abrir la pestaña, sin romper el ciclo de dibujado.
      home: FutureBuilder(
        future: authService.abrirToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final datosUsuario = snapshot.data;

          // Si no hay token guardado en el navegador, muestro directamente la vista del Login
          if (datosUsuario == null) {
            return AppRoutes.publicRoutes[AppRoutes.initialRoute]!(context);
          }

          final int rol = datosUsuario.idRol;

          // Si el token es válido y la sesión está activa, redirijo síncronamente a su panel según el rol
          if (rol == 2) return AppRoutes.adminRoutes['/paginaBaseAdministrador']!(context); // Ajusta a tu llave real de admin
          if (rol == 4) return AppRoutes.estudianteRoutes['/paginaBaseEstudiante']!(context); // Ajusta a tu llave real de estudiante
          if (rol == 3 || rol == 5) return AppRoutes.asesorRoutes['/paginaBaseAsesor']!(context); // Ajusta a tu llave real de asesor

          // Respaldo de seguridad por si el rol es inválido
          return AppRoutes.publicRoutes[AppRoutes.initialRoute]!(context);
        },
      ),

      // El despachador de rutas ahora es 100% síncrono, lo que evita que Microsoft Edge se congele
      onGenerateRoute: (settings) {
        final String? rutaDestino = settings.name;

        // 1. Si la ruta solicitada no existe en el sistema, lo devuelvo al Login
        if (!AppRoutes.routes.containsKey(rutaDestino)) {
          return MaterialPageRoute(
            builder: AppRoutes.publicRoutes[AppRoutes.initialRoute]!, 
            settings: settings
          );
        }

        // 2. Despacho síncrono de rutas públicas (Login, Conócenos)
        if (AppRoutes.publicRoutes.containsKey(rutaDestino)) {
          return MaterialPageRoute(
            builder: AppRoutes.publicRoutes[rutaDestino]!, 
            settings: settings
          );
        }

        // 3. Despacho síncrono de rutas privadas
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            if (AppRoutes.adminRoutes.containsKey(rutaDestino)) {
              return AppRoutes.adminRoutes[rutaDestino]!(context);
            }
            if (AppRoutes.estudianteRoutes.containsKey(rutaDestino)) {
              return AppRoutes.estudianteRoutes[rutaDestino]!(context);
            }
            if (AppRoutes.asesorRoutes.containsKey(rutaDestino)) {
              return AppRoutes.asesorRoutes[rutaDestino]!(context);
            }
            return AppRoutes.publicRoutes[AppRoutes.initialRoute]!(context);
          },
        );
      },

      theme: ThemeData(
        primaryColor: Appcolores.azulUas,
        focusColor: const Color.fromARGB(64, 8, 51, 143)
      ),
      themeMode: ThemeMode.system,
    );
  }
}
*/

import 'package:asesorias_fic/core/colores.dart';
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


      theme: ThemeData(
        primaryColor: Appcolores.azulUas,
        focusColor: const Color.fromARGB(64, 8, 51, 143)
      ),
      themeMode: ThemeMode.system,
    );
  }
}