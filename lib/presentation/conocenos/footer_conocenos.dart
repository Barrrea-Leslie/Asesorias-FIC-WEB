import 'package:asesorias_fic/presentation/conocenos/map_fic.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//parte de abajo de la pagina FOOTER
class SectionFooterTwo extends StatelessWidget {
  const SectionFooterTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final esMovil = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: esMovil ? 450 : 280),

      decoration: BoxDecoration(color: Color(0xFF08338f)),

      child: Padding(
        padding: EdgeInsets.only(
          left: esMovil ? 20 : 55,
          right: esMovil ? 20 : 55,
          top: 40,
          bottom: 40,
        ),

        child: esMovil
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'Contacto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'Facultad de Informática Culiacán\n'
                        'C. Josefa Ortiz de Domínguez S/N,\n'
                        '80013 Culiacán',
                        style: TextStyle(color: Colors.white, height: 1.5),
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () {
                          _abrirPagina('mailto:sitema@correo.com');
                        },

                        child: const Text(
                          'sitema@correo.com',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          // INSTAGRAM
                          GestureDetector(
                            onTap: () {
                              _abrirPagina(
                                'https://www.instagram.com/facultadinformaticaculiacan/',
                              );
                            },

                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                'assets/images/instagram.png',
                              ),
                            ),
                          ),

                          const SizedBox(width: 20),

                          // FACEBOOK
                          GestureDetector(
                            onTap: () {
                              _abrirPagina(
                                'https://www.facebook.com/FICuliacan/',
                              );
                            },

                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                'assets/images/facebook.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  //------------  AQUI ESTA EL MAPA  *-------------
                  const MapaFacultad(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Text(
                          'Contacto',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Facultad de Informática Culiacán\n'
                          'C. Josefa Ortiz de Domínguez S/N, '
                          'Cd Universitaria,\n'
                          '80013 Culiacán',
                          style: TextStyle(color: Colors.white, height: 1.5),
                        ),

                        const SizedBox(height: 10),

                        GestureDetector(
                          onTap: () {
                            _abrirPagina('mailto:sitema@correo.com');
                          },

                          child: const Text(
                            'sitema@correo.com',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            // INSTAGRAM
                            GestureDetector(
                              onTap: () {
                                _abrirPagina(
                                  'https://www.instagram.com/facultadinformaticaculiacan/',
                                );
                              },

                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  'assets/images/instagram.png',
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            // FACEBOOK
                            GestureDetector(
                              onTap: () {
                                _abrirPagina(
                                  'https://www.facebook.com/FICuliacan/',
                                );
                              },

                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  'assets/images/facebook.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //----------------------   AQUI ESTA EL MAPA   --------------------------
                  const MapaFacultad(),
                ],
              ),
      ),
    );
  }
}

//funcion

Future<void> _abrirPagina(String link) async {
  final Uri uri = Uri.parse(link);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'No se pudo abrir $link';
  }
}
