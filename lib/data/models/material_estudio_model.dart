class MaterialEstudio {
  final String nombre;
  final String tipo; // PDF, DOCX, etc.
  final String url;

  MaterialEstudio({required this.nombre, required this.tipo, required this.url});
}

// Datos de prueba simulando la API
final List<MaterialEstudio> materialesSimulados = [
  MaterialEstudio(nombre: "Guía de Programación I", tipo: "PDF", url: "https://drive.google.com/file/d/1qg9KWKAhKpglAMID2DGB_lm2pQCLNUNO/view?usp=sharing"),
  MaterialEstudio(nombre: "Ejercicios de Bases de Datos", tipo: "DOCX", url: "https://drive.google.com/file/d/1qg9KWKAhKpglAMID2DGB_lm2pQCLNUNO/view?usp=sharing"),
  MaterialEstudio(nombre: "Manual de Flutter Avanzado", tipo: "PDF", url: "https://drive.google.com/file/d/1qg9KWKAhKpglAMID2DGB_lm2pQCLNUNO/view?usp=sharing"),
];