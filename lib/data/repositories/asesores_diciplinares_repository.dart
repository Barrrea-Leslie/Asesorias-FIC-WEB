import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';

class AsesoresDiciplinaresRepository {

  final AsesoresDiciplinaresService _service = AsesoresDiciplinaresService();

  Future<List<AsesorDisciplinar>> fetchAsesoresDiciplinares() {
    return _service.getAsesoresDiciplinares();
  }

}