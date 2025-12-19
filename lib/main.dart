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
        brightness: Brightness.light,
        focusColor: Appcolores.azulUas
      ),
      themeMode: ThemeMode.system,
    );
  }
}