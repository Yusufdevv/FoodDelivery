part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class LoadFilter extends FiltersEvent {
  @override
  List<Object> get props => [];
}

class UpdateCategoryFilter extends FiltersEvent {
  final CategoryFilter categoryFilter;

  const UpdateCategoryFilter({required this.categoryFilter});

  @override
  List<Object> get props => [categoryFilter];
}

class UpdatePriceFilter extends FiltersEvent {
  final PriceFilter priceFilter;

  const UpdatePriceFilter({required this.priceFilter});

  @override
  List<Object> get props => [priceFilter];
}
