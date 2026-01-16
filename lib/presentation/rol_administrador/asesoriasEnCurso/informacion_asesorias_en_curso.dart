import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class InformacionAsesoriaEnCurso extends StatefulWidget {
  final Asesorias asesoria; // Recibe la asesoría directamente
  const InformacionAsesoriaEnCurso({super.key, required this.asesoria});

  @override
  State<InformacionAsesoriaEnCurso> createState() => _InformacionAsesoriaEnCursoState();
}

class _InformacionAsesoriaEnCursoState extends State<InformacionAsesoriaEnCurso> {
  late Future<List<Estudiantes>> _estudiantesFuture;

  late TextEditingController _nombreController;
  late TextEditingController _licenciaturaController;
  late TextEditingController _sesionesController;
  late TextEditingController _observacionesController;
  late TextEditingController _fechaInicioController;
  late TextEditingController _fechaFinalController;

  String? _selectedGrupo;
  String? _selectedMateria;
  String? _selectedModalidad;
  String? _selectedHorario;
  String? _selectedRazon;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _estudiantesFuture = EstudiantesService().getEstudiantes();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _licenciaturaController.dispose();
    _sesionesController.dispose();
    _observacionesController.dispose();
    _fechaInicioController.dispose();
    _fechaFinalController.dispose();
    super.dispose();
  }

  void _initializeDataOnce(Asesorias asesoria, Estudiantes estudiante) {
    if (_isInitialized) return;

    _nombreController = TextEditingController(text: estudiante.nombre);
    _licenciaturaController = TextEditingController(text: estudiante.licenciatura);
    _sesionesController = TextEditingController(text: "1");
    _observacionesController = TextEditingController(text: "");
    _fechaInicioController = TextEditingController(text: asesoria.fechaInicio);
    _fechaFinalController = TextEditingController(text: asesoria.fechaFin);

    _selectedGrupo = estudiante.grupo;
    _selectedMateria = asesoria.materia;
    _selectedModalidad = asesoria.modalidad;
    _selectedHorario = asesoria.horario;
    _selectedRazon = asesoria.razon;

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 1000),
        child: FutureBuilder<List<Estudiantes>>(
          future: _estudiantesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const SizedBox(height: 100, child: Center(child: Text("Error al cargar datos")));
            }

            final estudiante = snapshot.data!.firstWhere(
              (e) => e.id == widget.asesoria.idEstudiante,
              orElse: () => snapshot.data!.first,
            );

            _initializeDataOnce(widget.asesoria, estudiante);

            return LayoutBuilder(builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 700;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header del Modal
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Información Asesoría',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
                        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Cuerpo con Scroll
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
                    ),
                  ),
                  const Divider(height: 1),
                  // Footer con Botón
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_buildBotonAplicar(context)],
                    ),
                  )
                ],
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildColumnaIzquierda()),
        const SizedBox(width: 50),
        Expanded(child: _buildColumnaDerecha()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildColumnaIzquierda(),
        const SizedBox(height: 20),
        _buildColumnaDerecha(),
      ],
    );
  }

  Widget _buildColumnaIzquierda() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCampoTexto('Nombre del Estudiante', _nombreController),
        _buildCampoTexto('Licenciatura', _licenciaturaController),
        _buildCampoDropdown(
            'Grado y Grupo',
            _selectedGrupo,
            ['1-1', '1-2', '2-1', '2-2', '3-1', '3-2', '4-1', '4-2'],
            (val) => setState(() => _selectedGrupo = val)),
        _buildCampoDropdown(
            'Materia',
            _selectedMateria,
            ['Programación', 'Base de Datos', 'Matemáticas Discretas', 'Sistemas Operativos'],
            (val) => setState(() => _selectedMateria = val)),
        _buildCampoObservaciones(_observacionesController),
      ],
    );
  }

  Widget _buildColumnaDerecha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCampoDropdown('Modalidad', _selectedModalidad,
            ['Presencial', 'Virtual', 'Híbrida'],
            (val) => setState(() => _selectedModalidad = val)),
        _buildCampoDropdown('Horario', _selectedHorario,
            ['07:00 - 08:00', '13:00 - 14:00', '18:00 - 19:00'],
            (val) => setState(() => _selectedHorario = val)),
        const Text('Periodo de Asesoría', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildCampoFecha('Inicio', _fechaInicioController),
            const SizedBox(width: 10),
            _buildCampoFecha('Fin', _fechaFinalController),
          ],
        ),
        const SizedBox(height: 15),
        _buildCampoDropdown('Razón de la Asesoría', _selectedRazon,
            ['Dudas', 'Reprobada', 'Reforzamiento'],
            (val) => setState(() => _selectedRazon = val)),
        _buildCampoNumero('Sesiones Tomadas', _sesionesController),
        const SizedBox(height: 20),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.cloud_upload),
          label: const Text('ADJUNTAR EVIDENCIA (FOTO/PDF)'),
          style: TextButton.styleFrom(foregroundColor: Appcolores.azulUas),
        ),
      ],
    );
  }

  Widget _buildBotonAplicar(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolores.azulUas,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        MensajeConfirmacion.mostrarMensaje(context, "Cambios aplicados correctamente");
        Navigator.pop(context);
      },
      child: const Text('APLICAR CAMBIOS', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // --- WIDGETS AUXILIARES (Sin cambios de diseño) ---
  Widget _buildCampoTexto(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(controller: controller),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildCampoDropdown(String label, String? currentVal, List<String> opciones, Function(String?) onChanged) {
    if (currentVal != null && !opciones.contains(currentVal)) {
      opciones.insert(0, currentVal);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: currentVal,
          isDense: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildCampoFecha(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_today, size: 18),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2027),
              );
              if (picked != null) {
                setState(() => controller.text = "${picked.day}/${picked.month}/${picked.year}");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampoNumero(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }

  Widget _buildCampoObservaciones(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Observaciones', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe aquí...',
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}