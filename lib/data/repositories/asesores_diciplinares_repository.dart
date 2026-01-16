import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';

class AsesoresDiciplinaresRepository {

  final AsesoresDiciplinaresService _service = AsesoresDiciplinaresService();

  Future<List<AsesorDisciplinar>> fetchAsesoresDiciplinares() {
    return _service.getAsesoresDiciplinares();
  }

  Future<bool> registrarAsesor(AsesorDisciplinar nuevoAsesor) async {
    try {
      // 1. Aquí podr/* */ías convertir el objeto a JSON si tu Service lo requiere
      // final Map<String, dynamic> data = nuevoAsesor.toJson(); 
      
      // 2. Llamas al servicio para que haga el POST a la API o guarde en el archivo
      // Por ahora, simulamos el éxito:
      print("Guardando en el Repository: ${nuevoAsesor.nombre}");
      
      // Simulamos una respuesta del servidor
      await Future.delayed(const Duration(seconds: 1));
      
      return true; // Retorna true si se guardó correctamente
    } catch (e) {
      print("Error en AsesoresRepository: $e");
      return false;
    }
  }

}