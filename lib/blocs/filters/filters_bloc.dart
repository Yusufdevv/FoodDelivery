import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/models/models.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FilterLoading()) {
    on<LoadFilter>(_onLoadFilter);
    on<UpdateCategoryFilter>(_onUpdateCategoryFilter);
    on<UpdatePriceFilter>(_onUpdatePriceFilterFilter);
  }

  void _onLoadFilter(LoadFilter event, Emitter<FiltersState> emit) {
    emit(FilterLoaded(
        filter: Filter(
            categoryFilters: CategoryFilter.filters,
            priceFilters: PriceFilter.filters)));
  }

  void _onUpdateCategoryFilter(
      UpdateCategoryFilter event, Emitter<FiltersState> emit) {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<CategoryFilter> updateCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();
      emit(FilterLoaded(
          filter: Filter(
              categoryFilters: updateCategoryFilters,
              priceFilters: state.filter.priceFilters)));
    }
  }

  void _onUpdatePriceFilterFilter(
      UpdatePriceFilter event, Emitter<FiltersState> emit) {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<PriceFilter> updatePriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();
      emit(FilterLoaded(
          filter: Filter(
              categoryFilters: state.filter.categoryFilters,
              priceFilters: updatePriceFilters)));
    }
  }
}
