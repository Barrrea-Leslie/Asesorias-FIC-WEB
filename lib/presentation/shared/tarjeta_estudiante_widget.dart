import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/estudiantes_model.dart';
import 'package:asesorias_fic/data/services/estudiantes_service.dart';
import 'package:asesorias_fic/presentation/rol_administrador/estudiantes/informacion_estudiantes.dart';
import 'package:flutter/material.dart';

class TarjetaEstudianteWidget extends StatelessWidget {
  final String query; 

  const TarjetaEstudianteWidget({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Estudiantes>>(
      future: EstudiantesService().getEstudiantes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los estudiantes'));
        }

        final allEstudiantes = snapshot.data!;
        
        // Lógica de filtrado
        final filteredEstudiantes = allEstudiantes.where((estudiante) {
          final nombre = estudiante.nombre.toLowerCase();
          final search = query.toLowerCase();
          return nombre.contains(search);
        }).toList();

        return ListaEstudiantesWeb(listaEstudiantes: filteredEstudiantes);
      },
    );
  }
}

class ListaEstudiantesWeb extends StatelessWidget {
  const ListaEstudiantesWeb({
    super.key,
    required this.listaEstudiantes,
  });

  final List<Estudiantes> listaEstudiantes;
  final double anchoTarjeta = 360.0;
  final double alturaTarjeta = 100.0;

  void _abrirModalEdicion(BuildContext context, Estudiantes estudiante) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog( // Cambiado a Dialog simple para controlar mejor el tamaño
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 900,
            height: 590, // Ajustado para que quepa todo el formulario
            clipBehavior: Clip.antiAlias, // Para que el contenido respete los bordes redondeados
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: InformacionEstudiantes(estudiante: estudiante),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // Si no hay resultados, mostrar un mensaje
    if (listaEstudiantes.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No se encontraron estudiantes.", style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 20,
            runSpacing: 10,
            children: listaEstudiantes.map((estudiante) {
              return GestureDetector(
                onTap: () => _abrirModalEdicion(context, estudiante),
                child: SizedBox(
                  width: anchoTarjeta,
                  height: alturaTarjeta,
                  child: Card(
                    color: Appcolores.azulUas,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Image.asset('assets/images/foto_icon.png', width: 60),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              estudiante.nombre,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}