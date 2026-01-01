import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/repositories/asesorias_repository.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class CrearAsesoriaPage extends StatefulWidget {
  const CrearAsesoriaPage({super.key});

  @override
  State<CrearAsesoriaPage> createState() => _CrearAsesoriaPageState();
}

class _CrearAsesoriaPageState extends State<CrearAsesoriaPage> {
  final AsesoriasRepository _repository = AsesoriasRepository();
  late Future<List<Estudiantes>> _estudiantesFuture;

  // Controladores y variables de selección
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinalController = TextEditingController();
  
  Estudiantes? _estudianteSeleccionado;
  String? _selectedMateria;
  String? _selectedModalidad;
  String? _selectedHorario;
  String? _selectedRazon;

  @override
  void initState() {
    super.initState();
    _estudiantesFuture = EstudiantesService().getEstudiantes();
  }

  void _intentarGuardar() async {
    if (_estudianteSeleccionado == null || _selectedMateria == null || _selectedModalidad == null || _selectedHorario == null || _selectedRazon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Todos los campos son obligatorios")),
      );
      return;
    }

    final nueva = Asesorias(
      id: 0, 
      idEstudiante: _estudianteSeleccionado!.id,
      materia: _selectedMateria!,
      fechaInicio: _fechaInicioController.text,
      fechaFin: _fechaFinalController.text,
      horario: _selectedHorario ?? "",
      modalidad: _selectedModalidad ?? "",
      razon: _selectedRazon ?? "",
      esAsesor: 0,
      observaciones: "", // Como pediste, sin este campo
    );

    final exito = await _repository.crearAsesoria(nueva);

    if (exito && mounted) {
      MensajeConfirmacion.mostrarMensaje(context, "Asesoría creada correctamente");
      Navigator.pop(context);
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
        title: const Text('Registrar Nueva Asesoría', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Estudiantes>>(
        future: _estudiantesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final listaEstudiantes = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: LayoutBuilder(builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 700;
                  return isMobile 
                    ? _buildFormContent(listaEstudiantes, isMobile: true) 
                    : _buildFormContent(listaEstudiantes, isMobile: false);
                }),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildFormContent(List<Estudiantes> estudiantes, {required bool isMobile}) {
    final columna1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Seleccionar Alumno"),
        DropdownButtonFormField<Estudiantes>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: estudiantes.map((e) => DropdownMenuItem(value: e, child: Text(e.nombre))).toList(),
          onChanged: (val) => setState(() => _estudianteSeleccionado = val),
        ),
        const SizedBox(height: 20),
        // Campos informativos que se llenan solos
        _buildCampoLectura("Licenciatura", _estudianteSeleccionado?.licenciatura ?? "---"),
        _buildCampoLectura("Grado y Grupo", _estudianteSeleccionado?.grupo ?? "---"),
        
        _buildCampoDropdown('Materia', _selectedMateria,
            ['Programación', 'Base de Datos', 'Matemáticas'],
            (val) => setState(() => _selectedMateria = val)),
      ],
    );

    final columna2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCampoDropdown('Modalidad', _selectedModalidad,
            ['Presencial', 'Virtual', 'Híbrida'],
            (val) => setState(() => _selectedModalidad = val)),
        _buildCampoDropdown('Horario', _selectedHorario,
            ['07:00 - 08:00', '13:00 - 14:00', '18:00 - 19:00'],
            (val) => setState(() => _selectedHorario = val)),
        _buildLabel("Periodo"),
        Row(
          children: [
            _buildCampoFecha('Inicio', _fechaInicioController),
            const SizedBox(width: 10),
            _buildCampoFecha('Fin', _fechaFinalController),
          ],
        ),
        const SizedBox(height: 20),
        _buildCampoDropdown('Razón', _selectedRazon,
            ['Dudas', 'Reprobada', 'Reforzamiento'],
            (val) => setState(() => _selectedRazon = val)),
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

  // --- COMPONENTES UI ---

  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildCampoLectura(String label, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Text(valor, style: const TextStyle(color: Colors.black54)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCampoDropdown(String label, String? currentVal, List<String> opciones, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<String>(
          value: currentVal,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCampoFecha(String label, TextEditingController controller) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today, size: 18),
          border: const OutlineInputBorder(),
          hintText: label,
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2026),
          );
          if (picked != null) {
            setState(() => controller.text = "${picked.day}/${picked.month}/${picked.year}");
          }
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      //decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolores.azulUas,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: _intentarGuardar,
        child: const Text('CONFIRMAR REGISTRO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}