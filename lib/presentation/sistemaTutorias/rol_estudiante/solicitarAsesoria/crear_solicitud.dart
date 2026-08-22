import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class CrearSolicitud extends StatefulWidget {
  final List<dynamic> todosLosAsesores;
  const CrearSolicitud({super.key, required this.todosLosAsesores});

  @override
  State<CrearSolicitud> createState() => _CrearSolicitudState();
}

class _CrearSolicitudState extends State<CrearSolicitud> {
  dynamic _asesorSeleccionado;
  String? _materiaSeleccionada;
  String? _modalidadSeleccionada;
  String? _horarioSeleccionado;

  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  @override
  void dispose() {
    _fechaController.dispose();
    _notaController.dispose();
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
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Asesor"),
                _buildBuscadorAsesor(),
                const SizedBox(height: 15),
                
                _buildCampoDropdown(
                  'Materia', 
                  _materiaSeleccionada,
                  _asesorSeleccionado == null 
                    ? [] 
                    : (_asesorSeleccionado.materiasAsesora as List<dynamic>).map((e) => e.toString()).toList(),
                  (val) => setState(() => _materiaSeleccionada = val)
                ),
        
                _buildLabel("Fecha"),
                _buildCampoFecha('Elegir fecha', _fechaController),
                const SizedBox(height: 15),
        
                _buildCampoDropdown(
                  'Horario', 
                  _horarioSeleccionado,
                  _asesorSeleccionado == null 
                    ? [] 
                    : (_asesorSeleccionado.horariosAsesora as List<dynamic>).map((e) => e.toString()).toList(),
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
        // --- CAMBIO CRÍTICO 1: Quitar el foco (cerrar teclado) ---
        FocusScope.of(context).unfocus();
        
        // --- CAMBIO CRÍTICO 2: Esperar un momento antes de abrir ---
        await Future.delayed(const Duration(milliseconds: 100));

        if (!mounted) return;

        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2027),
          
        );
        
        if (picked != null) {
          setState(() => controller.text = "${picked.day}/${picked.month}/${picked.year}");
        }
      },
    );
  }

  Widget _buildBuscadorAsesor() {
    return Autocomplete<Object>(
      displayStringForOption: (option) => (option as dynamic).nombre,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') return widget.todosLosAsesores.cast<Object>();
        return widget.todosLosAsesores.where((asesor) {
          return (asesor as dynamic).nombre.toLowerCase().contains(textEditingValue.text.toLowerCase());
        }).cast<Object>();
      },
      onSelected: (Object selection) {
        setState(() {
          _asesorSeleccionado = selection;
          _materiaSeleccionada = null;
        });
      },
      // --- CAMBIO CRÍTICO 4: Controlar el tamaño de la lista de sugerencias ---
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 350),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index) as dynamic;
                  return ListTile(
                    title: Text(option.nombre),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Escribe nombre del asesor",
            prefixIcon: Icon(Icons.search, size: 18),
            fillColor: Colors.white,
            filled: true,
          ),
        );
      },
    );
  }

  void _intentarGuardar() {
    if (_asesorSeleccionado == null || _materiaSeleccionada == null || _fechaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Campos obligatorios incompletos")),
      );
      return;
    }
    Navigator.pop(context);
  }
}