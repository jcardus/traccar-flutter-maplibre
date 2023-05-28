import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _Map();
}

class _Map extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return MaplibreMap(
      styleString: const String.fromEnvironment('MAP_STYLE_STRING',
          defaultValue: 'https://api.maptiler.com/maps/basic-v2/style.json?key=c9mafO6rAK56K3BOW5w1'),
      initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
    );
  }
}
