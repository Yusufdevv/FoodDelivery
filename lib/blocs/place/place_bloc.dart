import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/models/place_model.dart';
import 'package:project/repository/places/places_repository.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placeSubscription;
  PlaceBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(PlaceLoading());

  @override
  Stream<PlaceState> mapEventToState(PlaceEvent event) async* {
    if (event is LoadPlaceEvent) {
      yield* _mapLoadPlaceToState(event);
    }
  }

  Stream<PlaceState> _mapLoadPlaceToState(LoadPlaceEvent event) async* {
    yield PlaceLoading();
    try {
      _placeSubscription?.cancel();
      final Place place = await _placesRepository.getPlace(event.placeId);
      yield PlaceLoaded(place: place);
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _placeSubscription?.cancel();
    return super.close();
  }
}
