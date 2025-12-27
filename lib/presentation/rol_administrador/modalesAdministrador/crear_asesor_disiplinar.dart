import 'package:flutter/material.dart';

class CrearAsesorDisiplinar extends StatefulWidget {
  const CrearAsesorDisiplinar({super.key});

  @override
  State<CrearAsesorDisiplinar> createState() => _CrearAsesorDisiplinarState();
}

class _CrearAsesorDisiplinarState extends State<CrearAsesorDisiplinar> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Asesor Disiplinar')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: "Nombre Completo",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ingresa tu nombre completo" : null,
              ),

              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Ingresa tu email";
                  if (value.contains("@")) return "Email no valido";
                  return null;
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Numero Telefonico",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.length < 10 ? "Minimo 6 caracteres" : null,
              ),

              SizedBox(height: 30),
              ElevatedButton(
                child: Text("Guardar"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "usuario registrado: ${nombreController.text}",
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
