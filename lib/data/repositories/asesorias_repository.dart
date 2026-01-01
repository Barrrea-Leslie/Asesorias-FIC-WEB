import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/services/asesorias_service.dart';

class AsesoriasRepository {

  final AsesoriasService _service = AsesoriasService();

  Future<List<Asesorias>> fetchAsesorias() {
    return _service.getAsesorias();
  }

  //Metodo para insertar datos
  Future<bool> crearAsesoria(Asesorias nuevaAsesoria) async {

    try {
      // Cuando tengas tu API, aquí llamarás a:
      // return await _service.postAsesoria(nuevaAsesoria);
      
      print("Simulando guardado en API de: ${nuevaAsesoria.materia}");
      await Future.delayed(const Duration(seconds: 1)); // Simula latencia de red
      return true;
    } catch (e) {
      print("Error en repository: $e");
      return false;
    }
  }


}