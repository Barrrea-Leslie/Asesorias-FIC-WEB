import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/services/asesorias_service.dart';

class AsesoriasRepository {

  final AsesoriasService _service = AsesoriasService();

  Future<List<Asesorias>> fetchAsesorias() {
    return _service.getAsesorias();
  }


}