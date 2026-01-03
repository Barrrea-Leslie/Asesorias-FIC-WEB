import 'package:asesorias_fic/data/models/asesores_dicicplinares_model.dart';
import 'package:flutter/material.dart';
import 'package:asesorias_fic/data/repositories/asesores_diciplinares_repository.dart';

//import 'package:asesorias_fic/core/colores.dart';

class FiltrosAsesoria extends StatefulWidget {
  const FiltrosAsesoria({super.key});

  @override
  State<FiltrosAsesoria> createState() => _FiltrosAsesoriaState();
}

class _FiltrosAsesoriaState extends State<FiltrosAsesoria> {
  final AsesoresDiciplinaresRepository _repository =
      AsesoresDiciplinaresRepository();

  List<AsesorDisciplinar> todos = [];
  List<AsesorDisciplinar> resultado = [];

  String? diaSelecionado;
  String? materiaSelecionada;
  String? horarioSelecionado;
  String? modalidadSelecionado;

  final List<String> diaSemana = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
  ];

  final List<String> catalogoMaterias = [
    'Programacion I',
    'Programacion II',
    'Principios de programacion',
    'Programacion Web',
    'Bases de Datos',
    'Estructura de Datos',
  ];
  List<String> horariosAsesora = [];
  List<String> modalidades = ['Parcial', 'Virtual', 'Presencial'];

  //esto extrae los datos desde la BD o donde esten guardados
  Future<void> _cargarDatos() async {
    final data = await _repository.fetchAsesoresDiciplinares();

    setState(() {
      todos = data;
      resultado = data;

      horariosAsesora = data  //<-- estos son los datos que de extrajo de horario que asesora
      .expand((asesor) => asesor.horariosAsesora)
      .toSet()
      .toList();
    });
  }


  @override
  void initState() {
    super.initState();
    _cargarDatos(); //esto carga los datos
  }

  ///////   WIDGET PARA LA BUSQUEDA Y FILTRAR LOS DATOS
  void _filtrarDatos() {
    setState(() {
      resultado = todos.where((asesor) {

    //filtrar datos de  la semana
        //final validarDiaSemana = diaSelecionado == null || asesor.diaSemana.contains(diaSelecionado);
        
        //filtrar datos de  de materia y validarlo
        final validarMateria = materiaSelecionada == null || asesor.materiasAsesora.contains(materiaSelecionada);
        
        //filtrar datos de  de horario 
        final validarHorario = horarioSelecionado == null || asesor.horariosAsesora.contains(horarioSelecionado);
        
        //filtrar modalidad
        //final validarModalidad = modalidadSelecionado == null || asesor.modalidades.contains(modalidadSelecionado);
         
        return validarMateria && validarHorario;
      }).toList();
    });
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              /// dropdown dia de la semana
              _widgetCampoDropdown(
                label: 'Dia de la semana',
                value: diaSelecionado,
                items: diaSemana,
                onChanged: (value) {
                  setState(() => diaSelecionado = value);
                  _filtrarDatos(); // Ejecuta el filtro
                },
              ),

              const SizedBox(height: 30),

              /// dropdown materia
              _widgetCampoDropdown(
                label: 'Materia',
                value: materiaSelecionada,
                items: catalogoMaterias,
                onChanged: (value) {
                  setState(() => materiaSelecionada = value);
                  _filtrarDatos();
                },
              ),

              const SizedBox(height: 30),

              /// dropdown Horario
              _widgetCampoDropdown(
                label: 'Horario',
                value: horarioSelecionado,
                items: horariosAsesora,
                onChanged: (value) {
                  setState(() => horarioSelecionado = value);
                  _filtrarDatos();
                },
              ),

              const SizedBox(height: 30),

              /// dropdown Modalidad
              _widgetCampoDropdown(
                label: 'Modalidad',
                value: modalidadSelecionado,
                items: modalidades,
                onChanged: (value) {
                  setState(() => modalidadSelecionado = value);
                  _filtrarDatos();
                },
              ),

              // ElevatedButton(onPressed: _filtrarDatos, child: const Text('Buscar')),
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
