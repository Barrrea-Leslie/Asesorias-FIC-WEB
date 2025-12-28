//import 'package:asesorias_fic/presentation/rol_administrador/asesores_diciplinares.dart';
import 'package:flutter/material.dart';
import 'package:asesorias_fic/models/asesores_dicplinares.dart';
import 'package:asesorias_fic/core/colores.dart';

class EditarAsesorDisiplinar extends StatefulWidget {
  final AsesoresDicplinares asesor; //este recibe loos datos de la anterior pantalla que es: que es: crear_asesor_disiplinar.dart

  const EditarAsesorDisiplinar({
    super.key, 
    required this.asesor});

  @override
  State<EditarAsesorDisiplinar> createState() => _EditarAsesorDisiplinarState();
}

class _EditarAsesorDisiplinarState extends State<EditarAsesorDisiplinar> {
  final _editarformKey = GlobalKey<FormState>();

  late TextEditingController nombreController;
  late TextEditingController correoInstiticionalController;
  late TextEditingController numTelefonoController;

  @override
  void initState() {
    super.initState();

    nombreController = TextEditingController(text: widget.asesor.nombre);
    correoInstiticionalController = TextEditingController(
      text: widget.asesor.correoInstitucional,
    );
    numTelefonoController = TextEditingController(
      text: widget.asesor.numeroTelefono,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Información Asesor'),
      centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _editarformKey,
          child: Column(
            children: [
              // Nombre
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre completo",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Campo obligatorio" : null,
              ),

              const SizedBox(height: 20),

              // Teléfono
              TextFormField(
                controller: numTelefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Número telefónico",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.length < 10 ? "Mínimo 10 caracteres" : null,
              ),

              const SizedBox(height: 20),

              // Correo
              TextFormField(
                controller: correoInstiticionalController,
                decoration: const InputDecoration(
                  labelText: "Correo institucional",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || !v.contains("@") ? "Correo inválido" : null,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolores.azulUas,
                    foregroundColor: Colors.white,
                  ),
                onPressed: () {
                  if (_editarformKey.currentState!.validate()) {
                    final asesorActualizado = AsesoresDicplinares(
                      id: widget.asesor.id,
                      numeroCuenta: widget.asesor.numeroCuenta,
                      nombre: nombreController.text,
                      licenciatura: widget.asesor.licenciatura,
                      grupo: widget.asesor.grupo,
                      correoInstitucional: correoInstiticionalController.text,
                      numeroTelefono: numTelefonoController.text,
                      promedio: widget.asesor.promedio,
                    );

                    Navigator.pop(context, asesorActualizado);
                  }
                },
                child: const Text("Aplicar cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
