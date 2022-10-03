import 'package:flutter/material.dart';
import 'package:project/models/models.dart';

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
