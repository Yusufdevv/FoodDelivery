
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatelessWidget {
  final double lat;
  final double lng;

  const GMap({
    required this.lat,
    required this.lng,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 12),
    );
  }
}
