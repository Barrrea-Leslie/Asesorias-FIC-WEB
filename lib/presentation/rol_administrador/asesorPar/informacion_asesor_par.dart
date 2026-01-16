import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class InformacionAsesoresPar extends StatefulWidget {
  final AsesorPar? asesor;

  const InformacionAsesoresPar({super.key, this.asesor});

  @override
  State<InformacionAsesoresPar> createState() => _InformacionAsesoresParState();
}

class _InformacionAsesoresParState extends State<InformacionAsesoresPar> {
  final _editarformKey = GlobalKey<FormState>();
  
  late TextEditingController nombreController;
  late TextEditingController cuentaController;
  late TextEditingController contraController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;
  late TextEditingController promedioController;

  String? _selectedGrupo;
  String? _selectedLicenciatura;

  final List<String> grupos = ['1-1', '1-2', '2-1', '2-2', '3-1', '3-2', '4-1', '4-2', '4-3'];
  
  final List<String> licenciaturas = [
    "Licenciatura en informatica",
    "Licenciatura en informatica virtual",
    "Licenciatura en ingenieria en ciencias de datos",
    "Licenciatura en ITSE"
  ];

  List<String> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.asesor?.nombre ?? "");
    cuentaController = TextEditingController(text: widget.asesor?.numeroCuenta ?? "");
    contraController = TextEditingController(text: widget.asesor?.contrasena ?? "");
    correoController = TextEditingController(text: widget.asesor?.correoInstitucional ?? "");
    telefonoController = TextEditingController(text: widget.asesor?.numeroTelefono ?? "");
    promedioController = TextEditingController(text: widget.asesor?.promedio.toString() ?? "");

    // --- LÓGICA DE SEGURIDAD PARA DROPDOWNS ---
    // Verificamos si el valor que viene de la BD existe en nuestras listas. 
    // Si no existe, lo ponemos como null para evitar el error de "Assertion failed".
    
    if (grupos.contains(widget.asesor?.grupo)) {
      _selectedGrupo = widget.asesor?.grupo;
    } else {
      _selectedGrupo = null; 
    }

    if (licenciaturas.contains(widget.asesor?.licenciatura)) {
      _selectedLicenciatura = widget.asesor?.licenciatura;
    } else {
      _selectedLicenciatura = null;
    }

    materiasSeleccionadas = List.from(widget.asesor?.materiasAsesora ?? []);
    horariosSeleccionados = List.from(widget.asesor?.horariosAsesora ?? []);
  }

  @override
  void dispose() {
    nombreController.dispose();
    cuentaController.dispose();
    contraController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    promedioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Form(
              key: _editarformKey,
              child: LayoutBuilder(builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 700;
                return isMobile 
                  ? Column(children: [_buildColumna1(), const SizedBox(height: 30), _buildColumna2()])
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildColumna1()),
                        const SizedBox(width: 50),
                        Expanded(child: _buildColumna2()),
                      ],
                    );
              }),
            ),
          ),
        ),
        const Divider(height: 1),
        _buildActionButtons(),
      ],
    );
  }

  // --- SUB-WIDGETS ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Información Asesor Par', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _buildColumna1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nombre completo"), _buildTextField(nombreController, "Ej. Elias Cuadras"),
        const SizedBox(height: 20),
        _buildLabel("Número de Cuenta"), _buildTextField(cuentaController, "19512348"),
        const SizedBox(height: 20),
        _buildLabel("Contraseña"), _buildTextField(contraController, "********", isPassword: true),
        const SizedBox(height: 20),
        _buildLabel("Correo institucional"), _buildTextField(correoController, "correo@info.uas.edu.mx"),
        const SizedBox(height: 20),
        _buildLabel("Teléfono"), _buildTextField(telefonoController, "6671234567"),
      
      ],
    );
  }

  Widget _buildColumna2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        
        _buildCampoDropdown(
          'Licenciatura', _selectedLicenciatura, licenciaturas, 
          (val) => setState(() => _selectedLicenciatura = val)
        ),
        const SizedBox(height: 20),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCampoDropdown('Grupo', _selectedGrupo, grupos, (val) => setState(() => _selectedGrupo = val))),
            const SizedBox(width: 15),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildLabel("Promedio"), _buildTextField(promedioController, "9.8")])),
          ],
        ),
        const SizedBox(height: 30),
        _buildHeaderSeccion(titulo: "Materias que asesora", onAdd: () {}),
        _buildListaItems(materiasSeleccionadas),
      ],
    );
  }

  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint, filled: true, fillColor: Colors.grey[50],
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCampoDropdown(String label, String? currentVal, List<String> opciones, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: currentVal,
          decoration: InputDecoration(
            filled: true, fillColor: Colors.grey[50],
            border: OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
          items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildHeaderSeccion({required String titulo, required VoidCallback onAdd}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ElevatedButton.icon(onPressed: onAdd, icon: const Icon(Icons.add, size: 18), label: const Text("Añadir"),
          style: ElevatedButton.styleFrom(backgroundColor: Appcolores.verdeClaro, foregroundColor: Colors.white)),
      ],
    );
  }

  Widget _buildListaItems(List<String> lista) {
    return Column(
      children: lista.map((item) => ListTile(
        title: Text(item, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
        onTap: () => setState(() => lista.remove(item)),
      )).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Appcolores.azulUas, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18)),
            onPressed: () {
              if (_editarformKey.currentState!.validate()) {
                Navigator.pop(context);
                MensajeConfirmacion.mostrarMensaje(context, "Cambios aplicados con éxito.");
              }
            },
            child: const Text('CONFIRMAR CAMBIOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}