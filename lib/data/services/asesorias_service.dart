import 'dart:convert';

import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:flutter/services.dart';

class AsesoriasService {

  Future<List<Asesorias>> getAsesorias() async {
    
    await Future.delayed(const Duration(seconds: 1));

    final jsonString = await rootBundle.loadString('assets/data/asesorias.json');

    final List data = json.decode(jsonString);

    return data.map((e) => Asesorias.fromJson(e)).toList();

  }

}
