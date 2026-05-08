import 'package:asesorias_fic/conocenos/conocenos.dart';
import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';

class LoginNuevo extends StatelessWidget {
  const LoginNuevo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolores.azulFuerte,
      body: ScreenLogin(),
    );
  }
}

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [SeccionArriba(), SeccionLogin(), SeccionFooter()],
      ),
    );
  }
}

class SeccionLogin extends StatelessWidget {
  const SeccionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 690,
      child: Center(
        child: Container(
          width: 380,
          height: 530,
          decoration: BoxDecoration(
            color: const Color.fromARGB(126, 255, 255, 255),
            borderRadius: BorderRadius.circular(15),
          ),

          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 56, right: 11),
                  child: ImagenLogo(),
                ),
              ),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Formulario(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();

  final cuenta = TextEditingController();
  final nip = TextEditingController();

  @override
  void dispose() {
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
          InputEstilo(
            labelTexto: 'No. Cuenta',
            icon: Icons.person,
            colorIcon: Appcolores.azulUas,
            campoController: cuenta,
          ),
          SizedBox(height: 27),
          InputEstilo(
            labelTexto: 'NiP',
            icon: Icons.lock,
            colorIcon: Appcolores.amarilloUas,
            campoController: nip,
          ),
          SizedBox(height: 35),
          BotonIngresar(
            formKey: _formKey,
            cuentaController: cuenta,
            nipController: nip,
          ),
        ],
      ),
    );
  }
}

class BotonIngresar extends StatelessWidget {
  final TextEditingController cuentaController;
  final TextEditingController nipController;

  const BotonIngresar({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.cuentaController,
    required this.nipController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: UasColores.uasAmarillo,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        foregroundColor: Colors.white,
        minimumSize: const Size(170, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      onPressed: () {
        String inputCuenta = cuentaController.text;
        String inputNip = nipController.text;

        if (_formKey.currentState!.validate() &&
            inputCuenta == '12345' &&
            inputNip == '1234') {
          Navigator.pushReplacementNamed(context, '/paginaBaseAdministrador');

          MensajeConfirmacion.mostrarMensaje(
            context,
            "Se inicio sesion correctamente...",
          );
        } else if (_formKey.currentState!.validate() &&
            inputCuenta == '12347' &&
            inputNip == '1236') {
          Navigator.pushReplacementNamed(context, '/paginaBaseEstudiantes');
          MensajeConfirmacion.mostrarMensaje(
            context,
            "Se inicio sesion correctamente...",
          );
        } else if (_formKey.currentState!.validate() &&
            inputCuenta == '12348' &&
            inputNip == '1237') {
          Navigator.pushReplacementNamed(context, '/paginaBaseAsesores');
          MensajeConfirmacion.mostrarMensaje(
            context,
            "Se inicio sesion correctamente...",
          );
        }
      },
      child: Text('INGRESAR'),
    );
  }
}

class InputEstilo extends StatelessWidget {
  final String labelTexto;
  final IconData icon;
  final Color colorIcon;
  final TextEditingController campoController;

  const InputEstilo({
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
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(icon, color: colorIcon, size: 18),
        ),
        filled: true,
        fillColor: Color(0xFFD9D9D9),
        hintText: labelTexto,
        hintStyle: TextStyle(color: Color(0xFFA8A7A7)),
        floatingLabelBehavior: FloatingLabelBehavior.never,

        //Sin enfocar
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 199, 198, 198),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),

        //Enfocando algun input
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 165, 165, 165),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),

        //Cuando se cometa algun error en algun input al presionar ingresar
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 239, 91, 91),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 239, 91, 91),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),

      //Mensaje por si algun campo esta vacio al dar en ingreasr
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Porfavor llene este campo';
        }
        return null;
      },
    );
  }
}

//Widget para el logo del formualrio

class ImagenLogo extends StatelessWidget {
  const ImagenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/images/Logo.png', width: 227));
  }
}

class SeccionArriba extends StatelessWidget {
  const SeccionArriba({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UasColores.uasAmarillo,
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo_uas.png',
              width: 50,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tutorias FIC",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Facultad de Informática Culiacán",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SeccionFooter extends StatelessWidget {
  const SeccionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,

      decoration: BoxDecoration(
        color: Color(0xFF0E0231),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // ← esquina superior izquierda
          topRight: Radius.circular(20), // ← esquina superior derecha
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 65),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContenedorLogos(),
            SizedBox(width: 50),
            InfoDesarolladores(),
            SizedBox(width: 50),
            InfoColaboradores(),
            SizedBox(width: 50),
            InfoContacto(),
            SizedBox(width: 50),
            InfoCopy(),
          ],
        ),
      ),
    );
  }
}

class InfoCopy extends StatelessWidget {
  const InfoCopy({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "© Facultad de Informática Culiacán - 2026",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
          ),
        ],
      ),
    );
  }
}

class InfoContacto extends StatelessWidget {
  const InfoContacto({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contacto:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 13),
          Text("contacto@correo.mx", style: TextStyle(color: Colors.white)),
          SizedBox(height: 13),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Conocenos()),
              );
            },
            label: Text(
              "Conocenos",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: Icon(Icons.open_in_new, color: Colors.white, size: 14),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/politicasPrivacidad',
              ); //Todaavia no agregada
            },
            label: Text(
              "Politicas de privacidad",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: Icon(Icons.open_in_new, color: Colors.white, size: 14),
          ),
        ],
      ),
    );
  }
}

class InfoColaboradores extends StatelessWidget {
  const InfoColaboradores({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Colaboradores:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 13),
          Text(
            "MC. Alejandro Yahir Sicairos Ochoa",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "MGTI. Oscar Mejia Quintero",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class InfoDesarolladores extends StatelessWidget {
  const InfoDesarolladores({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Desarrollado por:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 13),
          Text(
            "Astorga Mejia Jose Angel",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Barrera Rodriguez Leslie Mayram",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Ibarra Meza Raquel del Pilar",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Medina Hernandez Bhrandon Nedel",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Sanchez Barraza Erick Fernando",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Tizoc Lopez Jenifer Guadalupe",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ContenedorLogos extends StatelessWidget {
  const ContenedorLogos({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Image.asset('assets/images/dependencias/logofic.png', width: 70),
          SizedBox(width: 20),
          Image.asset('assets/images/dependencias/lidatfic.png', width: 68),
          SizedBox(width: 20),
          Image.asset('assets/images/dependencias/bienestar.png', width: 88),
        ],
      ),
    );
  }
}
