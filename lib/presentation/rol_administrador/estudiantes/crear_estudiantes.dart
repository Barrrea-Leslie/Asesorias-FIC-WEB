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

  // Controladores
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController cuentaController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController promedioController = TextEditingController();

  // Variables para Dropdowns
  String? _selectedLicenciatura;
  String? _selectedGrupo;

  final List<String> licenciaturas = ['Informática', 'Ing. en Sistemas', 'Software'];
  final List<String> grupos = ['1-1', '1-2', '2-1', '2-2', '3-1', '3-2', '4-1', '4-2', '4-3'];

  void _guardarEstudiante() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedLicenciatura == null || _selectedGrupo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Por favor seleccione Licenciatura y Grupo")),
        );
        return;
      }

      final nuevoEstudiante = Estudiantes(
        id: DateTime.now().millisecondsSinceEpoch,
        nombre: nombreController.text,
        numeroCuenta: cuentaController.text,
        licenciatura: _selectedLicenciatura!,
        grupo: _selectedGrupo!,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Crear Nuevo Estudiante', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Form(
              key: _formKey,
              child: LayoutBuilder(builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 700;
                return isMobile 
                    ? _buildFormContent(isMobile: true) 
                    : _buildFormContent(isMobile: false);
              }),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildFormContent({required bool isMobile}) {
    final columna1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nombre Completo"),
        _buildTextField(nombreController, "Ej. Luis Fernando Velázquez"),
        const SizedBox(height: 20),
        
        _buildLabel("Número de Cuenta"),
        _buildTextField(cuentaController, "19519958"),
        const SizedBox(height: 20),

        _buildCampoDropdown('Licenciatura', _selectedLicenciatura, licenciaturas, 
            (val) => setState(() => _selectedLicenciatura = val)),

        _buildCampoDropdown('Grupo', _selectedGrupo, grupos, 
            (val) => setState(() => _selectedGrupo = val)),
      ],
    );

    final columna2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        
        _buildLabel("Promedio"),
        _buildTextField(promedioController, "10.0", isNumber: true),
        const SizedBox(height: 20),

        _buildLabel("Correo Institucional"),
        _buildTextField(correoController, "correo@info.uas.edu.mx", isEmail: true),
        const SizedBox(height: 20),

        _buildLabel("Teléfono"),
        _buildTextField(telefonoController, "6672136911", isPhone: true),
      ],
    );

    return isMobile 
      ? Column(children: [columna1, columna2]) 
      : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: columna1),
          const SizedBox(width: 50),
          Expanded(child: columna2),
        ]);
  }

  // --- COMPONENTES UI REUTILIZABLES ---

  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false, bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : (isPhone || isNumber ? TextInputType.number : TextInputType.text),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        border: const OutlineInputBorder(),
      ),
      validator: (val) => val == null || val.isEmpty ? "Campo obligatorio" : null,
    );
  }

  Widget _buildCampoDropdown(String label, String? currentVal, List<String> opciones, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<String>(
          value: currentVal,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder()
          ),
          items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          validator: (val) => val == null ? "Seleccione una opción" : null,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolores.azulUas,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: _guardarEstudiante,
        child: const Text('CONFIRMAR REGISTRO', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}