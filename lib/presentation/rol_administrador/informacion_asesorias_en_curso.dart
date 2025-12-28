import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:flutter/material.dart';

class InformacionAsesoriasEnCurso extends StatelessWidget {
  const InformacionAsesoriasEnCurso({super.key});

  @override
  Widget build(BuildContext context) {
    final asesoria =
        ModalRoute.of(context)!.settings.arguments as Asesorias;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Información Asesoría en curso"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text('Materia: ${asesoria.materia}'),
            Text('Razon: ${asesoria.razon}'),
            Text('Modalidad: ${asesoria.modalidad}'),
          ],
        ),
      ),
    );
  }
}
