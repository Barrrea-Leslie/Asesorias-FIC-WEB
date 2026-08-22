import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/models/material_estudio_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importante para la "descarga"

class MaterialAdicionalAsesorias extends StatelessWidget {
  final String nombreAsesor;

  const MaterialAdicionalAsesorias({super.key, required this.nombreAsesor});

  // Función para simular descarga abriendo el link
  Future<void> _descargarArchivo(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('No se pudo abrir el archivo $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Column(
        children: [
          
          const SizedBox(height: 10),
          Text("Material de $nombreAsesor", 
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 15,),
          const Divider(height: 1),
        ],
      ),
      content: SizedBox(
        width: 400,
        height: 300,
        child: ListView.builder(
          itemCount: materialesSimulados.length,
          itemBuilder: (context, index) {
            final material = materialesSimulados[index];
            return Card(
              color: const Color.fromARGB(203, 255, 255, 255),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: Icon(
                  material.tipo == "PDF" ? Icons.picture_as_pdf : Icons.description,
                  color: material.tipo == "PDF" ? Colors.red : Colors.blue,
                ),
                title: Text(material.nombre, style: const TextStyle(fontSize: 14)),
                subtitle: Text(material.tipo),
                trailing: IconButton(
                  icon: const Icon(Icons.download, color: Appcolores.amarilloUas),
                  onPressed: () => _descargarArchivo(material.url),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cerrar", style: TextStyle(color: Colors.grey)),
        )
      ],
    );
  }
}