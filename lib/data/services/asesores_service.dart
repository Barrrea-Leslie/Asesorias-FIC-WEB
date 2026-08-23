import 'package:asesorias_fic/data/models/asesores_vista_estudiante.dart';
import 'package:asesorias_fic/data/repositories/asesores_repository.dart';

class AsesoresService {
  final AsesoresRepository _repository = AsesoresRepository();

  // Obtener la lista completa de asesores
  Future<List<asesores_vista_estudiante>> obtenerAsesores() async {
    try {
      return await _repository.getAsesores();
    } catch (e) {
      print('Error en AsesoresService: $e');
      return [];
    }
  }
}