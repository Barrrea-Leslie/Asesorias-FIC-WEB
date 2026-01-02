import 'package:flutter/material.dart';
//import 'package:asesorias_fic/core/colores.dart';

class FiltrosAsesoria extends StatefulWidget {
  const FiltrosAsesoria({super.key});

  @override
  State<FiltrosAsesoria> createState() => _FiltrosAsesoriaState();
}

class _FiltrosAsesoriaState extends State<FiltrosAsesoria> {

final List<String>semana = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'];
final List<String>materia = ['Programacion'];
final List<String>horario = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'];
final List<String>modalidad = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtros', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          ),
      ),
    );
/*  */
 /*  DropdownMenu(
    dropdownMenuEntries: <DropdownMenuEntry<String>>[
      DropdownMenuEntry(value: value, label: label)
    
  ],); */
  
  

  }
}