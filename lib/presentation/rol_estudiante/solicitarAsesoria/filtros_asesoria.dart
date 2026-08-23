import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/catalogos_model.dart';
import 'package:flutter/material.dart';

class FiltrosAsesoria extends StatefulWidget {
  final CatalogosModel? catalogos;

  const FiltrosAsesoria({super.key, this.catalogos});

  @override
  State<FiltrosAsesoria> createState() => _FiltrosAsesoriaState();
}

class _FiltrosAsesoriaState extends State<FiltrosAsesoria> {
  Object? materiaSeleccionadaObj;
  dynamic idMateriaSeleccionada;

  dynamic horarioSeleccionadoObj;
  dynamic idHorarioSeleccionado;

  @override
  Widget build(BuildContext context) {
    // 1. Lista para el Autocomplete de Materias
    final List<Object> materiasList = (widget.catalogos?.materias ?? []).cast<Object>();
    
    // 2. Lista de Horarios (que vienen como lista de mapas/objetos desde backend)
    final List<dynamic> horariosList = widget.catalogos?.horarios ?? [];

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text(
        "Filtros", 
        textAlign: TextAlign.center, 
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. BUSCADOR DE MATERIAS CON AUTOCOMPLETE
            // ==========================================
            const Text("Materia", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Autocomplete<Object>(
              displayStringForOption: (Object option) {
                if (option is Map) return option['materia'] ?? option['nombre'] ?? '';
                return option.toString();
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return materiasList;
                }
                return materiasList.where((Object materia) {
                  String nombreMateria = '';
                  if (materia is Map) {
                    nombreMateria = materia['materia'] ?? materia['nombre'] ?? '';
                  } else {
                    nombreMateria = materia.toString();
                  }
                  return nombreMateria.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (Object selection) {
                setState(() {
                  materiaSeleccionadaObj = selection;
                  if (selection is Map) {
                    idMateriaSeleccionada = selection['id_materia'] ?? selection['id'];
                  }
                });
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 350),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          
                          String nombreMostrar = '';
                          if (option is Map) {
                            nombreMostrar = option['materia'] ?? option['nombre'] ?? '';
                          } else {
                            nombreMostrar = option.toString();
                          }

                          return ListTile(
                            title: Text(nombreMostrar, style: const TextStyle(fontSize: 14)),
                            onTap: () => onSelected(option),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: "Escribe o selecciona materia",
                    prefixIcon: const Icon(Icons.search, size: 18),
                    filled: true,
                    fillColor: const Color(0xFFF2F3F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),

            // ==========================================
            // 2. DESPLEGABLE (DROPDOWN) DE HORARIOS
            // ==========================================
            const Text("Horario", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<dynamic>(
              value: horarioSeleccionadoObj,
              isExpanded: true,
              menuMaxHeight: 200, // Limita la altura del menú para que no ocupe toda la pantalla
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              hint: const Text("Selecciona un horario", style: TextStyle(fontSize: 14, color: Colors.grey)),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF2F3F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), 
                  borderSide: BorderSide.none
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: horariosList.map((e) {
                // Extrae el texto formateado (ej: "7:00-8:00 AM") en lugar del objeto completo
                String textoHorario = '';
                if (e is Map) {
                  textoHorario = e['horario'] ?? e['hora'] ?? e['nombre'] ?? '';
                } else {
                  textoHorario = e.toString();
                }

                return DropdownMenuItem<dynamic>(
                  value: e,
                  child: Text(textoHorario, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  horarioSeleccionadoObj = val;
                  if (val is Map) {
                    idHorarioSeleccionado = val['id_horario'] ?? val['id'];
                  }
                });
              },
            ),
            const SizedBox(height: 30),
            
            // BOTÓN APLICAR FILTROS
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolores.azulUas,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  'id_materia': idMateriaSeleccionada,
                  'materia': materiaSeleccionadaObj != null && materiaSeleccionadaObj is Map 
                      ? (materiaSeleccionadaObj as Map)['materia'] ?? (materiaSeleccionadaObj as Map)['nombre'] 
                      : null,
                  'id_horario': idHorarioSeleccionado,
                  'horario': horarioSeleccionadoObj != null && horarioSeleccionadoObj is Map 
                      ? (horarioSeleccionadoObj as Map)['horario'] ?? (horarioSeleccionadoObj as Map)['hora'] 
                      : null,
                });
              },
              child: const Text("Aplicar Filtros", style: TextStyle(color: Colors.white)),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'id_materia': null, 
                    'materia': null, 
                    'id_horario': null,
                    'horario': null
                  });
                },
                child: const Text("Limpiar filtros", style: TextStyle(color: Colors.grey)),
              ),
            )
          ],
        ),
      ),
    );
  }
}