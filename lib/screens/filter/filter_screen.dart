import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/models.dart';
import 'package:project/screens/restaurant_listing/restaurnat_listing_screen.dart';

import '../../blocs/filters/filters_bloc.dart';
import '../../widgets/widgets.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  static const String routeName = '/filters';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const FiltersScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Filters'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FiltersBloc, FiltersState>(
                builder: (context, state) {
                  if (state is FiltersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FiltersLoaded) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          var categories = state.filter.categoryFilters
                              .where((filter) => filter.value)
                              .map((filter) => filter.category.name)
                              .toList();

                          var prices = state.filter.priceFilters
                              .where((filter) => filter.value)
                              .map((filter) => filter.price.price)
                              .toList();

                          List<Restaurant> restaurants = Restaurant.restaurants
                              .where(
                                (restaurant) => categories.any(
                                  (category) =>
                                      restaurant.tags.contains(category),
                                ),
                              )
                              .where(
                                (restaurant) => prices.any(
                                  (price) =>
                                      restaurant.priceCategory.contains(price),
                                ),
                              )
                              .toList();

                          Navigator.pushNamed(
                              context, RestaurantListingScreen.routeName,
                              arguments: restaurants);
                        },
                        child: const Text('Apply'));
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).accentColor),
            ),
            const CustomPriceFilter(),
            Text(
              'Category',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).accentColor),
            ),
            const CustomCategoryFilter()
          ],
        ),
      ),
    );
  }
}
