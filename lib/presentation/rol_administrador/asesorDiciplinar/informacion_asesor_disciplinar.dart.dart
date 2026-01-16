import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class EditarAsesorDisciplinar extends StatefulWidget {
  final AsesorDisciplinar asesor;

  const EditarAsesorDisciplinar({super.key, required this.asesor});

  @override
  State<EditarAsesorDisciplinar> createState() => _EditarAsesorDisciplinarState();
}

class _EditarAsesorDisciplinarState extends State<EditarAsesorDisciplinar> {
  final _editarformKey = GlobalKey<FormState>();
  
  late TextEditingController nombreController;
  late TextEditingController cuentaController;
  late TextEditingController contraController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;

  List<String> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  final List<String> catalogoMaterias = [
    'Programacion I', 'Programacion II', 'Principios de programacion', 
    'Programacion Web', 'Bases de Datos', 'Estructura de Datos'
  ];

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.asesor.nombre);
    cuentaController = TextEditingController(text: widget.asesor.numeroCuenta);
    contraController = TextEditingController(text: widget.asesor.contrasena);
    correoController = TextEditingController(text: widget.asesor.correoInstitucional);
    telefonoController = TextEditingController(text: widget.asesor.numeroTelefono);

    materiasSeleccionadas = List.from(widget.asesor.materiasAsesora);
    horariosSeleccionados = List.from(widget.asesor.horariosAsesora);
  }

  @override
  void dispose() {
    nombreController.dispose();
    cuentaController.dispose();
    contraController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // IMPORTANTE: No usamos Scaffold para que respete el tamaño del Dialog
    return Column(
      children: [
        // --- ENCABEZADO IDÉNTICO AL DE CREAR ---
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Editar Asesor Disciplinar',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Form(
              key: _editarformKey,
              child: LayoutBuilder(builder: (context, constraints) {
                // Mantenemos la lógica de columnas de tu código de "Crear"
                bool isMobile = constraints.maxWidth < 700;
                return isMobile 
                  ? Column(children: [_buildColumna1(), const SizedBox(height: 30), _buildColumna2()])
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildColumna1()),
                        const SizedBox(width: 50),
                        Expanded(child: _buildColumna2()),
                      ],
                    );
              }),
            ),
          ),
        ),

        // --- BOTÓN INFERIOR ---
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolores.azulUas,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_editarformKey.currentState!.validate()) {
                    final actualizado = widget.asesor.copyWith(
                      nombre: nombreController.text,
                      numeroCuenta: cuentaController.text,
                      contrasena: contraController.text,
                      correoInstitucional: correoController.text,
                      numeroTelefono: telefonoController.text,
                      materiasAsesora: materiasSeleccionadas,
                      horariosAsesora: horariosSeleccionados,
                    );
                    Navigator.pop(context, actualizado);
                    MensajeConfirmacion.mostrarMensaje(context, "Cambios aplicados con éxito.");
                  }
                },
                child: const Text('CONFIRMAR CAMBIOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- MISMOS MÉTODOS DE TU CÓDIGO "CREAR" ---

  Widget _buildColumna1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nombre completo"),
        _buildTextField(nombreController, "Ej. Juan Pérez"),
        const SizedBox(height: 20),
        _buildLabel("Número de Cuenta"),
        _buildTextField(cuentaController, "20219876"),
        const SizedBox(height: 20),
        _buildLabel("Contraseña"),
        _buildTextField(contraController, "********", isPassword: true),
        const SizedBox(height: 20),
        _buildLabel("Correo institucional"),
        _buildTextField(correoController, "correo@uas.edu.mx", isEmail: true),
        
      ],
    );
  }

  Widget _buildColumna2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        _buildLabel("Teléfono"),
        _buildTextField(telefonoController, "6671234567", isPhone: true),
        const SizedBox(height: 30),
        _buildHeaderSeccion(titulo: "Materias que asesora", onAdd: () => _abrirModalMaterias()),
        _buildListaItems(materiasSeleccionadas),
        const SizedBox(height: 30),
        _buildHeaderSeccion(titulo: "Horarios de asesoría", onAdd: () => _seleccionarHorario()),
        _buildListaItems(horariosSeleccionados),
      ],
    );
  }

  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        border: const OutlineInputBorder(),
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
        title: Text(item, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
        onTap: () => setState(() => lista.remove(item)),
      )).toList(),
    );
  }

  // --- LÓGICA DE MODALES DE MATERIAS Y HORARIOS (COMO EN CREAR) ---

  void _abrirModalMaterias() {
    showDialog(
      context: context,
      builder: (context) {
        String filtro = "";
        return StatefulBuilder(builder: (context, setModalState) {
          final sugerencias = catalogoMaterias.where((m) => m.toLowerCase().contains(filtro.toLowerCase())).toList();
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
                  height: 200, width: 300,
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
}
/* import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

import 'crear_asesor_disiplinar.dart';

class EditarAsesorDisciplinar extends StatefulWidget {
  const EditarAsesorDisciplinar({super.key});

  @override
  State<EditarAsesorDisciplinar> createState() =>
      _EditarAsesorDisciplinarState();
}

class _EditarAsesorDisciplinarState extends State<EditarAsesorDisciplinar> {
  final _formKey = GlobalKey<FormState>();
  final AsesoresDiciplinaresService service = AsesoresDiciplinaresService();

  late TextEditingController nombreController;
  late TextEditingController apellidoPController;
  late TextEditingController apellidoMController;
  late TextEditingController cuentaController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;
  late TextEditingController contrasenaController;

  List<MateriaItem> catalogoMaterias = [];
  List<MateriaItem> materiasSeleccionadas = [];
  List<HorarioItem> catalogoHorarios = [];
  List<HorarioItem> horariosSeleccionados = [];

  late AsesorDisciplinar asesorOriginal;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is AsesorDisciplinar) {
      asesorOriginal = args;

      nombreController = TextEditingController(text: asesorOriginal.nombre);
      apellidoPController =
          TextEditingController(text: asesorOriginal.apellidoPaterno);
      apellidoMController =
          TextEditingController(text: asesorOriginal.apellidoMaterno);
      cuentaController =
          TextEditingController(text: asesorOriginal.numeroCuenta);
      correoController = TextEditingController(text: asesorOriginal.correo);
      telefonoController = TextEditingController(text: asesorOriginal.numCel);
      contrasenaController =
          TextEditingController(text: asesorOriginal.numeroCuenta);

      // Copiamos las listas del asesor original para manipularlas
      materiasSeleccionadas = List<MateriaItem>.from(asesorOriginal.materiasasesor);
      horariosSeleccionados = List<HorarioItem>.from(asesorOriginal.horariosasesor);

      _cargarCatalogos();
    }

    _initialized = true;
  }

  void _cargarCatalogos() async {
    try {
      final mat = await service.obtenerMaterias();
      final hor = await service.obtenerHorarios();
      setState(() {
        catalogoMaterias = mat;
        catalogoHorarios = hor;
      });
    } catch (e) {
      print("Error cargando catálogos: $e");
    }
  }

  void _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;

    if (materiasSeleccionadas.isEmpty || horariosSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona al menos una materia y un horario")),
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
      "materias": materiasSeleccionadas.map((m) => {"id_materia": m.id}).toList(),
      "horarios": horariosSeleccionados.map((h) => {"id_horario": h.id}).toList(),
    };

    try {
      await service.editarAsesor(payload);
      if (!mounted) return;
      Navigator.pop(context, true);
      MensajeConfirmacion.mostrarMensaje(
          context, "Cambios guardados correctamente");
    } catch (e) {
      print("Error al actualizar asesor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Error al actualizar asesor"),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text('Editar Asesor Disciplinar', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      _campo(cuentaController, "Número de Cuenta", dosColumnas),
                      _campo(contrasenaController, "Contraseña", dosColumnas,
                          obscure: true),
                      _campo(correoController, "Correo Institucional", dosColumnas,
                          isEmail: true),
                      _campo(telefonoController, "Teléfono", dosColumnas,
                          isPhone: true),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _header("Materias que asesora", _abrirModalMaterias),
                  _listaMaterias(),
                  const SizedBox(height: 20),
                  _header("Horarios de asesoría", _abrirModalHorarios),
                  _listaHorarios(),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolores.azulUas,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: _guardarCambios,
                      child: const Text("APLICAR CAMBIOS",
                          style: TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _campo(TextEditingController controller, String label, bool dosColumnas,
      {bool isEmail = false, bool isPhone = false, bool obscure = false}) {
    return SizedBox(
      width: dosColumnas ? 400 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscure,
            keyboardType: isEmail
                ? TextInputType.emailAddress
                : (isPhone ? TextInputType.phone : TextInputType.text),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[50],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        Text(titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                title: Text(h.texto),
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
                        hintText: "Nombre de materia"),
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
                            if (!materiasSeleccionadas
                                .any((m) => m.id == materia.id)) {
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

  void _abrirModalHorarios() {
    showDialog(
      context: context,
      builder: (_) {
        String filtro = "";
        return StatefulBuilder(
          builder: (_, setModal) {
            final sugerencias = catalogoHorarios
                .where((h) => h.texto.toLowerCase().contains(filtro.toLowerCase()))
                .toList();
            return AlertDialog(
              title: const Text("Seleccionar horario"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Buscar horario"),
                    onChanged: (v) => setModal(() => filtro = v),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: ListView.builder(
                      itemCount: sugerencias.length,
                      itemBuilder: (_, i) {
                        final horario = sugerencias[i];
                        return ListTile(
                          title: Text(horario.texto),
                          onTap: () {
                            if (!horariosSeleccionados
                                .any((h) => h.id == horario.id)) {
                              setState(() => horariosSeleccionados.add(horario));
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
} */


