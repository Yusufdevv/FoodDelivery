import 'dart:convert' as convert;

import 'package:project/models/place_model.dart';
import 'package:project/models/place_autocomplete_model.dart';
import 'package:project/repository/places/base_places_repository.dart';
import 'package:http/http.dart' as http;

class PlacesRepository extends BasePlacesRepository {
  final String key = 'AIzaSyDvVXsV-hVfW5EZngaWN8BsZR3CdZCHarA';
  final String types = 'geocode';

  @override
  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['predictions'] as List;

    return results.map((place) => PlaceAutocomplete.fromJson(place)).toList();
  }

  @override
  Future<Place> getPlace(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    return Place.fromJson(results);
  }
}
