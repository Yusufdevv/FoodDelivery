import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/filters/filters_bloc.dart';

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FiltersLoaded) {
          var categoryFilters = state.filter.categoryFilters;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: categoryFilters.length,
              itemBuilder: (context, index) {
                var categoryFiltersItem = categoryFilters[index];
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categoryFiltersItem.category.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                            value: categoryFiltersItem.value,
                            onChanged: (bool? newValue) {
                              context.read<FiltersBloc>().add(
                                  CategoryFilterUpdatedEvent(
                                      categoryFilter:
                                          categoryFiltersItem.copyWith(
                                              value:
                                                  !categoryFiltersItem.value)));
                            }),
                      )
                    ],
                  ),
                );
              });
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
