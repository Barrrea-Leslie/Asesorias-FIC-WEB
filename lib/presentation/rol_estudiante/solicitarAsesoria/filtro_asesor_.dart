import 'package:flutter/material.dart';
import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';

class FiltroAsesor extends StatefulWidget {
  const FiltroAsesor({super.key});

  @override
  State<FiltroAsesor> createState() => _FiltroAsesorState();
}

//*********        WIDGET DROPDOWN      *************** */
Widget _widgetCampoDropdown({
  required String label,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),

        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF7EDF4),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ],
    ),
  );
}
// ************** WIDGET PARA EL CAMPO DE TEXTO ****************
 Widget _buildLabel(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildTextField(TextEditingController controller, String hint, {bool isEmail = false, bool isPhone = false, bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : (isPhone || isNumber ? TextInputType.number : TextInputType.text),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        border: const OutlineInputBorder(),
      ),
      validator: (val) => val == null || val.isEmpty ? "Campo obligatorio" : null,
    );
  }



class _FiltroAsesorState extends State<FiltroAsesor> {
  List<AsesorDisciplinar> todos = [];
  List<AsesorDisciplinar> resultado = [];

  final List<String> catalogoMaterias = [
    'Programacion I',
    'Programacion II',
    'Principios de programacion',
    'Programacion Web',
    'Bases de Datos',
    'Estructura de Datos',
  ];

  final List<String> grupos = [
    '1-1',
    '1-2',
    '2-1',
    '2-2',
    '3-1',
    '3-2',
    '4-1',
    '4-2',
    '4-3',
  ];

  List<String> modalidades = ['Parcial', 'Virtual', 'Presencial'];

  String? materiaSelecionada;
  String? gruposSelecionado;
  String? modalidadSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filtros',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

               _buildLabel("Nombre Completo"),
                const SizedBox(height: 20),


              /// dropdown materia
              _widgetCampoDropdown(
                label: 'Materia',
                value: materiaSelecionada,
                items: catalogoMaterias,
                onChanged: (value) =>
                    setState(() => materiaSelecionada = value),
              ),

              const SizedBox(height: 30),

              /// dropdown Grupos Escolar
              _widgetCampoDropdown(
                label: 'Grado Escolar',
                value: gruposSelecionado,
                items: grupos,
                onChanged: (value) => setState(() => gruposSelecionado = value),
              ),

              const SizedBox(height: 30),

              /// dropdown Modalidad
              _widgetCampoDropdown(
                label: 'Modalidad',
                value: modalidadSelecionado,
                items: modalidades,
                onChanged: (value) =>
                    setState(() => modalidadSelecionado = value),
              ),

              const SizedBox(height: 30),

              // DATOS FILTRADOS
              Expanded(
                child: resultado.isEmpty
                    ? const Center(child: Text('No hay resultados'))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: resultado.length,
                        itemBuilder: (context, index) {
                          final asesor = resultado[index];
                          return Card(
                            child: ListTile(
                              title: Text(asesor.materiasAsesora.join(',')),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
