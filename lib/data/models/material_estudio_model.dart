class MaterialEstudio {
  final String nombre;
  final String tipo; // PDF, DOCX, etc.
  final String url;

  MaterialEstudio({required this.nombre, required this.tipo, required this.url});
}

// Datos de prueba simulando la API
final List<MaterialEstudio> materialesSimulados = [
  MaterialEstudio(nombre: "Guía de Programación I", tipo: "PDF", url: "https://drive.google.com/file/d/1H63xEeSZ1WR7OQQISeg3CIDoXdPEwpaV/view?usp=sharing"),
  MaterialEstudio(nombre: "Ejercicios de Bases de Datos", tipo: "DOCX", url: "https://docs.google.com/document/d/1MRhuJVp170pQcQ5fbuRssIsZizNvy9O7/edit?usp=sharing&ouid=114891694404924852620&rtpof=true&sd=true"),
  MaterialEstudio(nombre: "Manual de Flutter Avanzado", tipo: "PDF", url: "https://drive.google.com/file/d/1H63xEeSZ1WR7OQQISeg3CIDoXdPEwpaV/view?usp=sharing"),
];