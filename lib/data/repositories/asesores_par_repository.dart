import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';

class AsesoresParRepository {
  final AsesoresParService _service = AsesoresParService();

  // Obtener la lista completa
  Future<List<AsesorPar>> fetchAsesoresPar() async {
    return await _service.getAsesoresPar();
  }

  // Registrar un nuevo asesor par
  Future<bool> registrarAsesor(AsesorPar asesor) async {
    // Aquí llamarías a tu servicio (ej. _service.postAsesor)
    // Por ahora simulamos éxito:
    print("Guardando en base de datos: ${asesor.nombre}");
    return true; 
  }

  // Actualizar un asesor existente
  Future<bool> actualizarAsesor(AsesorPar asesor) async {
    // Aquí llamarías a tu servicio (ej. _service.updateAsesor)
    print("Actualizando datos de: ${asesor.nombre}");
    return true;
  }
}