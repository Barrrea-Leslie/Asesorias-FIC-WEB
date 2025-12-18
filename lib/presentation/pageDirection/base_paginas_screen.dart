import 'package:asesorias_fic/presentation/shared/mydrawer.dart';
import 'package:flutter/material.dart';

class BasePaginasScreen extends StatelessWidget {
  const BasePaginasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aseosrias"),
      ),
      drawer: Mydrawer(rutaActual: "/asesoresPar"),
    );
  }
}
