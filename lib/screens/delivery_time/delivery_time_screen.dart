import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/delivery_time_model.dart';

import '../../blocs/basket/basket_bloc.dart';

class DeliveryTimeScreen extends StatelessWidget {
  const DeliveryTimeScreen({super.key});

  static const String routeName = '/delivery';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const DeliveryTimeScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Time'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  shape: const RoundedRectangleBorder()),
              child: const Text('Select'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose a Date',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Delivery is Today!'),
                          duration: Duration(seconds: 2),
                        ));
                      },
                      child: const Text('Today')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Delivery is Tomorrow!'),
                          duration: Duration(seconds: 2),
                        ));
                      },
                      child: const Text('Tomorrow')),
                ],
              ),
            ),
            Text('Your Vouchers',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: GridView.builder(
                    itemCount: DeliveryTime.deliveryTimes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (context, index) {
                      return BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketLoaded) {
                            return Card(
                              color: state.basket.deliveryTime ==
                                      DeliveryTime.deliveryTimes[index]
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              child: TextButton(
                                  onPressed: () {
                                    context.read<BasketBloc>().add(
                                          SelectDeliveryTime(DeliveryTime
                                              .deliveryTimes[index]),
                                        );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(DeliveryTime
                                                .deliveryTimes[index].value),
                                            duration:
                                                const Duration(seconds: 1)));
                                  },
                                  child: Text(
                                      DeliveryTime.deliveryTimes[index].value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6)),
                            );
                          } else {
                            return const Text('Something went wrong.');
                          }
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
