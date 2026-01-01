import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

// --- WIDGET RESPONSIVE LAYOUT ---
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  const ResponsiveLayout({
    super.key,
    required this.mobileScaffold,
    required this.tabletScaffold,
    required this.desktopScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 650) {
        return mobileScaffold;
      } else if (constraints.maxWidth < 1100) {
        return tabletScaffold;
      } else {
        return desktopScaffold;
      }
    });
  }
}

class InformacionAsesoriaEnCurso extends StatefulWidget {
  const InformacionAsesoriaEnCurso({super.key});

  @override
  State<InformacionAsesoriaEnCurso> createState() =>
      _InformacionAsesoriaEnCursoState();
}

class _InformacionAsesoriaEnCursoState
    extends State<InformacionAsesoriaEnCurso> {
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
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Asesorias) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error de datos')),
        body: const Center(child: Text('No se recibió la información.')),
      );
    }

    final asesoria = args;

    return FutureBuilder<List<Estudiantes>>(
      future: _estudiantesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(body: Center(child: Text("Error al cargar datos")));
        }

        final estudiante = snapshot.data!.firstWhere(
          (e) => e.id == asesoria.idEstudiante,
          orElse: () => snapshot.data!.first,
        );

        _initializeDataOnce(asesoria, estudiante);

        // APLICACIÓN DEL LAYOUT RESPONSIVO
        return ResponsiveLayout(
          mobileScaffold: _buildMainScaffold(context, isMobile: true),
          tabletScaffold: _buildMainScaffold(context, isMobile: false),
          desktopScaffold: _buildMainScaffold(context, isMobile: false),
        );
      },
    );
  }

  // ESTRUCTURA PRINCIPAL DE LA PÁGINA
  Widget _buildMainScaffold(BuildContext context, {required bool isMobile}) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Información Asesoría',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50,),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 1000),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
      floatingActionButton: _buildBotonAplicar(context),
    );
  }

  // DISEÑO PARA ESCRITORIO (2 COLUMNAS)
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildColumnaIzquierda()),
        const SizedBox(width: 60),
        Expanded(child: _buildColumnaDerecha()),
      ],
    );
  }

  // DISEÑO PARA MÓVIL (1 COLUMNA)
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildColumnaIzquierda(),
        _buildColumnaDerecha(),
      ],
    );
  }

  // COLUMNA 1: DATOS PERSONALES Y MATERIA
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

  // COLUMNA 2: DETALLES DE ASESORÍA Y EVIDENCIA
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
        const Text('Periodo de Asesoría',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
        const SizedBox(height: 100), // Espacio para no chocar con el botón flotante
      ],
    );
  }

  // BOTÓN FLOTANTE FIJO
  Widget _buildBotonAplicar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolores.azulUas,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          MensajeConfirmacion.mostrarMensaje(context, "Cambios aplicados correctamente");
          Navigator.pop(context);
        },
        child: const Text('APLICAR CAMBIOS', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

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
                lastDate: DateTime(2026),
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