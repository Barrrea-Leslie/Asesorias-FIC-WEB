import 'dart:convert';

import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:flutter/services.dart';

class AsesoresDiciplinaresService {

  Future<List<AsesorDisciplinar>> getAsesoresDiciplinares() async {
    
    await Future.delayed(const Duration(seconds: 1));

    final jsonString = await rootBundle.loadString('assets/data/asesoresDiciplinares.json');

    final List data = json.decode(jsonString);

    return data.map((e) => AsesorDisciplinar.fromJson(e)).toList();

  }

}
