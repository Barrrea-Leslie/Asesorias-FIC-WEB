import 'dart:html' as html;
import 'package:flutter/services.dart';

Future<void> descargarFormato({
  required String assetPath,
  required String nombreArchivo,
}) async {
  final byteData = await rootBundle.load(assetPath);

  final bytes = byteData.buffer.asUint8List();
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', nombreArchivo)
    ..click();
  html.Url.revokeObjectUrl(url);
}
