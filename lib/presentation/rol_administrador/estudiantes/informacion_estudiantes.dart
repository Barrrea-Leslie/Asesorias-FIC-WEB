import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/repositories/estudiantes_repository.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class InformacionEstudiantes extends StatefulWidget {
  final Estudiantes estudiante;

  const InformacionEstudiantes({super.key, required this.estudiante});

  @override
  State<InformacionEstudiantes> createState() => _InformacionEstudiantesState();
}

class _InformacionEstudiantesState extends State<InformacionEstudiantes> {
  final _editarformKey = GlobalKey<FormState>();
  final EstudiantesRepository _repository = EstudiantesRepository();
  
  late TextEditingController nombreController;
  late TextEditingController cuentaController;
  late TextEditingController contraController; // Nuevo controlador
  late TextEditingController licenciaturaController;
  late TextEditingController grupoController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;
  late TextEditingController promedioController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.estudiante.nombre);
    cuentaController = TextEditingController(text: widget.estudiante.numeroCuenta);
    contraController = TextEditingController(text: widget.estudiante.contrasena); // Cargar contraseña
    licenciaturaController = TextEditingController(text: widget.estudiante.licenciatura);
    grupoController = TextEditingController(text: widget.estudiante.grupo);
    correoController = TextEditingController(text: widget.estudiante.correoInstitucional);
    telefonoController = TextEditingController(text: widget.estudiante.numeroTelefono);
    promedioController = TextEditingController(text: widget.estudiante.promedio.toString());
  }

  @override
  void dispose() {
    nombreController.dispose();
    cuentaController.dispose();
    contraController.dispose();
    licenciaturaController.dispose();
    grupoController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    promedioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Información del Estudiante',
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Form(
                    key: _editarformKey,
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
          _buildBottomBar(),
        ],
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

        // NUEVO CAMPO DE CONTRASEÑA
        _buildLabel("Contraseña"),
        _buildTextField(contraController, "****", isPassword: true),
        const SizedBox(height: 20),

        _buildLabel("Licenciatura"),
        _buildTextField(licenciaturaController, ""),
        const SizedBox(height: 20),
      ],
    );

    final columna2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Grupo"),
        _buildTextField(grupoController, ""),
        const SizedBox(height: 20),

        _buildLabel("Promedio"),
        _buildTextField(promedioController, "", isNumber: true),
        const SizedBox(height: 20),

        _buildLabel("Correo Institucional"),
        _buildTextField(correoController, "", isEmail: true),
        const SizedBox(height: 20),

        _buildLabel("Teléfono"),
        _buildTextField(telefonoController, "", isPhone: true),
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

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.azulUas,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _guardarCambios,
            child: const Text('APLICAR CAMBIOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _guardarCambios() async {
    if (_editarformKey.currentState!.validate()) {
      final actualizado = widget.estudiante.copyWith(
        nombre: nombreController.text,
        numeroCuenta: cuentaController.text,
        contrasena: contraController.text, // Guardar la contraseña editada
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
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false, bool isNumber = false, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword, // Soporte para ocultar texto
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
}