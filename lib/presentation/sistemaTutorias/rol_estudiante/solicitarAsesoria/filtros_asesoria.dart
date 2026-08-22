import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class FiltrosAsesoria extends StatefulWidget {
  const FiltrosAsesoria({super.key});

  @override
  State<FiltrosAsesoria> createState() => _FiltrosAsesoriaState();
}

class _FiltrosAsesoriaState extends State<FiltrosAsesoria> {
  String? materiaSeleccionada;
  String? horarioSeleccionado;

  // ESTAS LISTAS AHORA COINCIDEN EXACTAMENTE CON TU JSON
  final List<String> materias = [
    'Introducción a la programacion',
    'Matemáticas I',
    'Matemáticas II',
    'Programación I',
    'Programación II',
    'Estructuras de Datos',
    'Bases de Datos',
    'Ingeniería de Software',
    'Redes',
    'Proyecto Integrador'
  ];

  final List<String> horarios = [
    '7:00 - 8:00 AM',
    '9:00 - 10:00 AM',
    '10:00 - 11:00 AM',
    '11:00 - 12:00 PM',
    '12:00 - 1:00 PM',
    '12:00 - 13:00 PM',
    '1:00 - 2:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text("Filtros", 
        textAlign: TextAlign.center, 
        style: TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _widgetCampoDropdown("Materia", materiaSeleccionada, materias, (v) {
              setState(() => materiaSeleccionada = v);
            }),
            const SizedBox(height: 15),
            _widgetCampoDropdown("Horario", horarioSeleccionado, horarios, (v) {
              setState(() => horarioSeleccionado = v);
            }),
            const SizedBox(height: 30),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolores.azulUas,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  'materia': materiaSeleccionada,
                  'horario': horarioSeleccionado,
                });
              },
              child: const Text("Aplicar Filtros", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, {'materia': null, 'horario': null});
              },
              child: const Text("Limpiar filtros", style: TextStyle(color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetCampoDropdown(String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF2F3F5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}