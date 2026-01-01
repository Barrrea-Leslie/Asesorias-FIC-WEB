import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/asesorias_model.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:flutter/material.dart';

class InformacionAsesoriaEnCurso extends StatefulWidget {
  const InformacionAsesoriaEnCurso({super.key});

  @override
  State<InformacionAsesoriaEnCurso> createState() => _InformacionAsesoriaEnCursoState();
}

class _InformacionAsesoriaEnCursoState extends State<InformacionAsesoriaEnCurso> {
  // 1. Future para cargar datos solo una vez
  late Future<List<Estudiantes>> _estudiantesFuture;

  // 2. Controladores para campos de texto, números, fechas y observaciones
  late TextEditingController _nombreController;
  late TextEditingController _licenciaturaController;
  late TextEditingController _sesionesController;
  late TextEditingController _observacionesController;
  late TextEditingController _fechaInicioController;
  late TextEditingController _fechaFinalController;

  // 3. Variables de estado para los Dropdowns
  String? _selectedGrupo;
  String? _selectedMateria;
  String? _selectedModalidad;
  String? _selectedHorario;
  String? _selectedRazon;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Iniciamos la petición al abrir la página
    _estudiantesFuture = EstudiantesService().getEstudiantes();
  }

  @override
  void dispose() {
    // Es importante liberar los controladores al cerrar la pantalla
    _nombreController.dispose();
    _licenciaturaController.dispose();
    _sesionesController.dispose();
    _observacionesController.dispose();
    _fechaInicioController.dispose();
    _fechaFinalController.dispose();
    super.dispose();
  }

  // 4. Inicialización de datos con los valores actuales de los modelos
  void _initializeDataOnce(Asesorias asesoria, Estudiantes estudiante) {
    if (_isInitialized) return;

    _nombreController = TextEditingController(text: estudiante.nombre);
    _licenciaturaController = TextEditingController(text: estudiante.licenciatura);
    _sesionesController = TextEditingController(text: "1"); // Valor inicial ejemplo
    _observacionesController = TextEditingController(text: ""); // Puedes poner asesoria.observaciones si existe

    _fechaInicioController = TextEditingController(text: asesoria.fechaInicio);
    _fechaFinalController = TextEditingController(text: asesoria.fechaFin);

    _selectedGrupo = estudiante.grupo;
    _selectedMateria = asesoria.materia;
    _selectedModalidad = asesoria.modalidad;
    _selectedHorario = asesoria.horario;
    _selectedRazon = asesoria.razon;

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    
    final args = ModalRoute.of(context)?.settings.arguments;

    // 2. Verificamos si los argumentos son nulos o no son del tipo esperado
    if (args == null || args is! Asesorias) {
      return Scaffold(
        appBar: AppBar(
        title: const Text('Error de datos'),
        // AGREGAR FLECHA AQUÍ
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/paginaBase'); // Regresa a la página de asesorías
          },
        ),
      ),
        body: const Center(
          child: Text('No se recibió la información de la asesoría. Por favor, regresa e intenta de nuevo.'),
        ),
      );
    }

    // 3. Si todo está bien, ya podemos usarlo con seguridad
    final asesoria = args;

    return Scaffold(
      appBar: AppBar(title: const Text('Información Asesoría')),
      body: FutureBuilder<List<Estudiantes>>(
        future: _estudiantesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Error al cargar datos del estudiante"));
          }

          final estudiante = snapshot.data!.firstWhere(
            (e) => e.id == asesoria.idEstudiante,
            orElse: () => snapshot.data!.first, // Evita error si no encuentra el ID
          );

          _initializeDataOnce(asesoria, estudiante);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// PANEL IZQUIERDO: IMAGEN
                Container(
                  width: 150,
                  height: 670,
                  decoration: BoxDecoration(
                    color: Appcolores.azulUas,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset('assets/images/cargarImagen.png', fit: BoxFit.contain),
                  ),
                ),

                const SizedBox(width: 20),

                /// PANEL DERECHO: FORMULARIO
                SizedBox(
                  width: 600,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: [
                            _buildCampoTexto('Estudiante', _nombreController),
                            _buildCampoTexto('Licenciatura', _licenciaturaController),
                      
                            _buildCampoDropdown('Grupo', _selectedGrupo, 
                              ['1-1', '1-2', '2-1', '2-2', '3-1', '3-2', '4-1', '4-2'], 
                              (val) => setState(() => _selectedGrupo = val)),
                      
                            _buildCampoDropdown('Materia', _selectedMateria, 
                              ['Programación', 'Base de Datos', 'Matemáticas Discretas', 'Sistemas Operativos', 'Inteligencia Artificial'], 
                              (val) => setState(() => _selectedMateria = val)),
                      
                            _buildCampoDropdown('Modalidad', _selectedModalidad, 
                              ['Presencial', 'Virtual', 'Híbrida'], 
                              (val) => setState(() => _selectedModalidad = val)),
                      
                            _buildCampoDropdown('Horario', _selectedHorario, 
                              ['07:00 - 08:00', '13:00 - 14:00', '18:00 - 19:00', '19:00 - 20:00'], 
                              (val) => setState(() => _selectedHorario = val)),
                      
                            const SizedBox(height: 20),
                      
                            Row(
                              children: [
                                _buildCampoFecha('Fecha Inicio', _fechaInicioController),
                                const SizedBox(width: 10),
                                _buildCampoFecha('Fecha Final', _fechaFinalController),
                              ],
                            ),
                      
                            const SizedBox(height: 20),
                      
                            _buildCampoDropdown('Razón', _selectedRazon, 
                              ['Dudas en la materia', 'Materia reprobada', 'Reforzamiento', 'Preparación para examen'], 
                              (val) => setState(() => _selectedRazon = val)),
                      
                            const SizedBox(height: 20),
                            _buildCampoNumero('Número de sesiones tomadas', _sesionesController),
                      
                            const SizedBox(height: 20),
                            _buildCampoObservaciones(_observacionesController),
                      
                            const SizedBox(height: 20),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.cloud_upload),
                              label: const Text('SUBIR EVIDENCIA'),
                            ),
                      
                            const SizedBox(height: 30),
                      
                            /// BOTÓN APLICAR CAMBIOS
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolores.azulUas,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                ),
                                onPressed: () {
                                  // 1. Mostrar mensaje de éxito
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Cambios aplicados correctamente'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                      
                                  // 2. Regresar a la pantalla anterior
                                  Navigator.pop(context);
                                },
                                child: const Text('Aplicar Cambios'),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- WIDGETS AUXILIARES REUTILIZABLES ---

  Widget _buildCampoTexto(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(controller: controller),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildCampoDropdown(String label, String? currentVal, List<String> opciones, Function(String?) onChanged) {
    // Si el valor actual no está en la lista de opciones, lo agregamos para evitar errores de Flutter
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
          onChanged: onChanged,
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
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2026),
              );
              if (picked != null) {
                setState(() {
                  controller.text = "${picked.day}/${picked.month}/${picked.year}";
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampoNumero(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          width: 100,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
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
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe aquí tus observaciones...',
          ),
        ),
      ],
    );
  }
}