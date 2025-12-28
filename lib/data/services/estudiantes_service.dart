import 'dart:convert';

import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:flutter/services.dart';

class EstudiantesService {

    Future<List<Estudiantes>> getEstudiantes() async {

    await Future.delayed(const Duration(seconds: 1));

    final jsonString = await rootBundle.loadString('assets/data/estudiantes.json');

    final List data = json.decode(jsonString);

    return data.map((e) => Estudiantes.fromJson(e)).toList();

    }
    
}
