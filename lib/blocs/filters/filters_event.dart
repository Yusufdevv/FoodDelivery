part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class FilterLoadEvent extends FiltersEvent {
  @override
  List<Object> get props => [];
}

class CategoryFilterUpdatedEvent extends FiltersEvent {
  final CategoryFilter categoryFilter;
  
  const CategoryFilterUpdatedEvent({required this.categoryFilter});

  @override
  List<Object> get props => [categoryFilter];
}

class PriceFilterUpdatedEvent extends FiltersEvent {
  final PriceFilter priceFilter;

  const PriceFilterUpdatedEvent({required this.priceFilter});

  @override
  List<Object> get props => [priceFilter];
}
