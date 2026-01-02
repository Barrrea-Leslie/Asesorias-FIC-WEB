import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class InformacionAsesoresPar extends StatefulWidget {
  const InformacionAsesoresPar({super.key});

  @override
  State<InformacionAsesoresPar> createState() => _InformacionAsesoresParState();
}

class _InformacionAsesoresParState extends State<InformacionAsesoresPar> {
  final _editarformKey = GlobalKey<FormState>();
  
  late TextEditingController nombreController;
  late TextEditingController correoController;
  late TextEditingController telefonoController;

  List<String> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  bool _isInitialized = false;
  late AsesorPar asesorOriginal;

  final List<String> catalogoMaterias = [
    'Programacion I', 'Programacion II', 'Principios de programacion', 
    'Programacion Web', 'Bases de Datos', 'Estructura de Datos'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is AsesorPar) {
        asesorOriginal = args;
        nombreController = TextEditingController(text: asesorOriginal.nombre);
        correoController = TextEditingController(text: asesorOriginal.correoInstitucional);
        telefonoController = TextEditingController(text: asesorOriginal.numeroTelefono);
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
        title: const Text('Información Asesor Par', style: TextStyle(fontWeight: FontWeight.bold)),
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
                        onPressed: () {
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
                        },
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

  // --- MISMOS MÉTODOS DE UI ---
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
          style: ElevatedButton.styleFrom(backgroundColor: Appcolores.verdeClaro, foregroundColor: Colors.white, elevation: 0),
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
