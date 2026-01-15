
import 'dart:convert';

import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/crear_asesor_disiplinar.dart';
import 'package:http/http.dart' as http;

class AsesoresDiciplinaresService{

  final String baseUrl = "http://localhost:3000/asesores-disciplinar";

  //Obtener o buscar asesores con GET
  Future<List<AsesorDisciplinar>> buscarAsesores(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?p_busqueda=$query'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => AsesorDisciplinar.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar asesores");
    }
  }

  //Crear Asesor POST /

  Future<void> crearAsesor(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception("Error al crear asesor");
    }
  }

  //Editar asesor POST /editar
  Future<void> editarAsesor(Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse('$baseUrl/editar'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(data),
  );

  if (response.statusCode != 200) {
    throw Exception("Error al editar asesor");
  }
}


  //obtener materias
  Future<List<MateriaItem>> obtenerMaterias() async {
  try {
    final response = await http.get(Uri.parse("http://localhost:3000/catalogos/materias"));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((m) => MateriaItem(
        id: m["id_materia"],
        nombre: m["materia"],
      )).toList();
    }
  } catch (e) {
    print("Error en service obtenerMaterias: $e");
  }
  return [];
}

  Future<List<Map<String, dynamic>>> obtenerCatalogoCompletoMaterias() async {
      final response = await http.get(
        Uri.parse("http://localhost:3000/catalogos/materias"),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data
            .map((m) => {
                  "id_materia": m["id_materia"],
                  "materia": m["materia"],
                })
            .toList();
      }
      return [];
    }
}



/* class AsesoresDiciplinaresService {

  Future<List<AsesorDisciplinar>> getAsesoresDiciplinares() async {
    
    await Future.delayed(const Duration(seconds: 1));

    final jsonString = await rootBundle.loadString('assets/data/asesoresDiciplinares.json');

    final List data = json.decode(jsonString);

    return data.map((e) => AsesorDisciplinar.fromJson(e)).toList();

  }

} */
