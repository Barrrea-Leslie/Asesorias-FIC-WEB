import 'package:flutter/material.dart';
import 'package:asesorias_fic/core/colores.dart';

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
  final TextEditingController materiasController = TextEditingController();
    final TextEditingController horariosController = TextEditingController();

  List<String> materias = [];
  List<String> horarios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Asesor Disiplinar'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),

              //Nombre completo
              const Text(
                "Nombre completo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty
                    ? "Ingresa tu nombre completo"
                    : null,
              ),

              const SizedBox(height: 20),

              //email
              const Text(
                "correo institucional",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa tu email";
                  }
                  if (!value.contains("@")) {
                    return "Email no valido";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              //Telefono
              const Text(
                "Telefono",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: passController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: (value) => value == null || value.length < 10
                    ? "Minimo 10 caracteres"
                    : null,
              ),

              const SizedBox(height: 30),

              //Materias

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Materias que asesora',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolores.verdeClaro,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
              if(materiasController.text.isNotEmpty) {
                setState(() {
                  materias.add(materiasController.text);
                });
              }
            },
            child: const Text('+ Añadir'),
            ),
            ],
            ),

            //campo para ingresar datos de material que asesora
            SizedBox(height: 8),

              TextFormField(
                controller: materiasController,
                decoration: InputDecoration(
                  hintText: 'Ejemplo: Base de Datos',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 8),
            Column(
              children: materias.map((materia) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(materia),
                    TextButton(onPressed: (){
                      setState(() {
                        materias.remove(materia);
                      });
                    },
                    child: const Text('Eliminar',
                    style: TextStyle(color: Appcolores.rojo),
                    ),
                    ),
                  ],
                );
              }).toList(),
              ),

              const SizedBox(height: 30),

              //HORARIOS
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Horarios que asesora',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolores.verdeClaro,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
              if(horariosController.text.isNotEmpty) {
                setState(() {
                  horarios.add(horariosController.text);
                  horariosController.clear();
                });
              }
            }, 
            child: const Text('+ Añadir'),
            ),
            ],
            ),

            //campo para ingresar datos de material que asesora
            SizedBox(height: 8),
              TextFormField(
                controller: horariosController,
                decoration: InputDecoration(
                  hintText: '1:00 - 2:00 pm',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 8),
            Column(
              children: horarios.map((horario) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(horario),
                    TextButton(onPressed: (){
                      setState(() {
                        horarios.remove(horario);
                      });
                    },
                    child: const Text('Eliminar',
                    style: TextStyle(color: Appcolores.rojo),
                    ),
                    ),
                  ],
                );
              }).toList(),
              ),

              const SizedBox(height:30),
        
        //Guardar
              SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                backgroundColor: Appcolores.azulUas,
                foregroundColor: Colors.white,
              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
