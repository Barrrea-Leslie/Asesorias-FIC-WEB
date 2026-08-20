import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/helpers/descarga_helper.dart'; // 👈
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CargaNuevoEstudiante extends StatefulWidget {
  const CargaNuevoEstudiante({super.key});

  @override
  State<CargaNuevoEstudiante> createState() => _CargaNuevoEstudianteState();
}

class _CargaNuevoEstudianteState extends State<CargaNuevoEstudiante> {
  String? _nombreArchivo;
  String? _rutaArchivo;

  Future<void> _abrirExplorador() async {
    FilePickerResult? resultado = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (resultado != null && resultado.files.isNotEmpty) {
      setState(() {
        _nombreArchivo = resultado.files.first.name;
        _rutaArchivo = resultado.files.first.path;
      });
    }
  }

  Future<void> _descargarFormato() async {
    try {
      await descargarFormato(
        assetPath: 'assets/formatos/FormatoAlumnos.xlsx',
        nombreArchivo: 'FormatoAlumnos.xlsx',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Descarga iniciada correctamente."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  void _subirArchivo() {
    if (_rutaArchivo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor selecciona un archivo primero."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // await Servicio.subirArchivo(_rutaArchivo!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("¡Archivo subido correctamente!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Sube el archivo XLSX",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),
          const Divider(height: 1),
          const SizedBox(height: 20),

          Container(
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _abrirExplorador,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9D9D9),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text("Examinar..."),
                ),

                const SizedBox(width: 20),

                Flexible(
                  child: Text(
                    _nombreArchivo ?? "No se ha seleccionado archivo",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _nombreArchivo != null
                          ? Colors.black87
                          : Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          TextButton.icon(
            onPressed: _descargarFormato,
            icon: const Icon(Icons.download),
            label: Text(
              "Descargar Formato",
              style: TextStyle(color: UasColores.azulVariableFuerte),
            ),
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Color.fromARGB(255, 157, 157, 157)),
                ),
              ),

              const SizedBox(width: 30),

              ElevatedButton.icon(
                onPressed: _subirArchivo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolores.verdeClaro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text("Subir"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
