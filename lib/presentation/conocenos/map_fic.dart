import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaFacultad extends StatelessWidget {
  const MapaFacultad({super.key});

  @override
  Widget build(BuildContext context) {
    final esMovil = MediaQuery.of(context).size.width < 700;

    // ---------- MAPA ---------------

    return Container(
      width: esMovil ? double.infinity : 480,
      height: 220,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(5),
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(24.8230127, -107.3801052),
            initialZoom: 17.1,
          ),
          children: [
            OpenStreetMapTileLater,
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(24.8230127, -107.3801052),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Icon(Icons.location_pin, size: 50, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TileLayer get OpenStreetMapTileLater =>
    TileLayer(urlTemplate: 'https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.asesorias:fic',
    );
