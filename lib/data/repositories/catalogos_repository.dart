import 'dart:convert';

import 'package:asesorias_fic/data/models/catalogos_model.dart'; // Ajusta la ruta a tu modelo
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CatalogosRepository {
  final String _baseUrl = 'http://localhost:3000';

  final _storage = const FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: 'AsesoriasFIC',
      publicKey: 'SecretKeyFIC',
    ),
  );

  Future<CatalogosModel> getCatalogos() async {
    final url = Uri.parse('$_baseUrl/catalogos');

    try {
      String? token = await _storage.read(key: "jwt_token");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return CatalogosModel.fromJson(data);
      } else {
        throw Exception('Error al obtener los catálogos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en CatalogosRepository: $e');
      rethrow;
    }
  }
}