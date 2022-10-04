import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/basket/basket_bloc.dart';

class EditBasketScreen extends StatelessWidget {
  static const String routeName = '/edit-basket';

  const EditBasketScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const EditBasketScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Edit Basket'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                shape: const RoundedRectangleBorder(),
                backgroundColor: Theme.of(context).accentColor,
              ),
              child: const Text('Done'),
              onPressed: () {},
            )
          ],
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
            BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                if (state is BasketLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is BasketLoaded) {
                  return state.basket.items.isEmpty
                      ? Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'No Items in the basket',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.basket
                              .itemCuantity(state.basket.items)
                              .keys
                              .length,
                          itemBuilder: (context, index) {
                            var menuItem = state.basket.itemCuantity(state.basket.items).keys.elementAt(index);
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${state.basket.itemCuantity(state.basket.items).entries.elementAt(index).value}x',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: Theme.of(context).accentColor,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${menuItem.name}',
                                      textAlign: TextAlign.left,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<BasketBloc>()
                                            .add(RemoveAllItem(menuItem));
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<BasketBloc>()
                                            .add(RemoveItem(menuItem));
                                      },
                                      icon: const Icon(Icons.remove_circle)),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<BasketBloc>()
                                            .add(AddItem(menuItem));
                                      },
                                      icon: const Icon(Icons.add_circle)),
                                ],
                              ),
                            );
                          },
                        );
                } else {
                  return const Text("Something went wrong.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
