import 'package:asesorias_fic/data/models/solicitudes_model.dart';
import 'package:asesorias_fic/data/services/solicitudes_pendientes_service.dart';

class SolicitudesPendientesRepository {

  final SolicitudesPendientesService _service = SolicitudesPendientesService();

  Future<List<SolicitudesPendientes>> fetchSolicitudes() {
    return _service.getSolicitudes();
  }


}