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
  final TextEditingController contraController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController promedioController = TextEditingController();

  // Variables para Dropdowns
  String? _selectedLicenciatura;
  String? _selectedGrupo;

  final List<String> licenciaturas = [
    "Licenciatura en informatica",
    "Licenciatura en informatica virtual",
    "Licenciatura en ingenieria en ciencias de datos",
    "Licenciatura en ITSE"
  ];
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
        contrasena: contraController.text,
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
      body: SafeArea(
        child: Column(
          children: [
            // --- ENCABEZADO IGUAL A ASESOR PAR ---
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Registrar Nuevo Estudiante',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // --- CUERPO DEL FORMULARIO ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Form(
                      key: _formKey,
                      child: LayoutBuilder(builder: (context, constraints) {
                        bool isMobile = constraints.maxWidth < 700;
                        return _buildFormContent(isMobile: isMobile);
                      }),
                    ),
                  ),
                ),
              ),
            ),
            
            const Divider(height: 1),
            // --- BARRA INFERIOR CON BOTÓN A LA DERECHA ---
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent({required bool isMobile}) {
    final columna1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nombre Completo"),
        _buildTextField(nombreController, ""),
        const SizedBox(height: 20),
        
        _buildLabel("Número de Cuenta"),
        _buildTextField(cuentaController, ""),
        const SizedBox(height: 20),

        _buildLabel("Contraseña"),
        _buildTextField(contraController, "", isPassword: true),
        const SizedBox(height: 20),

        _buildCampoDropdown('Licenciatura', _selectedLicenciatura, licenciaturas, 
            (val) => setState(() => _selectedLicenciatura = val)),
      ],
    );

    final columna2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCampoDropdown('Grupo', _selectedGrupo, grupos, 
            (val) => setState(() => _selectedGrupo = val)),

        _buildLabel("Promedio"),
        _buildTextField(promedioController, "", isNumber: true),
        const SizedBox(height: 20),

        _buildLabel("Correo Institucional"),
        _buildTextField(correoController, "correo@info.uas.edu.mx", isEmail: true),
        const SizedBox(height: 20),

        _buildLabel("Teléfono"),
        _buildTextField(telefonoController, "", isPhone: true),
      ],
    );

    return isMobile 
      ? Column(children: [columna1, columna2]) 
      : Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Expanded(child: columna1),
            const SizedBox(width: 50),
            Expanded(child: columna2),
          ],
        );
  }

  // --- COMPONENTES UI REUTILIZABLES ---

  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false, bool isNumber = false, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
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
          isExpanded: true,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Botón a la derecha
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.azulUas,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _guardarEstudiante,
            child: const Text('CONFIRMAR REGISTRO', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}