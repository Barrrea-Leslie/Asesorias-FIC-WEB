import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class FiltrosAsesoria extends StatefulWidget {
  const FiltrosAsesoria({super.key});

  @override
  State<FiltrosAsesoria> createState() => _FiltrosAsesoriaState();
}

class _FiltrosAsesoriaState extends State<FiltrosAsesoria> {
  String? diaSeleccionado;
  String? materiaSeleccionada;
  String? horarioSeleccionado;
  String? modalidadSeleccionada;

  final List<String> dias = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'];
  final List<String> materias = ['Programacion I', 'Programacion II', 'Bases de Datos', 'Web'];
  final List<String> horarios = ['7:00 - 8:00', '13:00 - 14:00', '18:00 - 19:00'];
  final List<String> modalidades = ['Parcial', 'Virtual', 'Presencial'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(
        child: Text("Filtros", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      content: SizedBox(
        width: 350,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _widgetCampoDropdown("Dia de la Semana", diaSeleccionado, dias, (v) => setState(() => diaSeleccionado = v)),
              const SizedBox(height: 15),
              _widgetCampoDropdown("Materia", materiaSeleccionada, materias, (v) => setState(() => materiaSeleccionada = v)),
              const SizedBox(height: 15),
              _widgetCampoDropdown("Horario", horarioSeleccionado, horarios, (v) => setState(() => horarioSeleccionado = v)),
              const SizedBox(height: 15),
              _widgetCampoDropdown("Modalidad", modalidadSeleccionada, modalidades, (v) => setState(() => modalidadSeleccionada = v)),
              const SizedBox(height: 30),
              
              // CONTENEDOR DE BOTONES
              Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolores.azulUas,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.pop(context, {
                          'dia': diaSeleccionado,
                          'materia': materiaSeleccionada,
                          'horario': horarioSeleccionado,
                          'modalidad': modalidadSeleccionada,
                        });
                      },
                      child: const Text("Aplicar Filtros", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // OPCIÓN PARA MOSTRAR TODO
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          diaSeleccionado = null;
                          materiaSeleccionada = null;
                          horarioSeleccionado = null;
                          modalidadSeleccionada = null;
                        });
                        // Cerramos devolviendo todo null para que la lista se limpie
                        Navigator.pop(context, {
                          'dia': null,
                          'materia': null,
                          'horario': null,
                          'modalidad': null,
                        });
                      },
                      child: const Text(
                        "Mostrar todo / Limpiar filtros",
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetCampoDropdown(
    String label,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged
    ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: const Text("Seleccionar", style: TextStyle(fontSize: 14, color: Colors.grey)),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE9E9E9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}