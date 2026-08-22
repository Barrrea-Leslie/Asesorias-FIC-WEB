import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/sistemaTutorias/shared/tabla_estudiantes_widget.dart';
import 'package:flutter/material.dart';

class PantallaEstudiantes extends StatefulWidget {
  const PantallaEstudiantes({super.key});

  @override
  State<PantallaEstudiantes> createState() => _PantallaEstudiantesState();
}

class _PantallaEstudiantesState extends State<PantallaEstudiantes> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulUas,

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'Estudiantes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      width: 300,

                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            query = value;
                          });
                        },

                        decoration: InputDecoration(
                          hintText: 'Buscar estudiante',

                          prefixIcon: const Icon(Icons.search),

                          filled: true,

                          fillColor: const Color(0xFFF5F5F5),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// TABLA
              Expanded(child: TablaEstudiantesWidget(query: query)),
            ],
          ),
        ),
      ),
    );
  }
}
