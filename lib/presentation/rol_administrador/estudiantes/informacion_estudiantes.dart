import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/repositories/estudiantes_repository.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class InformacionEstudiantes extends StatefulWidget {
  const InformacionEstudiantes({super.key});

  @override
  State<InformacionEstudiantes> createState() => _InformacionEstudiantesState();
}

class _InformacionEstudiantesState extends State<InformacionEstudiantes> {
  final _editarformKey = GlobalKey<FormState>();
  final EstudiantesRepository _repository = EstudiantesRepository();
  
  late Estudiantes estudianteOriginal;
  bool _isInitialized = false;

  late TextEditingController nombreController;
  late TextEditingController cuentaController;
  late TextEditingController licenciaturaController;
  late TextEditingController grupoController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;
  late TextEditingController promedioController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is Estudiantes) {
        estudianteOriginal = args;
        nombreController = TextEditingController(text: estudianteOriginal.nombre);
        cuentaController = TextEditingController(text: estudianteOriginal.numeroCuenta);
        licenciaturaController = TextEditingController(text: estudianteOriginal.licenciatura);
        grupoController = TextEditingController(text: estudianteOriginal.grupo);
        correoController = TextEditingController(text: estudianteOriginal.correoInstitucional);
        telefonoController = TextEditingController(text: estudianteOriginal.numeroTelefono);
        promedioController = TextEditingController(text: estudianteOriginal.promedio.toString());
      }
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Información del Estudiante', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true, backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 700,
            child: Form(
              key: _editarformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Nombre completo"),
                  _buildTextField(nombreController, ""),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _buildLabel("Num. Cuenta"),
                        _buildTextField(cuentaController, ""),
                      ])),
                      const SizedBox(width: 15),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _buildLabel("Promedio"),
                        _buildTextField(promedioController, "", isNumber: true),
                      ])),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Licenciatura"),
                  _buildTextField(licenciaturaController, ""),
                  const SizedBox(height: 20),

                  _buildLabel("Grupo"),
                  _buildTextField(grupoController, ""),
                  const SizedBox(height: 20),

                  _buildLabel("Correo institucional"),
                  _buildTextField(correoController, "", isEmail: true),
                  const SizedBox(height: 20),

                  _buildLabel("Teléfono"),
                  _buildTextField(telefonoController, "", isPhone: true),
                  
                  const SizedBox(height: 50),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolores.azulUas,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: _guardarCambios,
                      child: const Text("APLICAR CAMBIOS", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _guardarCambios() async {
    if (_editarformKey.currentState!.validate()) {
      final actualizado = estudianteOriginal.copyWith(
        nombre: nombreController.text,
        numeroCuenta: cuentaController.text,
        licenciatura: licenciaturaController.text,
        grupo: grupoController.text,
        correoInstitucional: correoController.text,
        numeroTelefono: telefonoController.text,
        promedio: double.tryParse(promedioController.text) ?? 0.0,
      );

      bool exito = await _repository.actualizarEstudiante(actualizado);

      if (exito && mounted) {
        Navigator.pop(context, actualizado);
        MensajeConfirmacion.mostrarMensaje(context, "Se aplicaron los cambios correctamente.");
      }
    }
  }

  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false, bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : (isPhone || isNumber ? TextInputType.number : TextInputType.text),
      decoration: InputDecoration(
        hintText: hint, filled: true, fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) => val == null || val.isEmpty ? "Campo obligatorio" : null,
    );
  }
}