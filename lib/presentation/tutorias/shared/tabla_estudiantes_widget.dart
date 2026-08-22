import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/repositories/estudiantes_repository.dart';
import 'package:asesorias_fic/presentation/tutorias/rol_administrador/estudiantes/informacion_estudiantes.dart';
import 'package:flutter/material.dart';

class TablaEstudiantesWidget extends StatelessWidget {
  final String query;

  TablaEstudiantesWidget({super.key, required this.query});

  final EstudiantesRepository repository = EstudiantesRepository();

  void _editarEstudiante(BuildContext context, Estudiantes estudiante) {
    showDialog(
      context: context,
      barrierDismissible: true,

      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          child: Container(
            width: 900,
            height: 590,

            clipBehavior: Clip.antiAlias,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),

            child: InformacionEstudiantes(estudiante: estudiante),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Estudiantes>>(
      future: repository.fetchEstudiantes(),

      builder: (context, snapshot) {
        /// LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ERROR
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar estudiantes'));
        }

        final estudiantes = snapshot.data ?? [];

        /// FILTRO BUSQUEDA
        final filtrados = estudiantes.where((e) {
          return e.nombre.toLowerCase().contains(query.toLowerCase());
        }).toList();

        /// VACIO
        if (filtrados.isEmpty) {
          return const Center(child: Text('No se encontraron estudiantes'));
        }

        return Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: DataTable(
              columnSpacing: 40,

              headingRowColor: WidgetStateProperty.all(Appcolores.azulUas),

              columns: const [
                DataColumn(
                  label: Text(
                    'Nombre',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Grupo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Carrera',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Promedio',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Acciones',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],

              rows: filtrados.map((estudiante) {
                return DataRow(
                  cells: [
                    /// NOMBRE
                    DataCell(Text(estudiante.nombre)),

                    /// CUENTA
                    DataCell(Text(estudiante.numeroCuenta)),

                    /// GRUPO
                    DataCell(Text(estudiante.grupo)),

                    /// CARRERA
                    DataCell(
                      SizedBox(
                        width: 250,

                        child: Text(
                          estudiante.licenciatura,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    /// PROMEDIO
                    DataCell(Text(estudiante.promedio.toString())),

                    /// BOTON EDITAR
                    DataCell(
                      ElevatedButton.icon(
                        onPressed: () {
                          _editarEstudiante(context, estudiante);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolores.azulUas,

                          foregroundColor: Colors.white,
                        ),

                        icon: const Icon(Icons.edit, size: 18),

                        label: const Text('Editar'),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
