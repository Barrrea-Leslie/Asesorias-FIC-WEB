import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class SolicitarAsesoriaDirecta extends StatefulWidget {
  final dynamic asesor; // Recibe el asesor específico de la tarjeta

  const SolicitarAsesoriaDirecta({super.key, required this.asesor});

  @override
  State<SolicitarAsesoriaDirecta> createState() => _SolicitarAsesoriaDirectaState();
}

class _SolicitarAsesoriaDirectaState extends State<SolicitarAsesoriaDirecta> {
  // Variables de selección
  String? _materiaSeleccionada;
  String? _modalidadSeleccionada;
  String? _horarioSeleccionado;

  // Controladores
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  late TextEditingController _asesorNombreController;

  @override
  void initState() {
    super.initState();
    // Inicializamos el nombre del asesor en el controlador
    _asesorNombreController = TextEditingController(text: widget.asesor.nombre);
  }

  @override
  void dispose() {
    _fechaController.dispose();
    _notaController.dispose();
    _asesorNombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      title: const Center(
        child: Text("Solicitar asesoría",
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
              // Campo de nombre bloqueado (Lectura únicamente)
              TextFormField(
                controller: _asesorNombreController,
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: Colors.grey[200], // Color gris para indicar que está deshabilitado
                  filled: true,
                  prefixIcon: const Icon(Icons.person, size: 18),
                ),
              ),
              const SizedBox(height: 15),
              
              _buildCampoDropdown(
                'Materia', 
                _materiaSeleccionada,
                (widget.asesor.materiasAsesora as List<dynamic>).map((e) => e.toString()).toList(),
                (val) => setState(() => _materiaSeleccionada = val)
              ),

              _buildLabel("Fecha"),
              _buildCampoFecha('Elegir fecha', _fechaController),
              const SizedBox(height: 15),

              _buildCampoDropdown(
                'Horario', 
                _horarioSeleccionado,
                (widget.asesor.horariosAsesora as List<dynamic>).map((e) => e.toString()).toList(),
                (val) => setState(() => _horarioSeleccionado = val)
              ),

              _buildCampoDropdown(
                'Modalidad', 
                _modalidadSeleccionada,
                ['Presencial', 'Virtual'],
                (val) => setState(() => _modalidadSeleccionada = val)
              ),

              _buildLabel("Nota para el asesor (opcional)"),
              TextField(
                controller: _notaController,
                maxLines: 2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Agrega un comentario...',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Appcolores.verdeClaro,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          onPressed: _intentarGuardar,
          child: const Text("Confirmar", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  // --- COMPONENTES REUTILIZADOS ---

  Widget _buildLabel(String texto) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      );

  Widget _buildCampoDropdown(String label, String? currentVal, List<String> opciones, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<String>(
          value: currentVal,
          isExpanded: true,
          hint: Text("Seleccionar $label", style: const TextStyle(fontSize: 14)),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fillColor: Colors.white,
            filled: true,
          ),
          items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 15),
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
        FocusScope.of(context).unfocus();
        await Future.delayed(const Duration(milliseconds: 100));
        if (!mounted) return;

        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030), // Rango corregido para 2026 en adelante
        );
        
        if (picked != null) {
          setState(() => controller.text = "${picked.day}/${picked.month}/${picked.year}");
        }
      },
    );
  }

  void _intentarGuardar() {
    if (_materiaSeleccionada == null || _fechaController.text.isEmpty || _horarioSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Campos obligatorios incompletos")),
      );
      return;
    }
    // Aquí puedes realizar el guardado usando widget.asesor.id
    Navigator.pop(context);
  }
}