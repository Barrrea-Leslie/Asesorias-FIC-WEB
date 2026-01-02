import 'dart:developer';

import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulFuerte,

      body: Center(child: Center(child: ContenedorLogin())),
    );
  }
}

class ContenedorLogin extends StatelessWidget {
  const ContenedorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    return Container(
      //Estilo y tamaño
      width: 400,
      height: 500,

      decoration: BoxDecoration(
        color: Appcolores.gris,
        borderRadius: BorderRadius.circular(40),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            ImagenLogo(),
            SizedBox(height: 20),
            
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 70),
              child: FormularioLogin(),
            ),
          ],
        ),
      ),
    );
  }
}

//Perzonalizacion del login, se incluyen los inputs y el boton para ingresar

class FormularioLogin extends StatefulWidget {
  const FormularioLogin({super.key});

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _formKey = GlobalKey<FormState>();

  final cuenta = TextEditingController();
  final nip = TextEditingController();

  @override
  void dispose(){
    nip.dispose();
    cuenta.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputStyle(
            labelTexto: 'No. Cuenta',
            icon: Icons.person,
            colorIcon: Appcolores.azulUas,
            campoController: cuenta,
          ),
          SizedBox(height: 12),
          InputStyle(
            labelTexto: 'NiP',
            icon: Icons.lock,
            colorIcon: Appcolores.amarilloUas,
            campoController: nip,
          ),
          SizedBox(height: 25),
          BotonIngresar(formKey: _formKey, cuentaController: cuenta, nipController: nip,),
        ],
      ),
    );
  }
}

//Estilo y funcion de verificacion del boton

class BotonIngresar extends StatelessWidget {

  final TextEditingController cuentaController;
  final TextEditingController nipController;

  const BotonIngresar({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.cuentaController,
    required this.nipController,
  }): _formKey = formKey;

  final GlobalKey<FormState>_formKey;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolores.azulUas,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    
      onPressed: () {

        String inputCuenta = cuentaController.text;
        String inputNip = nipController.text;
        
        if (_formKey.currentState!.validate() && inputCuenta == '12345' && inputNip == '1234') {

          log('Cuenta: ${cuentaController.text}');
          log('NIP: ${nipController.text}');

          

          Navigator.pushReplacementNamed(context, '/paginaBaseAdministrador');

          MensajeConfirmacion.mostrarMensaje(context, "Se inicio secion correctamente...");
        }
      },
      child: Text('Ingresar'),
    );
  }
}

//Widget para perzonalizar una sola vez los inputs y utilizarlo solo agregando los parametros necesarios

class InputStyle extends StatelessWidget {
  final String labelTexto;
  final IconData icon;
  final Color colorIcon;
  final TextEditingController campoController;

  const InputStyle({
    super.key,
    required this.labelTexto,
    required this.icon,
    required this.colorIcon,
    required this.campoController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: campoController,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: colorIcon, size: 18),
        filled: true,
        fillColor: Colors.white,

        //border: OutlineInputBorder(borderSide: BorderSide()),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 199, 198, 198),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 165, 165, 165),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 239, 91, 91),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 239, 91, 91),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        hintText: labelTexto,
        hintStyle: TextStyle(
          color: Color(0xFFb4b4b4),
          fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Porfavor llene este campo';
        }
        return null;
      },
    );
  }
}

class ImagenLogo extends StatelessWidget {
  const ImagenLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.asset(
        'assets/images/fic_logo.png',
        width: 160,
        fit: BoxFit.cover,
      ),
    );
  }
}
