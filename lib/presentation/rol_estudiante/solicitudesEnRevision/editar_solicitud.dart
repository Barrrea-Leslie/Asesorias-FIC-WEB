import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class EditarSolicitud extends StatefulWidget {
  final dynamic solicitud;

  const EditarSolicitud({super.key, required this.solicitud});

  @override
  State<EditarSolicitud> createState() => _EditarSolicitudState();
}

class _EditarSolicitudState extends State<EditarSolicitud> {
  late TextEditingController _fechaController;
  String? _selectedHorario;

  final List<String> _opcionesHorario = [
    '07:00 - 08:00',
    '10:00 - 11:00 AM',
    '11:00 - 12:00 AM',
    '13:00 - 14:00',
    '18:00 - 19:00',
  ];

  @override
  void initState() {
    super.initState();
    _fechaController = TextEditingController(text: widget.solicitud.fecha);
    
    if (_opcionesHorario.contains(widget.solicitud.horario)) {
      _selectedHorario = widget.solicitud.horario;
    } else {
      _opcionesHorario.add(widget.solicitud.horario);
      _selectedHorario = widget.solicitud.horario;
    }
  }

  @override
  void dispose() {
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        // Ancho responsivo
        width: MediaQuery.of(context).size.width * 0.8, 
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        padding: const EdgeInsets.all(20),
        // --- AQUÍ EL SCROLL ---
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Hace que el modal solo use el espacio necesario
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Modificar Solicitud',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const Divider(height: 30),
              
              _buildCampoLectura("Materia", widget.solicitud.materia),
              _buildCampoLectura("Asesor", widget.solicitud.asesor),
              const SizedBox(height: 10),

              const Text("Fecha de Asesoría", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fechaController,
                readOnly: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today, size: 18),
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2027),
                  );
                  if (picked != null) {
                    setState(() {
                      _fechaController.text = "${picked.day}/${picked.month}/${picked.year}";
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              const Text("Horario", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedHorario,
                isExpanded: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.access_time, size: 18),
                  border: OutlineInputBorder()
                ),
                items: _opcionesHorario.map((e) => DropdownMenuItem(
                  value: e, 
                  child: Text(e)
                )).toList(),
                onChanged: (val) => setState(() => _selectedHorario = val),
              ),

              const SizedBox(height: 30),

              // Botón de Cancelación
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    MensajeConfirmacion.mostrarMensaje(context, "Solicitud cancelada");
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('CANCELAR SOLICITUD', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 20),

              // Acciones finales
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cerrar", style: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      MensajeConfirmacion.mostrarMensaje(context, "Cambios guardados");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolores.azulUas,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    ),
                    child: const Text("Guardar Cambios"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampoLectura(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(valor, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}