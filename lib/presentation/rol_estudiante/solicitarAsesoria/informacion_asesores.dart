import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class InformacionAsesores extends StatelessWidget {
  const InformacionAsesores({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el objeto pasado por los argumentos
    final asesor = ModalRoute.of(context)!.settings.arguments as dynamic;

    return Scaffold(
      backgroundColor: Appcolores.azulUas,
      appBar: AppBar(
        title: const Text("Información del Asesor"),
        
        
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            
            child: SizedBox(
              width: 400,
              child: Column(
                
                children: [
                  
                  const SizedBox(height: 20),
                  _TarjetaDetalle(titulo: "Nombre", valor: asesor.nombre),
                  _TarjetaDetalle(titulo: "Correo", valor: asesor.correoInstitucional),
                  _TarjetaDetalle(titulo: "Teléfono", valor: asesor.numeroTelefono),
                  _TarjetaDetalle(
                    titulo: "Materias", 
                    valor: asesor.materiasAsesora.join(', ')
                  ),
                  _TarjetaDetalle(
                    titulo: "Horarios Disponibles", 
                    valor: asesor.horariosAsesora.join('\n')
                  ),
                  // Si el asesor tiene licenciatura (Asesor Par), lo mostramos
                  if (asesor.runtimeType.toString().contains('AsesorPar')) ...[
                    _TarjetaDetalle(titulo: "Licenciatura", valor: asesor.licenciatura),
                    _TarjetaDetalle(titulo: "Grupo", valor: asesor.grupo),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para las filas de información
class _TarjetaDetalle extends StatelessWidget {
  final String titulo;
  final String valor;

  const _TarjetaDetalle({required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color.fromARGB(255, 0, 0, 0))),
        subtitle: Text(valor, style: const TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }
}