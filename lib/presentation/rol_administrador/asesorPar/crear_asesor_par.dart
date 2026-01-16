import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/repositories/estudiantes_repository.dart';
import 'package:flutter/material.dart';

class CrearAsesoresPar extends StatefulWidget {
  const CrearAsesoresPar({super.key});

  @override
  State<CrearAsesoresPar> createState() => _CrearAsesoresParState();
}

class _CrearAsesoresParState extends State<CrearAsesoresPar> {
  final _formKey = GlobalKey<FormState>();
  final EstudiantesRepository _estudiantesRepo = EstudiantesRepository();
  
  // Future para cargar estudiantes al iniciar
  late Future<List<Estudiantes>> _estudiantesFuture;

  // Controladores
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController cuentaController = TextEditingController();
  final TextEditingController contraController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController promedioController = TextEditingController();

  // Variables para Dropdowns
  String? _selectedLicenciatura;
  String? _selectedGrupo;
  Estudiantes? _estudianteSeleccionado;

  final List<String> grupos = ['1-1', '1-2', '2-1', '2-2', '3-1', '3-2', '4-1', '4-2', '4-3'];
  final List<String> licenciaturas = [
    "Licenciatura en informatica",
    "Licenciatura en informatica virtual",
    "Licenciatura en ingenieria en ciencias de datos",
    "Licenciatura en ITSE"
  ];

  List<String> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  final List<String> catalogoMaterias = [
    'Programacion I', 'Programacion II', 'Principios de programacion', 
    'Programacion Web', 'Bases de Datos', 'Estructura de Datos'
  ];

  final List<Map<String, dynamic>> catalogoHorarios = [
    {"id_horario": 1, "horario": "7:00-8:00 AM"}, {"id_horario": 2, "horario": "8:00-9:00 AM"},
    {"id_horario": 3, "horario": "9:00-10:00 AM"}, {"id_horario": 4, "horario": "10:00-11:00 AM"},
    {"id_horario": 5, "horario": "11:00-12:00 PM"}, {"id_horario": 6, "horario": "12:00-1:00 PM"},
    {"id_horario": 7, "horario": "1:00-2:00 PM"}, {"id_horario": 8, "horario": "2:00-3:00 PM"},
    {"id_horario": 9, "horario": "3:00-4:00 PM"}, {"id_horario": 10, "horario": "4:00-5:00 PM"},
    {"id_horario": 11, "horario": "5:00-6:00 PM"}, {"id_horario": 12, "horario": "6:00-7:00 PM"},
    {"id_horario": 13, "horario": "7:00-8:00 PM"}, {"id_horario": 14, "horario": "8:00-9:00 PM"},
    {"id_horario": 15, "horario": "9:00-10:00 PM"}, {"id_horario": 16, "horario": "10:00-11:00 PM"}
  ];

  @override
  void initState() {
    super.initState();
    // Cargamos los estudiantes desde el inicio
    _estudiantesFuture = _estudiantesRepo.fetchEstudiantes();
  }

  void _onEstudianteChanged(Estudiantes? est) {
    if (est == null) return;
    setState(() {
      _estudianteSeleccionado = est;
      nombreController.text = est.nombre;
      cuentaController.text = est.numeroCuenta;
      contraController.text = est.contrasena;
      correoController.text = est.correoInstitucional;
      telefonoController.text = est.numeroTelefono;
      promedioController.text = est.promedio.toString();
      
      _selectedLicenciatura = licenciaturas.contains(est.licenciatura) ? est.licenciatura : null;
      _selectedGrupo = grupos.contains(est.grupo) ? est.grupo : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEncabezado(),
        const Divider(height: 1),
        Expanded(
          child: FutureBuilder<List<Estudiantes>>(
            future: _estudiantesFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final listaEstudiantes = snapshot.data!;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: LayoutBuilder(builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 700;
                    return Column(
                      children: [
                        _buildSelectorEstudianteDropdown(listaEstudiantes),
                        const SizedBox(height: 25),
                        isMobile 
                          ? Column(children: [_buildColumna1(), const SizedBox(height: 30), _buildColumna2()])
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              children: [
                                Expanded(child: _buildColumna1()),
                                const SizedBox(width: 50),
                                Expanded(child: _buildColumna2()),
                              ],
                            ),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildSelectorEstudianteDropdown(List<Estudiantes> estudiantes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Seleccionar Alumno"),
        DropdownButtonFormField<Estudiantes>(
          value: _estudianteSeleccionado,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            hintText: "Busca un alumno de la lista"
          ),
          items: estudiantes.map((e) => DropdownMenuItem(
            value: e, 
            child: Text("${e.nombre} (${e.numeroCuenta})", style: const TextStyle(fontSize: 14))
          )).toList(),
          onChanged: _onEstudianteChanged,
          validator: (val) => val == null ? "Debe seleccionar un estudiante" : null,
        ),
      ],
    );
  }

  Widget _buildEncabezado() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Registrar Nuevo Asesor Par', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _buildColumna1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nombre completo"), 
        _buildTextField(nombreController, "Nombre del alumno", readOnly: true),
        const SizedBox(height: 15),
        _buildLabel("Número de Cuenta"), 
        _buildTextField(cuentaController, "Cuenta", readOnly: true),
        const SizedBox(height: 15),
        _buildLabel("Contraseña"), 
        _buildTextField(contraController, "Contraseña", isPassword: true),
        const SizedBox(height: 15),
        _buildLabel("Correo institucional"), 
        _buildTextField(correoController, "correo@info.uas.edu.mx"),
      ],
    );
  }

  Widget _buildColumna2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Teléfono"),
        _buildTextField(telefonoController, "Teléfono"),
        const SizedBox(height: 15),
        _buildCampoDropdown("Licenciatura", _selectedLicenciatura, licenciaturas, (val) => setState(() => _selectedLicenciatura = val)),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCampoDropdown("Grupo", _selectedGrupo, grupos, (val) => setState(() => _selectedGrupo = val))),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [_buildLabel("Promedio"), _buildTextField(promedioController, "0.0")]
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildHeaderSeccion(titulo: "Materias que asesora", onAdd: () => _abrirModalMaterias()),
        _buildListaItems(materiasSeleccionadas),
        const SizedBox(height: 25),
        _buildHeaderSeccion(titulo: "Horarios de asesoría", onAdd: () => _abrirModalHorarios()),
        _buildListaItems(horariosSeleccionados),
      ],
    );
  }

  // --- COMPONENTES UI REUTILIZABLES ---
  Widget _buildLabel(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 5), 
    child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold))
  );

  Widget _buildTextField(TextEditingController c, String h, {bool isPassword = false, bool readOnly = false}) {
    return TextFormField(
      controller: c,
      obscureText: isPassword,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: h, 
        filled: true, 
        fillColor: readOnly ? Colors.grey[200] : Colors.grey[50], 
        border: const OutlineInputBorder()
      ),
      validator: (v) => v!.isEmpty ? "Requerido" : null,
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
            filled: true,
            fillColor: Colors.grey[50],
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
          items: opciones.map((e) => DropdownMenuItem(
            value: e, 
            child: Text(e, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13))
          )).toList(),
          onChanged: onChanged,
          validator: (val) => val == null ? "Requerido" : null,
        ),
      ],
    );
  }

  Widget _buildHeaderSeccion({required String titulo, required VoidCallback onAdd}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        ElevatedButton.icon(
          onPressed: onAdd, 
          icon: const Icon(Icons.add, size: 16), 
          label: const Text("Añadir"),
          style: ElevatedButton.styleFrom(backgroundColor: Appcolores.verdeClaro, foregroundColor: Colors.white)
        ),
      ],
    );
  }

  Widget _buildListaItems(List<String> lista) {
    return Column(
      children: lista.map((item) => ListTile(
        title: Text(item, style: const TextStyle(fontSize: 13)),
        trailing: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
        onTap: () => setState(() => lista.remove(item)),
      )).toList(),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolores.azulUas, 
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (materiasSeleccionadas.isEmpty || horariosSeleccionados.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Agregue al menos una materia y un horario"))
                  );
                  return;
                }
                Navigator.pop(context);
              }
            },
            child: const Text('CONFIRMAR REGISTRO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- LÓGICA DE MODALES DE MATERIAS Y HORARIOS ---
  void _abrirModalMaterias() {
    showDialog(
      context: context,
      builder: (context) {
        String filtro = "";
        return StatefulBuilder(builder: (context, setModalState) {
          final sugerencias = catalogoMaterias.where((m) => m.toLowerCase().contains(filtro.toLowerCase())).toList();
          return AlertDialog(
            title: const Text("Buscar Materia"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Nombre de materia"),
                  onChanged: (val) => setModalState(() => filtro = val),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200, width: 300,
                  child: ListView.builder(
                    itemCount: sugerencias.length,
                    itemBuilder: (ctx, i) => ListTile(
                      title: Text(sugerencias[i]),
                      onTap: () {
                        setState(() {
                          if (!materiasSeleccionadas.contains(sugerencias[i])) {
                            materiasSeleccionadas.add(sugerencias[i]);
                          }
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  void _abrirModalHorarios() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Seleccionar Horario"),
          content: SizedBox(
            height: 300, width: 300,
            child: ListView.builder(
              itemCount: catalogoHorarios.length,
              itemBuilder: (ctx, i) {
                final h = catalogoHorarios[i]['horario'];
                return ListTile(
                  title: Text(h),
                  onTap: () {
                    setState(() {
                      if (!horariosSeleccionados.contains(h)) {
                        horariosSeleccionados.add(h);
                      }
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}