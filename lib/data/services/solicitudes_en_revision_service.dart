import 'dart:convert';

import 'package:asesorias_fic/data/models/solicitudes_en_revision.dart';
import 'package:flutter/services.dart';

class SolicitudesEnRevisionService {
  Future<List<SolicitudesEnRevision>> getSolicitudesRevision() async {
    // Simular tiempo de carga
    await Future.delayed(const Duration(seconds: 1));

    // Cargar el archivo JSON desde assets
    final String jsonString = await rootBundle.loadString('assets/data/solicitudes_en_revision.json');
    final List<dynamic> data = json.decode(jsonString);

    // Convertir la lista dinámica en una lista de objetos SolicitudesEnRevision
    return data.map((e) => SolicitudesEnRevision.fromJson(e)).toList();
  }
}