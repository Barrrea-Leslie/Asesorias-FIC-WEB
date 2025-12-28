import 'dart:convert';

import 'package:asesorias_fic/data/models/solicitudes_model.dart';
import 'package:flutter/services.dart';

class SolicitudesPendientesService {

  Future<List<SolicitudesPendientes>> getSolicitudes() async {
    
    await Future.delayed(const Duration(seconds: 1));

    final jsonString = await rootBundle.loadString('assets/data/solicitudesPendientes.json');

    final List data = json.decode(jsonString);

    return data.map((e) => SolicitudesPendientes.fromJson(e)).toList();

  }

}