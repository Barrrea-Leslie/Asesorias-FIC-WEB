import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';

class AsesoresParRepository {

  final AsesoresParService _service = AsesoresParService();

  Future<List<AsesorPar>> fetchAsesoresPar() {
    return _service.getAsesoresPar();
  }

}