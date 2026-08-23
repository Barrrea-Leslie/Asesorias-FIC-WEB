import 'dart:convert';

import 'package:asesorias_fic/data/models/asesores_vista_estudiante.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AsesoresRepository {
  final String _baseUrl = 'http://localhost:3000';

  final _storage = const FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: 'AsesoriasFIC',
      publicKey: 'SecretKeyFIC',
    ),
  );

  Future<List<asesores_vista_estudiante>> getAsesores() async {
    final url = Uri.parse('$_baseUrl/asesores');

    try {
      // 1. Recuperamos el token guardado en el almacenamiento local
      String? token = await _storage.read(key: "jwt_token");

      // 2. Realizamos la petición HTTP GET mandando el Token de autenticación
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // 3. Verificamos respuesta exitosa
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => asesores_vista_estudiante.fromJson(json))
            .toList();
      } else {
        throw Exception('Error en el servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al consultar el repositorio de asesores: $e');
      rethrow;
    }
  }
}