import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/repositories/asesorias_repository.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/data/services/asesores_par_service.dart';
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
  List<dynamic> _todosLosAsesores = []; 
  List<String> _materiasDisponibles = [
    'Introducción a la programacion', 'Base de Datos', 'Ingeniería de Software', 'Redes', 'Web', 'Programacion'
  ];
  List<String> _horariosDisponibles = ['07:00 - 08:00', '13:00 - 14:00', '18:00 - 19:00'];

  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinalController = TextEditingController();
  
  Estudiantes? _estudianteSeleccionado;
  dynamic _asesorSeleccionado; 
  String? _selectedMateria;
  String? _selectedModalidad;
  String? _selectedHorario;
  String? _selectedRazon;

  @override
  void initState() {
    super.initState();
    _estudiantesFuture = EstudiantesService().getEstudiantes();
    _cargarAsesores();
  }

  void _cargarAsesores() async {
    final disc = await AsesoresDiciplinaresService().getAsesoresDiciplinares();
    final pares = await AsesoresParService().getAsesoresPar();
    setState(() {
      _todosLosAsesores = [...disc, ...pares];
    });
  }

  void _onAsesorChanged(dynamic asesor) {
    setState(() {
      _asesorSeleccionado = asesor;
      if (asesor != null) {
        _materiasDisponibles = List<String>.from(asesor.materiasAsesora);
        _horariosDisponibles = List<String>.from(asesor.horariosAsesora);
        if (!_materiasDisponibles.contains(_selectedMateria)) _selectedMateria = null;
        if (!_horariosDisponibles.contains(_selectedHorario)) _selectedHorario = null;
      }
    });
  }

  void _onMateriaChanged(String? materia) {
    setState(() {
      _selectedMateria = materia;
      if (materia != null && _asesorSeleccionado == null) {
        try {
          final asesorAuto = _todosLosAsesores.firstWhere(
            (a) => a.materiasAsesora.contains(materia)
          );
          _asesorSeleccionado = asesorAuto;
          _horariosDisponibles = List<String>.from(asesorAuto.horariosAsesora);
        } catch (e) {
          // No hay asesor para esa materia
        }
      }
    });
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
      observaciones: "", 
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
      // Se quitó el AppBar para usar un encabezado personalizado dentro del body
      body: SafeArea(
        child: Column(
          children: [
            // --- ENCABEZADO ESTILO MODAL INFORMACIÓN ---
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Registrar Nueva Asesoría',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
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
              child: FutureBuilder<List<Estudiantes>>(
                future: _estudiantesFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final listaEstudiantes = snapshot.data!;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: LayoutBuilder(builder: (context, constraints) {
                          bool isMobile = constraints.maxWidth < 700;
                          return _buildFormContent(listaEstudiantes, isMobile: isMobile);
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // --- BOTÓN INFERIOR ---
            const Divider(height: 1),
            _buildBottomBar(),
          ],
        ),
      ),
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
        _buildCampoLectura("Licenciatura", _estudianteSeleccionado?.licenciatura ?? "---"),
        _buildCampoLectura("Grado y Grupo", _estudianteSeleccionado?.grupo ?? "---"),
        
        _buildLabel("Seleccionar Asesor"),
        DropdownButtonFormField<dynamic>(
          value: _asesorSeleccionado,
          decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Opcional (Filtra materias)"),
          items: _todosLosAsesores.map((a) => DropdownMenuItem(value: a, child: Text(a.nombre))).toList(),
          onChanged: _onAsesorChanged,
        ),
        const SizedBox(height: 20),
      ],
    );

    final columna2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCampoDropdown('Materia', _selectedMateria, _materiasDisponibles, _onMateriaChanged),
        _buildCampoDropdown('Modalidad', _selectedModalidad, ['Presencial', 'Virtual'], (val) => setState(() => _selectedModalidad = val)),
        _buildCampoDropdown('Horario', _selectedHorario, _horariosDisponibles, (val) => setState(() => _selectedHorario = val)),
        _buildLabel("Periodo"),
        Row(
          children: [
            _buildCampoFecha('Inicio', _fechaInicioController),
            const SizedBox(width: 10),
            _buildCampoFecha('Fin', _fechaFinalController),
          ],
        ),
        const SizedBox(height: 20),
        _buildCampoDropdown('Razón', _selectedRazon, ['Dudas', 'Reprobada', 'Reforzamiento'], (val) => setState(() => _selectedRazon = val)),
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
          isExpanded: true,
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
            lastDate: DateTime(2027),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.azulUas,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _intentarGuardar,
            child: const Text('CONFIRMAR REGISTRO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

/* import 'package:asesorias_fic/core/colores.dart';
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
            ['Introducción a la programacion',
            'Base de Datos',
            'Ingeniería de Software',
            'Redes'
            ],
            (val) => setState(() => _selectedMateria = val)),
      ],
    );

    final columna2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCampoDropdown('Modalidad', _selectedModalidad,
            ['Presencial', 'Virtual'],
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
            lastDate: DateTime(2027),
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
} */