import 'package:asesorias_fic/core/colores.dart';
import 'package:asesorias_fic/data/services/auth_service.dart';
import 'package:asesorias_fic/presentation/conocenos/conocenos.dart';
import 'package:asesorias_fic/presentation/shared/widgets/mensaje_confirmacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';


class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  bool _estaVerificando = true; // Controla la pantalla de carga inicial

  // Instancia 
  final _storage = const FlutterSecureStorage(
    webOptions: WebOptions(dbName: 'AsesoriasFIC', publicKey: 'SecretKeyFIC'),
  );

  @override
  void initState() {
    super.initState();
    _revisarSesionActiva(); // se revisa si hay sesion activa al montar
  }

  Future<void> _revisarSesionActiva() async {
    String? token = await _storage.read(key: "jwt_token");

    if (token != null) {
      print("sesion activa ");
      if (mounted) {
        
        Navigator.pushReplacementNamed(context, '/paginaBaseAdministrador');
      }
    } else {
      if (mounted) {
        setState(() {
          _estaVerificando = false; // No hay sesión, apagamos la carga para mostrar el formulario
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⏳ Mientras la app lee el localStorage, no pintamos los inputs para evitar parpadeos feos
    if (_estaVerificando) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: UasColores.azulOficial),
        ),
      );
    }

    final esMovil = MediaQuery.of(context).size.width < 500;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SeccionArriba(esMovil: esMovil),
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const DraweInicio(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo_inicio.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const ScreenLogin(),
      ),
    );
  }
}

//Dawer - infrmacion de asesorias y tutorias
class DraweInicio extends StatelessWidget {
  const DraweInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 40),
            child: Center(
              child: Text(
                "Informacion",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          const ExpansionTile(
            backgroundColor: Color.fromARGB(71, 36, 74, 145),
            shape: Border.fromBorderSide(BorderSide.none),
            title: Text("Asesoria"),
            children: [
              Padding(padding: EdgeInsets.all(16), child: Text("DAOU")),
            ],
          ),
          const ExpansionTile(
            backgroundColor: Color.fromARGB(71, 36, 74, 145),
            shape: Border.fromBorderSide(BorderSide.none),
            title: Text("Tutoria"),
            children: [
              Padding(padding: EdgeInsets.all(16), child: Text("DAOU")),
            ],
          ),
          const ExpansionTile(
            backgroundColor: Color.fromARGB(71, 36, 74, 145),
            shape: Border.fromBorderSide(BorderSide.none),
            title: Text("Asesor Par"),
            children: [
              Padding(padding: EdgeInsets.all(16), child: Text("DAOU")),
            ],
          ),
          const ExpansionTile(
            backgroundColor: Color.fromARGB(71, 36, 74, 145),
            shape: Border.fromBorderSide(BorderSide.none),
            title: Text("Asesor Diciplinar"),
            children: [
              Padding(padding: EdgeInsets.all(16), child: Text("DAOU")),
            ],
          ),
        ],
      ),
    );
  }
}

//AppBar - container con titulo y logo uas
class SeccionArriba extends StatelessWidget {
  final bool esMovil;

  const SeccionArriba({super.key, required this.esMovil});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF244B91),
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

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final esMovil = MediaQuery.of(context).size.width < 500;

    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionLogin(esMovil: esMovil),
          SeccionFooter(esMovil: esMovil),
        ],
      ),
    );
  }
}

//Contenedor del fprmulario de login
class SeccionLogin extends StatelessWidget {
  final bool esMovil;

  const SeccionLogin({super.key, required this.esMovil});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: esMovil ? 800 : 690,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 80,
          horizontal: 20,
        ),
        child: Center(
          child: Container(
            width: esMovil ? 300 : 380,
            height: esMovil ? 450 : 530,
            constraints: const BoxConstraints(maxWidth: 380),
            padding: EdgeInsets.all(esMovil ? 25 : 40),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  spreadRadius: 4, 
                  blurRadius: 7, 
                  offset: const Offset(0, 0), 
                ),
              ],
            ),
            child: Column(
              children: [
                ImagenLogo(esMovil: esMovil),
                SizedBox(height: esMovil ? 35 : 80),
                const Formulario(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//formulario y validadcion del login
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
            ocultar: false,
            labelTexto: 'No. Cuenta',
            icon: Icons.person,
            colorIcon: Appcolores.azulUas,
            campoController: cuenta,
          ),
          const SizedBox(height: 27),
          InputEstilo(
            ocultar: true,
            labelTexto: 'NIP',
            icon: Icons.lock,
            colorIcon: Appcolores.amarilloUas,
            campoController: nip,
          ),
          const SizedBox(height: 35),
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

// Boton de formulario - INGRESAR conectado al Backend Real con JWT
class BotonIngresar extends StatefulWidget {
  final TextEditingController cuentaController;
  final TextEditingController nipController;
  final GlobalKey<FormState> formKey;

  const BotonIngresar({
    super.key,
    required this.formKey,
    required this.cuentaController,
    required this.nipController,
  });

  @override
  State<BotonIngresar> createState() => _BotonIngresarState();
}

class _BotonIngresarState extends State<BotonIngresar> {
  final AuthService _authService = AuthService();
  bool _cargando = false; 

  @override
  Widget build(BuildContext context) {
    return _cargando
        ? const CircularProgressIndicator() 
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: UasColores.uasAmarillo,
              textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              foregroundColor: Colors.white,
              minimumSize: const Size(160, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              if (!widget.formKey.currentState!.validate()) return;

              setState(() => _cargando = true); 

              final resultado = await _authService.login(
                widget.cuentaController.text, 
                widget.nipController.text,
              );

              setState(() => _cargando = false); 

              if (resultado['success']) {
                MensajeConfirmacion.mostrarMensaje(
                  context,
                  "Se inició sesión correctamente...",
                );

                
                final datosUsuario = await _authService.abrirToken();

                if (datosUsuario != null) {
                  print("---datos del usuario---");
                  print("id: ${datosUsuario.id}");
                  print("rol: ${datosUsuario.idRol}");
                  print("usuario: ${datosUsuario.usuario}");
                  print("nombre usuario: ${datosUsuario.nombreCompleto}");
                }

                if (mounted) {
                 
                  if (datosUsuario?.idRol == 1 || datosUsuario?.idRol == 2) {
                    print("Redirigiendo a Administrador...");
                    Navigator.pushReplacementNamed(context, '/panelAdmin');
                  } 
                 
                  else if (datosUsuario?.idRol == 3 || datosUsuario?.idRol == 5) {
                    print("Redirigiendo a Asesor...");
                    Navigator.pushReplacementNamed(context, '/panelAsesor');
                  } 
                  else if(datosUsuario?.idRol == 4){
                   Navigator.pushReplacementNamed(context, '/panelEstudiante');
                  }
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(resultado['message']),
                    ),
                  );
                }
              }
            },
            child: const Text('INGRESAR'),
          );
  }
}

//Estilo de los campos del formulario - Cuenta y Nip - Estilo de error
class InputEstilo extends StatelessWidget {
  final String labelTexto;
  final IconData icon;
  final Color colorIcon;
  final TextEditingController campoController;
  final bool ocultar;

  const InputEstilo({
    super.key,
    required this.labelTexto,
    required this.icon,
    required this.colorIcon,
    required this.campoController,
    required this.ocultar,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: ocultar,
      controller: campoController,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(icon, color: colorIcon, size: 18),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 240, 240, 240),
        hintText: labelTexto,
        hintStyle: const TextStyle(color: Color(0xFFA8A7A7)),
        floatingLabelBehavior: FloatingLabelBehavior.never,

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 199, 198, 198),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 165, 165, 165),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 239, 91, 91),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 239, 91, 91),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
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

//Seccion de abajo - Contacto - Colaboradores - Logos
class SeccionFooter extends StatelessWidget {
  final bool esMovil;

  const SeccionFooter({super.key, required this.esMovil});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(esMovil ? 25 : 65),
      decoration: const BoxDecoration(
        color: Color(0xFF244B91),
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
          const Padding(
            padding: EdgeInsets.only(bottom: 25, top: 20),
            child: ContenedorLogos(),
          ),
          const InfoDesarolladores(),
          const InfoColaboradores(),
          const InfoContacto(),
          Padding(
            padding: EdgeInsets.only(bottom: esMovil ? 40 : 0),
            child: const InfoCopy(),
          ),
        ],
      ),
    );
  }
}

//Copyright de la facultad - vinculo a la pagina oficial de la FIC
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

//Inofmracion de contacto - correo - vinculo a pagina concocenos - vinculo a politicas
class InfoContacto extends StatelessWidget {
  const InfoContacto({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contacto:",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 13),
          const Correo(),
          const SizedBox(height: 13),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Conocenos()),
              );
            },
            label: const Text(
              "Conocenos",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const Icon(Icons.open_in_new, color: Colors.white, size: 14),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/politicasPrivacidad',
              ); 
            },
            label: const Text(
              "Politicas de privacidad",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const Icon(Icons.open_in_new, color: Colors.white, size: 14),
          ),
        ],
      ),
    );
  }
}

//Correo y logica para abrir el correo predeterminado
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

//Inofrmacion de colaboradores
class InfoColaboradores extends StatelessWidget {
  const InfoColaboradores({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
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
          Text("MC. Evelia Inzunza García", style: TextStyle(color: Colors.white)),
          Text("Dr. Zeus del Valle Castillo Nájera", style: TextStyle(color: Colors.white)),
           Text("Dr. Jose de Jesús Uriarte Adrian", style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}

//Inofrmacion de desarrolladores
class InfoDesarolladores extends StatelessWidget {
  const InfoDesarolladores({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
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

//Logos del footer
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
          const SizedBox(width: 20),
          Image.asset(
            'assets/images/dependencias/lidatfic.png',
            width: MediaQuery.of(context).size.width < 500 ? 45 : 68,
          ),
          const SizedBox(width: 20),
          Image.asset(
            'assets/images/dependencias/bienestar.png',
            width: MediaQuery.of(context).size.width < 500 ? 45 : 88,
          ),
        ],
      ),
    );
  }
}