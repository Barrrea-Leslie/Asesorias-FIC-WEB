import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';

class EstudiantesRepository {

  final EstudiantesService _service = EstudiantesService();

  Future<List<Estudiantes>> fetchEstudiantes() {
    return _service.getEstudiantes();
  }

}