import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/repository/places/places_repository.dart';

import '../../models/place_autocomplete_model.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutocompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutocompleteLoading());

  @override
  Stream<AutocompleteState> mapEventToState(AutocompleteEvent event) async* {
    if (event is LoadAutocompleteEvent) {
      yield* _mapLoadAutocompleteToState(event);
    }
  }

  Stream<AutocompleteState> _mapLoadAutocompleteToState(
      LoadAutocompleteEvent event) async* {
    _placesSubscription?.cancel();

    final List<PlaceAutocomplete> autocomplete =
        await _placesRepository.getAutocomplete(event.searchInput);

    yield AutocompleteLoaded(autocomplete: autocomplete);
  }
}
