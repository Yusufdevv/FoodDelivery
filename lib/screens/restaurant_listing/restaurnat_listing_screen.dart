import 'package:flutter/material.dart';
import 'package:project/models/models.dart';
import 'package:project/widgets/widgets.dart';

class RestaurantListingScreen extends StatelessWidget {
  const RestaurantListingScreen({super.key, required this.restaurants});
  final List<Restaurant> restaurants;
  static const String routeName = '/restaurant-listing';

  static Route route({required List<Restaurant> restaurants}) {
    return MaterialPageRoute(
        builder: (_) => RestaurantListingScreen(
              restaurants: restaurants,
            ),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(restaurant: restaurants[index]);
              }),
        ));
  }
}
