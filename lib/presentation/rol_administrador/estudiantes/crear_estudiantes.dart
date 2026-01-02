import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/repositories/estudiantes_repository.dart';
import 'package:flutter/material.dart';

class CrearEstudiantes extends StatefulWidget {
  const CrearEstudiantes({super.key});

  @override
  State<CrearEstudiantes> createState() => _CrearEstudiantesState();
}

class _CrearEstudiantesState extends State<CrearEstudiantes> {
  final _formKey = GlobalKey<FormState>();
  final EstudiantesRepository _repository = EstudiantesRepository();

  final nombreController = TextEditingController();
  final cuentaController = TextEditingController();
  final licenciaturaController = TextEditingController();
  final grupoController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();
  final promedioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crear Estudiante', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true, backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Nombre completo"),
              _buildTextField(nombreController, "Ej. Luis Fernando Velázquez"),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _buildLabel("Num. Cuenta"),
                    _buildTextField(cuentaController, "19519958"),
                  ])),
                  const SizedBox(width: 15),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _buildLabel("Promedio"),
                    _buildTextField(promedioController, "10.0", isNumber: true),
                  ])),
                ],
              ),
              const SizedBox(height: 20),

              _buildLabel("Licenciatura"),
              _buildTextField(licenciaturaController, "Informatica"),
              const SizedBox(height: 20),

              _buildLabel("Grupo"),
              _buildTextField(grupoController, "4-1"),
              const SizedBox(height: 20),

              _buildLabel("Correo institucional"),
              _buildTextField(correoController, "correo@info.uas.edu.mx", isEmail: true),
              const SizedBox(height: 20),

              _buildLabel("Teléfono"),
              _buildTextField(telefonoController, "6672136911", isPhone: true),
              
              const SizedBox(height: 50),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolores.azulUas,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _guardarEstudiante,
                    child: const Text("GUARDAR ESTUDIANTE", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardarEstudiante() async {
    if (_formKey.currentState!.validate()) {
      final nuevoEstudiante = Estudiantes(
        id: DateTime.now().millisecondsSinceEpoch,
        nombre: nombreController.text,
        numeroCuenta: cuentaController.text,
        licenciatura: licenciaturaController.text,
        grupo: grupoController.text,
        correoInstitucional: correoController.text,
        numeroTelefono: telefonoController.text,
        promedio: double.tryParse(promedioController.text) ?? 0.0,
      );

      bool exito = await _repository.registrarEstudiante(nuevoEstudiante);

      if (exito && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Estudiante registrado con éxito"), backgroundColor: Colors.green),
        );
        Navigator.pop(context, nuevoEstudiante);
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