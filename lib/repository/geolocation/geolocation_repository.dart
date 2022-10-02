import 'package:geolocator/geolocator.dart';
import 'package:project/repository/geolocation/base_geolocation_repository.dart';

class GeolocationRepository extends BaseGeolocationRepository{

  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  } 
}