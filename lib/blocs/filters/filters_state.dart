// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object> get props => [];
}

class FilterLoading extends FiltersState {}

class FilterLoaded extends FiltersState {
  final Filter filter;

  const FilterLoaded({this.filter = const Filter()});

  @override
  List<Object> get props => [filter];
}
