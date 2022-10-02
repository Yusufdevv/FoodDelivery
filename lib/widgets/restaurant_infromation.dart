import 'package:flutter/material.dart';
import 'package:project/models/models.dart';

import 'widgets.dart';

class RestaurantInformation extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantInformation({required this.restaurant, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Theme.of(context).accentColor),
          ),
          const SizedBox(height: 10),
          RestaurantTags(restaurant: restaurant),
          const SizedBox(height: 5),
          Text(
            '${restaurant.distance}km away- \$${restaurant.deliveryFee} delivery fee',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 10),
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline5!,
          ),
          const SizedBox(height: 5),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
