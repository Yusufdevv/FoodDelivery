import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/models/models.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersLoading());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is FilterLoadEvent) {
      yield* _mapFilterLoadEventToState();
    }
    if (event is CategoryFilterUpdatedEvent) {
      yield* _mapCategoryFilterUpdatedEventToState(event, state);
    }
    if (event is PriceFilterUpdatedEvent) {
      yield* _mapPriceFilterUpdatedEventToState(event, state);
    }
  }

  Stream<FiltersState> _mapFilterLoadEventToState() async* {
    yield FiltersLoaded(
        filter: Filter(
            categoryFilters: CategoryFilter.filters,
            priceFilters: PriceFilter.filters));
  }

  Stream<FiltersState> _mapCategoryFilterUpdatedEventToState(
      CategoryFilterUpdatedEvent event, FiltersState state) async* {
    if (state is FiltersLoaded) {
      final List<CategoryFilter> updateCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();
      yield FiltersLoaded(
          filter: Filter(
              categoryFilters: updateCategoryFilters,
              priceFilters: state.filter.priceFilters));
    }
  }

  Stream<FiltersState> _mapPriceFilterUpdatedEventToState(
      PriceFilterUpdatedEvent event, FiltersState state) async* {
    if (state is FiltersLoaded) {
      final List<PriceFilter> updatePriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();
      yield FiltersLoaded(
          filter: Filter(
              categoryFilters: state.filter.categoryFilters,
              priceFilters: updatePriceFilters));
    }
  }
}
