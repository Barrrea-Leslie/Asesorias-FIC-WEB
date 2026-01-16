import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class CrearAsesorDisiplinar extends StatefulWidget {
  const CrearAsesorDisiplinar({super.key});

  @override
  State<CrearAsesorDisiplinar> createState() => _CrearAsesorDisiplinarState();
}

class _CrearAsesorDisiplinarState extends State<CrearAsesorDisiplinar> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController cuentaController = TextEditingController();
  final TextEditingController contraController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  List<String> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  final List<String> catalogoMaterias = [
    'Programacion I', 'Programacion II', 'Principios de programacion', 
    'Programacion Web', 'Bases de Datos', 'Estructura de Datos'
  ];

  // NUEVA LISTA DE HORARIOS
  final List<Map<String, dynamic>> catalogoHorarios = [
    {"id_horario": 1, "horario": "7:00-8:00 AM"},
    {"id_horario": 2, "horario": "8:00-9:00 AM"},
    {"id_horario": 3, "horario": "9:00-10:00 AM"},
    {"id_horario": 4, "horario": "10:00-11:00 AM"},
    {"id_horario": 5, "horario": "11:00-12:00 PM"},
    {"id_horario": 6, "horario": "12:00-1:00 PM"},
    {"id_horario": 7, "horario": "1:00-2:00 PM"},
    {"id_horario": 8, "horario": "2:00-3:00 PM"},
    {"id_horario": 9, "horario": "3:00-4:00 PM"},
    {"id_horario": 10, "horario": "4:00-5:00 PM"},
    {"id_horario": 11, "horario": "5:00-6:00 PM"},
    {"id_horario": 12, "horario": "6:00-7:00 PM"},
    {"id_horario": 13, "horario": "7:00-8:00 PM"},
    {"id_horario": 14, "horario": "8:00-9:00 PM"},
    {"id_horario": 15, "horario": "9:00-10:00 PM"},
    {"id_horario": 16, "horario": "10:00-11:00 PM"},
    {"id_horario": 17, "horario": "11:00-12:00 AM"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Registrar Nuevo Asesor Disciplinar',
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Form(
                      key: _formKey,
                      child: LayoutBuilder(builder: (context, constraints) {
                        bool isMobile = constraints.maxWidth < 700;
                        return isMobile 
                          ? Column(children: [_buildColumna1(), _buildColumna2()])
                          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Expanded(child: _buildColumna1()),
                              const SizedBox(width: 50),
                              Expanded(child: _buildColumna2()),
                            ]);
                      }),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

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
        const SizedBox(height: 20),
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
        // AHORA LLAMA A _abrirModalHorarios
        _buildHeaderSeccion(titulo: "Horarios de asesoría", onAdd: () => _abrirModalHorarios()),
        _buildListaItems(horariosSeleccionados),
      ],
    );
  }

  // --- COMPONENTES REUTILIZABLES ---
  Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : (isPhone ? TextInputType.phone : TextInputType.text),
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

  Widget _buildBottomBar() {
    return Padding(
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
              }
            },
            child: const Text('CONFIRMAR REGISTRO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- MODAL DE MATERIAS ---
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

  // --- NUEVO MODAL DE HORARIOS (ESTILO BUSCADOR) ---
  void _abrirModalHorarios() {
    showDialog(
      context: context,
      builder: (context) {
        String filtro = "";
        return StatefulBuilder(builder: (context, setModalState) {
          final sugerencias = catalogoHorarios
              .where((h) => h["horario"].toString().toLowerCase().contains(filtro.toLowerCase()))
              .toList();
          
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text("Seleccionar Horario"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Ej. 7:00 AM"),
                  onChanged: (val) => setModalState(() => filtro = val),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250, width: 300,
                  child: ListView.builder(
                    itemCount: sugerencias.length,
                    itemBuilder: (ctx, i) => ListTile(
                      title: Text(sugerencias[i]["horario"]),
                      trailing: const Icon(Icons.add_circle, color: Colors.green),
                      onTap: () {
                        setState(() {
                          if (!horariosSeleccionados.contains(sugerencias[i]["horario"])) {
                              horariosSeleccionados.add(sugerencias[i]["horario"]);
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
}

/* import 'package:flutter/material.dart';
import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/asesores_diciplinares_service.dart';

// Modelos auxiliares
class MateriaItem {
  final int id;
  final String nombre;
  MateriaItem({required this.id, required this.nombre});
}

class HorarioItem {
  final int id;
  final String texto;
  HorarioItem({required this.id, required this.texto});
}

class CrearAsesorDisiplinar extends StatefulWidget {
  const CrearAsesorDisiplinar({super.key});

  @override
  State<CrearAsesorDisiplinar> createState() => _CrearAsesorDisiplinarState();
}

class _CrearAsesorDisiplinarState extends State<CrearAsesorDisiplinar> {
  final _formKey = GlobalKey<FormState>();
  final service = AsesoresDiciplinaresService();

  final nombreController = TextEditingController();
  final apellidoPController = TextEditingController();
  final apellidoMController = TextEditingController();
  final cuentaController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();
  final contrasenaController = TextEditingController();

  List<MateriaItem> catalogoMaterias = [];
  List<MateriaItem> materiasSeleccionadas = [];
  List<HorarioItem> catalogoHorarios = [];
  List<HorarioItem> horariosSeleccionados = [];

  @override
  void initState() {
    super.initState();
    _cargarCatalogos();
  }

  void _cargarCatalogos() async {
    final mat = await service.obtenerMaterias();
    final hor = await service.obtenerHorarios();
    setState(() {
      catalogoMaterias = mat;
      catalogoHorarios = hor;
    });
  }

  void _guardarAsesor() async {
    if (!_formKey.currentState!.validate()) return;
    if (materiasSeleccionadas.isEmpty || horariosSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona materias y horarios")),
      );
      return;
    }

    final payload = {
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
      await service.crearAsesor(payload);
      if (!mounted) return;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Asesor creado correctamente"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Error al crear asesor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al crear asesor"),
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
        title: const Text("Crear Asesor Disciplinar", style: TextStyle(fontWeight: FontWeight.bold)),
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
                      _campo(contrasenaController, "Contraseña", dosColumnas, obscure: true),
                      _campo(correoController, "Correo Institucional", dosColumnas, isEmail: true),
                      _campo(telefonoController, "Teléfono", dosColumnas, isPhone: true),
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
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: _guardarAsesor,
                      child: const Text("GUARDAR ASESOR", style: TextStyle(fontWeight: FontWeight.bold)),
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
                      hintText: "Buscar horario",
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
                        final horario = sugerencias[i];
                        return ListTile(
                          title: Text(horario.texto),
                          onTap: () {
                            if (!horariosSeleccionados.any((h) => h.id == horario.id)) {
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
}

 */

