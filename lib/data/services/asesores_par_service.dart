import 'dart:convert';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:flutter/services.dart';



class AsesoresParService {

  Future<List<AsesorPar>> getAsesoresPar() async {
    
    await Future.delayed(const Duration(seconds: 1));

    final jsonString = await rootBundle.loadString('assets/data/asesoresPar.json');

    final List data = json.decode(jsonString);

    return data.map((e) => AsesorPar.fromJson(e)).toList();

  }

}
