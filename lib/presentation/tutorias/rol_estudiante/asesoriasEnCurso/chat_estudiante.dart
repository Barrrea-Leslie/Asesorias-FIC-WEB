import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/material.dart';

class ChatEstudiante extends StatelessWidget {
  final String nombreAsesor;
  final VoidCallback onCerrar;

  const ChatEstudiante({super.key, required this.nombreAsesor, required this.onCerrar});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Container(
        width: 350, // Ancho tipo ventana de Facebook
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            // Cabecera Azul
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                color: Appcolores.azulUas,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Chat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(nombreAsesor, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: onCerrar,
                  )
                ],
              ),
            ),
            
            // Cuerpo del Chat (Mensajes)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  _burbujaMensaje("¿Buenas tardes maestro, me podría mandar el link?", false),
                  _burbujaMensaje("Buenas tardes, claro que si ahorita te lo mando", true),
                  _burbujaMensaje("www.zoom.com/j/123456", true),
                  _burbujaMensaje("Muchas gracias maestro", false),
                ],
              ),
            ),

            // Input de Texto
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Escribe...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(icon: const Icon(Icons.send, color: Appcolores.azulUas), onPressed: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _burbujaMensaje(String texto, bool esAsesor) {
    return Align(
      alignment: esAsesor ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: esAsesor ? Colors.grey.shade200 : Appcolores.azulUas,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(texto, style: TextStyle(color: esAsesor ? Colors.black87 : Colors.white)),
      ),
    );
  }
}