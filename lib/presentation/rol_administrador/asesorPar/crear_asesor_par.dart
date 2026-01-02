import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesores_par_model.dart';
import 'package:asesorias_fic/data/repositories/asesores_par_repository.dart';
import 'package:flutter/material.dart';

class CrearAsesoresPar extends StatefulWidget {
  const CrearAsesoresPar({super.key});

  @override
  State<CrearAsesoresPar> createState() => _CrearAsesoresParState();
}

class _CrearAsesoresParState extends State<CrearAsesoresPar> {
  final _formKey = GlobalKey<FormState>();
  final AsesoresParRepository _repository = AsesoresParRepository();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  List<String> materiasSeleccionadas = [];
  List<String> horariosSeleccionados = [];

  final List<String> catalogoMaterias = [
    'Programacion I', 'Programacion II', 'Principios de programacion', 
    'Programacion Web', 'Bases de Datos', 'Estructura de Datos'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crear Asesor Par', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
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
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolores.azulUas,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    onPressed: _guardarAsesor,
                    child: const Text("GUARDAR ASESOR PAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardarAsesor() async {
    if (_formKey.currentState!.validate()) {
      // Nota: Aquí el ID y otros campos son temporales/simulados para el modelo
      final nuevoAsesor = AsesorPar(
        id: DateTime.now().millisecondsSinceEpoch,
        nombre: nombreController.text,
        numeroCuenta: "00000000", 
        licenciatura: "Informatica",
        grupo: "Sin grupo",
        correoInstitucional: correoController.text,
        numeroTelefono: telefonoController.text,
        promedio: 0.0,
        materiasAsesora: materiasSeleccionadas,
        horariosAsesora: horariosSeleccionados,
      );

      // Asegúrate de tener registrarAsesor en tu AsesoresParRepository
      // bool exito = await _repository.registrarAsesor(nuevoAsesor);
      
      Navigator.pop(context, nuevoAsesor);
    }
  }

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