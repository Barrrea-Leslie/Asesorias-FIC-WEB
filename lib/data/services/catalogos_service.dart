import 'dart:convert';

import 'package:asesorias_fic/data/models/catalogos_model.dart';
import 'package:http/http.dart' as http;

class CatalogosService {
  
  final String _url = 'http://localhost:3000/catalogos'; 

  Future<CatalogosModel> obtenerCatalogos() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(response.body);
      return CatalogosModel.fromJson(decodedData);
    } else {
      throw Exception('Error al cargar los catálogos');
    }
  }
}