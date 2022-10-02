part of 'autocomplete_bloc.dart';

abstract class AutocompleteEvent extends Equatable {
  const AutocompleteEvent();

  @override
  List<Object> get props => [];
}

class LoadAutocompleteEvent extends AutocompleteEvent {
  final String searchInput;

  const LoadAutocompleteEvent({this.searchInput = ''});

  @override
  List<Object> get props => [searchInput];
}
