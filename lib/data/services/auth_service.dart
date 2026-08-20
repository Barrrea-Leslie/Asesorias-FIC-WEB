import 'dart:convert';

import 'package:asesorias_fic/data/models/usuario_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  // Como es Flutter Web y corre en tu misma compu, localhost sin broncas
  final String _baseUrl = 'http://localhost:3000'; 
  
  // Esta librería en Web guarda las cosas en el localStorage del navegador automáticamente
  final _storage = const FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: 'AsesoriasFIC',
      publicKey: 'SecretKeyFIC',
    ),
  );

  // FUNCIÓN PARA LOGUEARSE
  Future<Map<String, dynamic>> login(String usuario, String password) async {
    final url = Uri.parse('$_baseUrl/usuarios/login');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "usuario": usuario,
          "password_hash": password // El campo exacto que espera Joi en el backend
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Guardamos el token en el búnker del navegador
        await _storage.write(key: "jwt_token", value: data['token']);
        return {"success": true, "message": "¡Sesión iniciada, papá!"};
      } else {
        return {"success": false, "message": data['message'] ?? "Error de credenciales"};
      }
    } catch (e) {
      return {"success": false, "message": "credenciales incorrectas, intente de nuevo"};
    }
  }

  // FUNCIÓN PARA LLAMAR A LA RUTA PROTEGIDA 
  Future<Map<String, dynamic>> probarZonaVIP() async {
    final url = Uri.parse('$_baseUrl/usuarios');
    
    // Leemos el token guardado en el navegador
    String? token = await _storage.read(key: "jwt_token");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // Mandamos el token en los headers igualito que en Postman
          "Authorization": "Bearer $token" 
        },
      );

      final data = jsonDecode(response.body);
      return {"statusCode": response.statusCode, "body": data};
    } catch (e) {
      return {"statusCode": 500, "body": "Error de conexión"};
    }
  }

  // CERRAR SESIÓN 
  Future<void> logout() async {
    await _storage.delete(key: "jwt_token");
  }

  Future<UsuarioToken?> abrirToken() async {
    try {
      //se guarda el token del storage de la web
      String? token = await _storage.read(key: "jwt_token");

      //si el token o es nulo o no expiro, se ejecuta la instruccion
      if(token != null && !JwtDecoder.isExpired(token)){
        Map<String, dynamic> dataToken = JwtDecoder.decode(token);

        return UsuarioToken.fromJwt(dataToken);
      }
      return null;
    } catch (e) {
      print("error al leer el token: $e");
      return null;
    }
    
    
  }
}