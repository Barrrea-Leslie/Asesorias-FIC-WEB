import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class EditarSolicitud extends StatefulWidget {
  final dynamic solicitud; // Recibe la solicitud completa

  const EditarSolicitud({super.key, required this.solicitud});

  @override
  State<EditarSolicitud> createState() => _EditarSolicitudState();
}

class _EditarSolicitudState extends State<EditarSolicitud> {
  // Variables de selección modificables
  String? _horarioSeleccionado;

  // Controladores
  final TextEditingController _fechaController = TextEditingController();
  late TextEditingController _asesorController;
  late TextEditingController _materiaController;
  late TextEditingController _estadoController;
  late TextEditingController _notasController;

  @override
  void initState() {
    super.initState();
    // Inicializamos los campos con la información de la solicitud
    _asesorController = TextEditingController(text: widget.solicitud.asesor);
    _materiaController = TextEditingController(text: widget.solicitud.materia);
    _estadoController = TextEditingController(text: widget.solicitud.estado);
    _fechaController.text = widget.solicitud.fecha;
    _horarioSeleccionado = widget.solicitud.horario;
    _notasController = TextEditingController(text: widget.solicitud.notas ?? "");
  }

  @override
  void dispose() {
    _fechaController.dispose();
    _asesorController.dispose();
    _materiaController.dispose();
    _estadoController.dispose();
    _notasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lógica de visibilidad
    bool mostrarNotas = widget.solicitud.estado.toUpperCase() == "RECHAZADA";
    bool puedeCancelarSolicitud = widget.solicitud.estado.toUpperCase() == "REVISIÓN";

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      title: const Center(
        child: Text("Editar Solicitud",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Asesor"),
              _buildCampoEstatico(_asesorController, Icons.person),

              _buildLabel("Materia"),
              _buildCampoEstatico(_materiaController, Icons.book),

              _buildLabel("Fecha"),
              _buildCampoFecha('Elegir fecha', _fechaController),
              const SizedBox(height: 15),

              _buildCampoDropdown(
                'Horario', 
                _horarioSeleccionado,
                ['07:00 AM', '08:00 AM', '09:00 AM', '10:00 AM', '01:00 PM', '02:00 PM'], // Aquí iría la lista de horarios disponibles
                (val) => setState(() => _horarioSeleccionado = val)
              ),

              _buildLabel("Estado"),
              _buildCampoEstatico(_estadoController, Icons.info_outline),

              if (mostrarNotas) ...[
                _buildLabel("Notas del asesor"),
                _buildCampoEstatico(_notasController, Icons.note, maxLines: 2),
              ],
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      actions: [
        // Botón Cancelar (Cerrar modal)
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
        ),
        
        // Botón condicional: Solo en estado REVISIÓN
        if (puedeCancelarSolicitud)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: _eliminarSolicitud,
            child: const Text("Cancelar Solicitud", style: TextStyle(color: Colors.white, fontSize: 12)),
          ),

        // Botón Confirmar Cambios
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Appcolores.azulUas,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onPressed: _confirmarCambios,
          child: const Text("Confirmar Cambios", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  // --- COMPONENTES UI ---

  Widget _buildLabel(String texto) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 10),
        child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      );

  Widget _buildCampoEstatico(TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        fillColor: Colors.grey[100], 
        filled: true,
        prefixIcon: Icon(icon, size: 18),
      ),
      style: const TextStyle(color: Colors.black54, fontSize: 14),
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
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fillColor: Colors.white,
            filled: true,
          ),
          items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCampoFecha(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_today, size: 18),
        border: const OutlineInputBorder(),
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          lastDate: DateTime(2027),
        );
        if (picked != null) {
          setState(() => controller.text = "${picked.day}/${picked.month}/${picked.year}");
        }
      },
    );
  }

  // --- LÓGICA DE BOTONES ---

  void _confirmarCambios() {
    // Lógica para actualizar fecha y horario
    Navigator.pop(context);
  }

  void _eliminarSolicitud() {
    // Lógica para cancelar/eliminar la solicitud definitivamente
    Navigator.pop(context);
  }
}