import 'package:asesorias_fic/presentation/conocenos/conocenos.dart';
import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final esMovil = MediaQuery.of(context).size.width < 500;

    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionArriba(esMovil: esMovil),
          SeccionLogin(esMovil: esMovil),
          SeccionFooter(esMovil: esMovil),
        ],
      ),
    );
  }
}

class SeccionLogin extends StatelessWidget {
  final bool esMovil;

  const SeccionLogin({super.key, required this.esMovil});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: esMovil ? 800 : 690,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: esMovil ? 80 : 80,
          horizontal: 20,
        ),
        child: Center(
          child: Container(
            width: esMovil ? 300 : 380,
            height: esMovil ? 450 : 530,
            constraints: const BoxConstraints(maxWidth: 380),
            padding: EdgeInsets.all(esMovil ? 25 : 40),
            decoration: BoxDecoration(
              color: const Color.fromARGB(126, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ImagenLogo(esMovil: esMovil),
                SizedBox(height: esMovil ? 35 : 80),
                Formulario(),
              ],
            ),
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
  const ImagenLogo({super.key, required this.esMovil});

  final bool esMovil;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/Logo.png', width: esMovil ? 200 : 227),
    );
  }
}

class SeccionArriba extends StatelessWidget {
  final bool esMovil;

  const SeccionArriba({super.key, required this.esMovil});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UasColores.uasAmarillo,
      width: double.infinity,
      height: esMovil ? 84 : 70,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: esMovil ? 35 : 90,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo_uas.png',
            width: esMovil ? 40 : 50,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Text(
                "Tutorias FIC",
                style: TextStyle(
                  fontSize: esMovil ? 17 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Facultad de Informática Culiacán",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: esMovil ? 14 : 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SeccionFooter extends StatelessWidget {
  final bool esMovil;

  const SeccionFooter({super.key, required this.esMovil});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(esMovil ? 25 : 65),
      decoration: const BoxDecoration(
        color: Color(0xFF0E0231),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: esMovil ? 20 : 50,
        runSpacing: 25,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25, top: 20),
            child: ContenedorLogos(),
          ),
          InfoDesarolladores(),
          InfoColaboradores(),
          InfoContacto(),
          Padding(
            padding: EdgeInsets.only(bottom: esMovil ? 40 : 0),
            child: InfoCopy(),
          ),
        ],
      ),
    );
  }
}

class InfoCopy extends StatefulWidget {
  const InfoCopy({super.key});

  @override
  State<InfoCopy> createState() => _InfoCopyState();
}

class _InfoCopyState extends State<InfoCopy> {
  bool isHovering = false;

  Future<void> _abrirPagina() async {
    final Uri url = Uri.parse('https://fic.uas.edu.mx/');

    if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
      throw Exception('No se pudo abrir la página');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => isHovering = true),
            onExit: (_) => setState(() => isHovering = false),
            child: InkWell(
              onTap: _abrirPagina,
              child: Text(
                "© Facultad de Informática Culiacán - 2026",
                style: TextStyle(
                  color: isHovering ? UasColores.uasAmarillo : Colors.white,
                  fontWeight: FontWeight.w100,
                  decoration: isHovering
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
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
          Correo(),
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

class Correo extends StatefulWidget {
  const Correo({super.key});

  @override
  State<Correo> createState() => _CorreoState();
}

class _CorreoState extends State<Correo> {
  bool isHovering = false;

  Future<void> _abrirCorreo() async {
    final Uri email = Uri(
      scheme: 'mailto',
      path: 'contacto@correo.mx',
      queryParameters: {'subject': 'Solicitud de información'},
    );

    if (!await launchUrl(email)) {
      throw Exception('No se pudo abrir el correo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: InkWell(
        onTap: _abrirCorreo,
        child: Text(
          "contacto@correo.mx",
          style: TextStyle(
            color: isHovering ? UasColores.uasAmarillo : Colors.white,
            decoration: TextDecoration.underline,
          ),
        ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/dependencias/logofic.png',
            width: MediaQuery.of(context).size.width < 500 ? 45 : 70,
          ),
          SizedBox(width: 20),
          Image.asset(
            'assets/images/dependencias/lidatfic.png',
            width: MediaQuery.of(context).size.width < 500 ? 45 : 68,
          ),
          SizedBox(width: 20),
          Image.asset(
            'assets/images/dependencias/bienestar.png',
            width: MediaQuery.of(context).size.width < 500 ? 45 : 88,
          ),
        ],
      ),
    );
  }
}
