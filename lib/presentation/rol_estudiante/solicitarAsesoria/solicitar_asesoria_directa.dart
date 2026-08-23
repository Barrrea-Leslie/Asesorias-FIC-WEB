import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_vista_estudiante.dart';
import 'package:asesorias_fic/data/models/catalogos_model.dart';
import 'package:flutter/material.dart';

class SolicitarAsesoriaDirecta extends StatefulWidget {
  final asesores_vista_estudiante asesor;
  final CatalogosModel? catalogos;

  const SolicitarAsesoriaDirecta({
    super.key,
    required this.asesor,
    this.catalogos,
  });

  @override
  State<SolicitarAsesoriaDirecta> createState() =>
      _SolicitarAsesoriaDirectaState();
}

class _SolicitarAsesoriaDirectaState extends State<SolicitarAsesoriaDirecta> {
  // Variables donde guardo las opciones seleccionadas por el alumno
  String? _materiaSeleccionada;
  String? _modalidadSeleccionada;
  String? _horarioSeleccionado;
  String? _razonSeleccionada;

  // Controladores para los campos de texto
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  late TextEditingController _asesorNombreController;

  @override
  void initState() {
    super.initState();
    // Armo el nombre completo del asesor concatenando sus apellidos
    final nombreCompleto =
        '${widget.asesor.nombre} ${widget.asesor.apellidoPaterno} ${widget.asesor.apellidoMaterno}'
            .trim();
    _asesorNombreController = TextEditingController(text: nombreCompleto);
  }

  @override
  void dispose() {
    // Limpio los controladores para evitar fugas de memoria
    _fechaController.dispose();
    _notaController.dispose();
    _asesorNombreController.dispose();
    super.dispose();
  }

  // Método auxiliar para asegurarme de recibir la lista limpia desde la vista/modelo
  List<String> _obtenerLista(dynamic data) {
    if (data == null) return [];
    if (data is List) {
      return data.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList();
    }
    if (data is String) {
      return data.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    // Extraigo las materias y horarios disponibles para este asesor
    final opcionesMaterias = _obtenerLista(widget.asesor.materiasList);
    final opcionesHorarios = _obtenerLista(widget.asesor.horariosList);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      title: const Center(
        child: Text(
          "Solicitar asesoría",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Asesor"),
              // Bloqueo el campo para que solo muestre el nombre sin editar
              TextFormField(
                controller: _asesorNombreController,
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  fillColor: Colors.grey[200],
                  filled: true,
                  prefixIcon: const Icon(Icons.person, size: 18),
                ),
              ),
              const SizedBox(height: 15),

              _buildCampoDropdown(
                'Materia',
                _materiaSeleccionada,
                opcionesMaterias,
                (val) => setState(() => _materiaSeleccionada = val),
              ),

              _buildLabel("Fecha"),
              _buildCampoFecha('Elegir fecha', _fechaController),
              const SizedBox(height: 15),

              _buildCampoDropdown(
                'Horario',
                _horarioSeleccionado,
                opcionesHorarios,
                (val) => setState(() => _horarioSeleccionado = val),
              ),

              // Campo de razón colocado en medio de Horario y Modalidad
              _buildCampoDropdown(
                'Razón de asesoría',
                _razonSeleccionada,
                [
                  'Dudas de clase',
                  'Repaso para examen',
                  'Proyecto final / Tarea',
                  'Regularización',
                  'Otro'
                ],
                (val) => setState(() => _razonSeleccionada = val),
              ),

              _buildCampoDropdown(
                'Modalidad',
                _modalidadSeleccionada,
                ['Presencial', 'Virtual'],
                (val) => setState(() => _modalidadSeleccionada = val),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onPressed: _intentarGuardar,
          child:
              const Text("Confirmar", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  // Componentes reutilizables para no duplicar código en la vista

  Widget _buildLabel(String texto) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          texto,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      );

  Widget _buildCampoDropdown(
    String label,
    String? currentVal,
    List<String> opciones,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<String>(
          value: opciones.contains(currentVal) ? currentVal : null,
          isExpanded: true,
          hint: Text("Seleccionar $label", style: const TextStyle(fontSize: 14)),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fillColor: Colors.white,
            filled: true,
          ),
          items: opciones
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
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

        // Despliego el calendario nativo para seleccionar la fecha
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );

        if (picked != null) {
          // Formateo la fecha seleccionada en formato DD/MM/YYYY
          setState(() => controller.text =
              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}");
        }
      },
    );
  }

  void _intentarGuardar() {
    // Valido que los campos requeridos estén llenos antes de cerrar
    if (_materiaSeleccionada == null ||
        _fechaController.text.isEmpty ||
        _horarioSeleccionado == null ||
        _razonSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Campos obligatorios incompletos")),
      );
      return;
    }
    Navigator.pop(context);
  }
}