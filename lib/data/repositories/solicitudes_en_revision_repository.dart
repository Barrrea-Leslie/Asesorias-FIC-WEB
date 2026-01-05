import 'package:asesorias_fic/data/models/solicitudes_en_revision.dart';
import 'package:asesorias_fic/data/services/solicitudes_en_revision_service.dart';

class SolicitudesRevisionRepository {

  final SolicitudesEnRevisionService _service = SolicitudesEnRevisionService();

  // Obtener todas las solicitudes en revisión
  Future<List<SolicitudesEnRevision>> fetchSolicitudesRevision() {
    return _service.getSolicitudesRevision();
  }

  // Ejemplo: Podrías añadir un método para cancelar una solicitud
  Future<bool> cancelarSolicitud(String materia) async {
    try {
      print("Simulando cancelación de solicitud para: $materia");
      await Future.delayed(const Duration(milliseconds: 800));
      return true;
    } catch (e) {
      print("Error en repository al cancelar: $e");
      return false;
    }
  }
}