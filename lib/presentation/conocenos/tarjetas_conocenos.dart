import 'package:flutter/material.dart';


Widget tarjetita(String titulo, String contenido) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: AnimatedContainer(
      duration: const Duration(
        milliseconds: 300),
        curve: Curves.easeInOut,

        width: 350,
        height: 320,

        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),

        decoration: BoxDecoration(
          color: const Color(0xFFE7E7E7).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),

          

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0,4),
            )
          ],
        ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            // Título
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
           const SizedBox(height: 15),


//contenido
           Expanded(child: Center(
            
              child: Text(
                contenido,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
           ),
           
            
        ],
        
          )
          

        ),
        
        
  );
}