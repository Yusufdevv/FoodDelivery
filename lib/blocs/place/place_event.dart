part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaceEvent extends PlaceEvent {
  final String placeId;
  const LoadPlaceEvent({required this.placeId});

  @override
  List<Object> get props => [];
}
