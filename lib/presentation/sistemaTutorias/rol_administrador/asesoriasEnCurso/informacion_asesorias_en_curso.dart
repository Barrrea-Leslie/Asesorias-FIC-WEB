import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/shared/widgets/mensaje_confirmacion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class InformacionAsesoriaEnCurso extends StatefulWidget {
  final Asesorias asesoria; // Recibe la asesoría directamente
  const InformacionAsesoriaEnCurso({super.key, required this.asesoria});

  @override
  State<InformacionAsesoriaEnCurso> createState() => _InformacionAsesoriaEnCursoState();
}

class _InformacionAsesoriaEnCursoState extends State<InformacionAsesoriaEnCurso> {

  List<Map<String, dynamic>> evidencias = [];
  late Future<List<Estudiantes>> _estudiantesFuture;

  late TextEditingController _nombreController;
  late TextEditingController _licenciaturaController;
  late TextEditingController _sesionesController;
  late TextEditingController _observacionesController;
  late TextEditingController _fechaInicioController;
  //late TextEditingController _fechaFinalController;
  

  String? _selectedGrupo;
  String? _selectedMateria;
  String? _selectedModalidad;
  String? _selectedHorario;
  String? _selectedRazon;


  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _estudiantesFuture = EstudiantesService().getEstudiantes();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _licenciaturaController.dispose();
    _sesionesController.dispose();
    _observacionesController.dispose();
    _fechaInicioController.dispose();
   // _fechaFinalController.dispose();
    super.dispose();
  }

  void _initializeDataOnce(Asesorias asesoria, Estudiantes estudiante) {
    if (_isInitialized) return;

    _nombreController = TextEditingController(text: estudiante.nombre);
    _licenciaturaController = TextEditingController(text: estudiante.licenciatura);
    _sesionesController = TextEditingController(text: "1");
    _observacionesController = TextEditingController(text: "");
    _fechaInicioController = TextEditingController(text: asesoria.fechaInicio);
    //_fechaFinalController = TextEditingController(text: asesoria.fechaFin);

    _selectedGrupo = estudiante.grupo;
    _selectedMateria = asesoria.materia;
    _selectedModalidad = asesoria.modalidad;
    _selectedHorario = asesoria.horario;
    _selectedRazon = asesoria.razon;
    

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 1000),
        child: FutureBuilder<List<Estudiantes>>(
          future: _estudiantesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const SizedBox(height: 100, child: Center(child: Text("Error al cargar datos")));
            }

            final estudiante = snapshot.data!.firstWhere(
              (e) => e.id == widget.asesoria.idEstudiante,
              orElse: () => snapshot.data!.first,
            );

            _initializeDataOnce(widget.asesoria, estudiante);

            return LayoutBuilder(builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 700;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header del Modal
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Información Asesoría',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
                        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Cuerpo con Scroll
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: _buildContenido(),
                    ),
                  ),
                  const Divider(height: 1),
                  // Footer con Botón
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_buildBotonAplicar(context)],
                    ),
                  )
                ],
              );
            });
          },
        ),
      ),
    );
  }

/*   //CONTENIDO NUEVO
  Widget _buildContenido(){
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _buildCampoTextoLectura(
            'Estudiante', 
            _nombreController
            ),

            _buildCampoTextoLectura(
              label, 
              controller)
        ],
      ),
      );
  } */







 /*  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildColumnaIzquierda()),
        const SizedBox(width: 50),
        Expanded(child: _buildColumnaDerecha()),
      ],
    );
  } */

 /*  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildColumnaIzquierda(),
        const SizedBox(height: 20),
        _buildColumnaDerecha(),
      ],
    );
  } */

  Widget _buildContenido() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCampoTextoLectura('Nombre del Estudiante', _nombreController),

          //NOMBRE DEL ASESOR
          _buildCampoTextoLectura('Nombre Asesor',
          TextEditingController(text:'Nombre del asesor'),
           ),

           _buildCampoTextoLectura(
            'Licenciatura del Estudiante', _licenciaturaController,
            ),

          
          _buildCampoDropdownLectura(
              'Grado y Grupo',
              _selectedGrupo,
              ['1-1', '1-2', '2-1', '2-2', '3-1', '3-2', '4-1', '4-2'],
              (val) => setState(() => _selectedGrupo = val)),


          _buildCampoDropdownLectura(
              'Materia',
              _selectedMateria,
              ['Programación', 'Base de Datos', 'Matemáticas Discretas', 'Sistemas Operativos'],
              (val) => setState(() => _selectedMateria = val)),

              _buildCampoDropdownLectura(
                'Horario',
                _selectedHorario,
                [
                 ' 7:00 - 8:00',
                 ' 13:00 - 14:00',
                 ' 18:00 - 19:00',
                ],
                (val) => setState(()  => _selectedHorario = val),
                  ),

                  //MODALIDAD
                   _buildCampoDropdownLectura(
              'Modalidad',
              _selectedModalidad,
              ['Presencial', 'Virtual'],
              (val) => setState(() => _selectedModalidad = val)),

      //FECHA DE INICIO
      _buildCampoTextoLectura(
            'Fecha de Inicio', _fechaInicioController,
            ),

            //RAZON DE ASESORIAS
              _buildCampoDropdownLectura(
              'Razón de Asesoria',
              _selectedRazon,
              ['Dudas', 'Reprobado', 'Reforzamiento'],
              (val) => setState(() => _selectedRazon = val)),

              //SECIONES TOMADAS
              _buildCampoNumero(
                'Sesiones Tomadas', _sesionesController),

                //OBSERVACIONES
              _buildCampoObservaciones(_observacionesController),

              //EVIDENCIAS
            //  _buildSeccionEvidencias(),
        ],
      ),
    );
  }

  /* Widget _buildColumnaDerecha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCampoDropdown('Modalidad', _selectedModalidad,
            ['Presencial', 'Virtual', 'Híbrida'],
            (val) => setState(() => _selectedModalidad = val)),
        _buildCampoDropdown('Horario', _selectedHorario,
            ['07:00 - 08:00', '13:00 - 14:00', '18:00 - 19:00'],
            (val) => setState(() => _selectedHorario = val)),
        const Text('Periodo de Asesoría', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildCampoFecha('Inicio', _fechaInicioController),
            const SizedBox(width: 10),
            _buildCampoFecha('Fin', _fechaFinalController),
          ],
        ),
        const SizedBox(height: 15),
        _buildCampoDropdown('Razón de la Asesoría', _selectedRazon,
            ['Dudas', 'Reprobada', 'Reforzamiento'],
            (val) => setState(() => _selectedRazon = val)),
        _buildCampoNumero('Sesiones Tomadas', _sesionesController),
        const SizedBox(height: 20),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.cloud_upload),
          label: const Text('ADJUNTAR EVIDENCIA (FOTO/PDF)'),
          style: TextButton.styleFrom(foregroundColor: Appcolores.azulUas),
        ),
      ],
    );
  } */

  Widget _buildBotonAplicar(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolores.azulUas,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        MensajeConfirmacion.mostrarMensaje(context, "Cambios aplicados correctamente");
        Navigator.pop(context);
      },
      child: const Text('APLICAR CAMBIOS', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  // --- WIDGETS AUXILIARES (Sin cambios de diseño) ---
  Widget _buildCampoTextoLectura(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),

        TextFormField(controller: controller,
        readOnly: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
            filled:true,
            fillColor: Color(0xfff5f5f5),
          )
        ),
        
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildCampoDropdownLectura(String label, String? currentVal, List<String> opciones, Function(String?) onChanged) {
    if (currentVal != null && !opciones.contains(currentVal)) {
      opciones.insert(0, currentVal);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: currentVal,
          isDense: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: null,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildCampoFecha(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_today, size: 18),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2027),
              );
              if (picked != null) {
                setState(() => controller.text = "${picked.day}/${picked.month}/${picked.year}");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampoNumero(String label, TextEditingController controller) {
    List<String> opciones = List.generate(10, (index) => (index + 1).toString());

    String? currentVal= controller.text.isNotEmpty ? controller.text : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),

        DropdownButtonFormField<String>(
          value: currentVal,
          isDense: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: opciones
          .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
            )).toList(),
          onChanged: (val) {
            setState(() {
              controller.text = val!;
            });
          })
      ]
    );
  }
    
  

  Widget _buildCampoObservaciones(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Observaciones', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe aquí...',
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
  
 /* Widget _buildSeccionEvidencias() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextButton.icon(
          onPressed: _selectedArchivo,
          icon: const Icon(Icons.cloud_upload),
          label: const Text('Adjuntar Evidencia (Foto/PDF)',
          ),
          style: TextButton.styleFrom(
            foregroundColor: Appcolores.azulUas,
          ),
        ),
        const SizedBox(height: 10),

        ...evidencias.map((archivo){
          final bool esPdf = archivo['extension'].toString().toLowerCase() == 'pdf';

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              children: [

                Icon(esPdf ? Icons.picture_as_pdf : Icons.image,
                color: esPdf ? Colors.red : Colors.blue,
                size: 30,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await OpenFile.open(archivo['path'],
                      );
                    },

                    child: Text(archivo['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold,
                    ),
                    ),

                  ),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        evidencias.remove(archivo);
                      });
                    },

                    child: const Text('Eliminar',
                    style: TextStyle(color: Colors.red),
                    ),
                    
                    ),




              ],



            ),
          );
        })
      ],
    );
  }
//metodo para seleccionar un archivo
 Future<void> _selectedArchivo() async{
  FilePickerResult? result =
   await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: [
      'jpg',
      'jpeg',
      'png',
      'pdf',
    ],
  );

  if(result != null) {
    setState(() {
      for( var file in result.files) {
        evidencias.add({
          'name' : file.name,
          'path' : file.path,
          'extension' : file.extension,
        });
      }
    });
  }
 }*/
}

 
