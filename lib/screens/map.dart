import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _Map();
}

final icons = <String>[
  'animal',
  'bicycle',
  'boat',
  'bus',
  'car',
  'crane',
  'default',
  'helicopter',
  'motorcycle',
  'offroad',
  'person',
  'pickup',
  'plane',
  'scooter',
  'ship',
  'tractor',
  'train',
  'tram',
  'trolleybus',
  'truck',
  'van'
];

class _Map extends State<Map> {
  MaplibreMapController? controller;

  @override
  Widget build(BuildContext context) {
    return MaplibreMap(
      styleString: const String.fromEnvironment('MAP_STYLE_STRING',
          defaultValue:
              'https://api.maptiler.com/maps/basic-v2/style.json?key=c9mafO6rAK56K3BOW5w1'),
      initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoadedCallback,
    );
  }

  void _onMapCreated(MaplibreMapController controller) {
    this.controller = controller;
    for (var element in icons) {
      addImageFromAsset(element, 'images/icon/$element.svg');
    }
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller!.addImage(name, list);
  }

  void _onStyleLoadedCallback() async {
    await controller?.addGeoJsonSource("points", {
      'type': 'geojson',
      'data': {
        'type': 'FeatureCollection',
        'features': []
      },
    });
    await controller?.addSymbolLayer(
      "points",
      "symbols",
      const SymbolLayerProperties(
          iconImage: '{image}',
          iconAllowOverlap: true,
          textField: '{title}',
          textAllowOverlap: true,
          textAnchor: 'bottom',
          textSize: 12
      ),
    );
  }
}
