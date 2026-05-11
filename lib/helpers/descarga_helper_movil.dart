import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> descargarFormato({
  required String assetPath,
  required String nombreArchivo,
}) async {
  final byteData = await rootBundle.load(assetPath);

  final directorio =
      await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory();

  final ruta = '${directorio.path}/$nombreArchivo';
  final archivo = File(ruta);
  await archivo.writeAsBytes(byteData.buffer.asUint8List());
}
