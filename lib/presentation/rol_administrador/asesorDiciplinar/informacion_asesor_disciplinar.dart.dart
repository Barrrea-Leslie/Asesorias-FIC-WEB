import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/asesorDiciplinar/crear_asesor_disiplinar.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class EditarAsesorDisciplinar extends StatefulWidget {
  const EditarAsesorDisciplinar({super.key});

  @override
  State<EditarAsesorDisciplinar> createState() => _EditarAsesorDisciplinarState();
}

class _EditarAsesorDisciplinarState extends State<EditarAsesorDisciplinar> {
  final _formKey = GlobalKey<FormState>();
  final service = AsesoresDiciplinaresService();

  late TextEditingController nombreController;
  late TextEditingController apellidoPController;
  late TextEditingController apellidoMController;
  late TextEditingController cuentaController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;
  late TextEditingController contrasenaController;

  List<MateriaItem> catalogoMaterias = [];
  List<MateriaItem> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  late AsesorDisciplinar asesorOriginal;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is AsesorDisciplinar) {
      asesorOriginal = args;

      // Inicializamos controladores
      nombreController = TextEditingController(text: asesorOriginal.nombre);
      apellidoPController = TextEditingController(text: asesorOriginal.apellidoPaterno);
      apellidoMController = TextEditingController(text: asesorOriginal.apellidoMaterno);
      cuentaController = TextEditingController(text: asesorOriginal.numeroCuenta);
      correoController = TextEditingController(text: asesorOriginal.correo);
      telefonoController = TextEditingController(text: asesorOriginal.numCel);
      contrasenaController = TextEditingController(text: asesorOriginal.numeroCuenta);

      materiasSeleccionadas = asesorOriginal.materiasAsesora
          .map((m) => MateriaItem(id: int.tryParse(m) ?? 0, nombre: m))
          .toList();
      horariosSeleccionados = List<String>.from(asesorOriginal.horariosAsesora);

      _cargarCatalogoMaterias();
    }

    _initialized = true;
  }

  void _cargarCatalogoMaterias() async {
    try {
      final lista = await service.obtenerCatalogoCompletoMaterias();
      setState(() {
        catalogoMaterias = lista
            .map((m) => MateriaItem(id: m['id_materia'], nombre: m['materia']))
            .toList();
      });
    } catch (e) {
      print("Error cargando materias: $e");
    }
  }

  void _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;
    if (materiasSeleccionadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona al menos una materia")),
      );
      return;
    }

    final payload = {
      "id_persona": asesorOriginal.idPersona,
      "nombre": nombreController.text,
      "apellido_paterno": apellidoPController.text,
      "apellido_materno": apellidoMController.text,
      "numero_cuenta": cuentaController.text,
      "contrasena": contrasenaController.text,
      "correo": correoController.text,
      "num_cel": telefonoController.text,
      "materias": materiasSeleccionadas.map((m) => m.id).toList(),
      "horarios": horariosSeleccionados,
    };

    try {
      await service.editarAsesor(payload);
      if (!mounted) return;
      Navigator.pop(context, true);
      MensajeConfirmacion.mostrarMensaje(context, "Cambios guardados correctamente");
    } catch (e) {
      print("Error al actualizar asesor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al actualizar asesor"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Editar Asesor Disciplinar", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final dosColumnas = constraints.maxWidth > 900;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _campo(nombreController, "Nombre(s)", dosColumnas),
                      _campo(apellidoPController, "Apellido Paterno", dosColumnas),
                      _campo(apellidoMController, "Apellido Materno", dosColumnas),
                      _campo(cuentaController, "Número de Cuenta", dosColumnas, enabled: false),
                      _campo(contrasenaController, "Contraseña", dosColumnas, obscure: true),
                      _campo(correoController, "Correo Institucional", dosColumnas, isEmail: true),
                      _campo(telefonoController, "Teléfono", dosColumnas, isPhone: true),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _header("Materias que asesora", _abrirModalMaterias),
                  _listaMaterias(),
                  const SizedBox(height: 20),
                  _header("Horarios de asesoría", _seleccionarHorario),
                  _listaHorarios(),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolores.azulUas,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: _guardarCambios,
                      child: const Text("APLICAR CAMBIOS", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _campo(
    TextEditingController controller,
    String label,
    bool dosColumnas, {
    bool isEmail = false,
    bool isPhone = false,
    bool obscure = false,
    bool enabled = true,
  }) {
    return SizedBox(
      width: dosColumnas ? 400 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: enabled,
            obscureText: obscure,
            keyboardType: isEmail
                ? TextInputType.emailAddress
                : (isPhone ? TextInputType.phone : TextInputType.text),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (v) => v == null || v.isEmpty ? "Campo obligatorio" : null,
          ),
        ],
      ),
    );
  }

  Widget _header(String titulo, VoidCallback onAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 18),
          label: const Text("Añadir"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Appcolores.verdeClaro,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _listaMaterias() => Column(
        children: materiasSeleccionadas
            .map(
              (m) => ListTile(
                title: Text(m.nombre),
                trailing: const Icon(Icons.delete_outline, color: Colors.red),
                onTap: () => setState(() => materiasSeleccionadas.remove(m)),
              ),
            )
            .toList(),
      );

  Widget _listaHorarios() => Column(
        children: horariosSeleccionados
            .map(
              (h) => ListTile(
                title: Text(h),
                trailing: const Icon(Icons.delete_outline, color: Colors.red),
                onTap: () => setState(() => horariosSeleccionados.remove(h)),
              ),
            )
            .toList(),
      );

  void _abrirModalMaterias() {
    showDialog(
      context: context,
      builder: (_) {
        String filtro = "";
        return StatefulBuilder(
          builder: (_, setModal) {
            final sugerencias = catalogoMaterias
                .where((m) => m.nombre.toLowerCase().contains(filtro.toLowerCase()))
                .toList();

            return AlertDialog(
              title: const Text("Buscar materia"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Nombre de materia",
                    ),
                    onChanged: (v) => setModal(() => filtro = v),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: ListView.builder(
                      itemCount: sugerencias.length,
                      itemBuilder: (_, i) {
                        final materia = sugerencias[i];
                        return ListTile(
                          title: Text(materia.nombre),
                          onTap: () {
                            if (!materiasSeleccionadas.any((m) => m.id == materia.id)) {
                              setState(() => materiasSeleccionadas.add(materia));
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _seleccionarHorario() async {
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t != null) setState(() => horariosSeleccionados.add(t.format(context)));
  }
}


/* import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class EditarAsesorDisciplinar extends StatefulWidget {
  const EditarAsesorDisciplinar({super.key});

  @override
  State<EditarAsesorDisciplinar> createState() => _EditarAsesorDisciplinarState();
}

class _EditarAsesorDisciplinarState extends State<EditarAsesorDisciplinar> {
  final _editarformKey = GlobalKey<FormState>();
  
  late TextEditingController nombreController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;

  List<String> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  bool _isInitialized = false;
  late AsesorDisciplinar asesorOriginal;

  final List<String> catalogoMaterias = [
    'Programacion I', 'Programacion II', 'Principios de programacion', 
    'Programacion Web', 'Bases de Datos', 'Estructura de Datos'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is AsesorDisciplinar) {
        asesorOriginal = args;
        
        nombreController = TextEditingController(text: asesorOriginal.nombre);
        correoController = TextEditingController(text: asesorOriginal.correoInstitucional);
        telefonoController = TextEditingController(text: asesorOriginal.numeroTelefono);

        // Cargamos las listas actuales
        materiasSeleccionadas = List.from(asesorOriginal.materiasAsesora);
        horariosSeleccionados = List.from(asesorOriginal.horariosAsesora);
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Editar Asesor Disciplinar', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 700,
            child: Form(
              key: _editarformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Nombre completo"),
                  _buildTextField(nombreController, "Ej. Juan Pérez"),
                  
                  const SizedBox(height: 20),
                  _buildLabel("Correo institucional"),
                  _buildTextField(correoController, "correo@uas.edu.mx", isEmail: true),
            
                  const SizedBox(height: 20),
                  _buildLabel("Teléfono"),
                  _buildTextField(telefonoController, "6671234567", isPhone: true),
            
                  const SizedBox(height: 30),
            
                  _buildHeaderSeccion(
                    titulo: "Materias que asesora",
                    onAdd: () => _abrirModalMaterias(),
                  ),
                  _buildListaItems(materiasSeleccionadas),
            
                  const SizedBox(height: 30),
            
                  _buildHeaderSeccion(
                    titulo: "Horarios de asesoría",
                    onAdd: () => _seleccionarHorario(),
                  ),
                  _buildListaItems(horariosSeleccionados),
            
                  const SizedBox(height: 50),
            
                  Center(
                    child: SizedBox(
                      
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolores.azulUas,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                        onPressed: _guardarCambios,
                        child: const Text("APLICAR CAMBIOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _guardarCambios() {
    if (_editarformKey.currentState!.validate()) {
      final actualizado = asesorOriginal.copyWith(
        nombre: nombreController.text,
        correoInstitucional: correoController.text,
        numeroTelefono: telefonoController.text,
        materiasAsesora: materiasSeleccionadas,
        horariosAsesora: horariosSeleccionados,
      );
      
      Navigator.pop(context, actualizado);
      MensajeConfirmacion.mostrarMensaje(context, "Se aplicaron los cambios correctamente.");
    }
  }

  // --- MÉTODOS DE UI (IGUALES A CREAR) ---

  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : (isPhone ? TextInputType.phone : TextInputType.text),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) => val == null || val.isEmpty ? "Campo obligatorio" : null,
    );
  }

  Widget _buildHeaderSeccion({required String titulo, required VoidCallback onAdd}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 18),
          label: const Text("Añadir"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Appcolores.verdeClaro,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildListaItems(List<String> lista) {
    return Column(
      children: lista.map((item) => ListTile(
        title: Text(item),
        trailing: const Text("eliminar", style: TextStyle(color: Colors.red)),
        onTap: () => setState(() => lista.remove(item)),
      )).toList(),
    );
  }

  // --- MODALES ---

  void _abrirModalMaterias() {
    showDialog(
      context: context,
      builder: (context) {
        String filtro = "";
        return StatefulBuilder(builder: (context, setModalState) {
          final sugerencias = catalogoMaterias
              .where((m) => m.toLowerCase().contains(filtro.toLowerCase()))
              .toList();

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  height: 200,
                  width: 300,
                  child: ListView.builder(
                    itemCount: sugerencias.length,
                    itemBuilder: (ctx, i) => ListTile(
                      title: Text(sugerencias[i]),
                      trailing: const Icon(Icons.add_circle, color: Colors.green),
                      onTap: () {
                        setState(() => materiasSeleccionadas.add(sugerencias[i]));
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

  void _seleccionarHorario() async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() => horariosSeleccionados.add(time.format(context)));
    }
  }
} */