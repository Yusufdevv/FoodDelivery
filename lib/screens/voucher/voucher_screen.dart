import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/models.dart';

import '../../blocs/basket/basket_bloc.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  static const String routeName = '/voucher';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const VoucherScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voucher'),
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
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text('Apply'),
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
                'Edit a Voucher Code',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Voucher Code',
                            contentPadding: EdgeInsets.all(10)),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Your Vouchers',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              ListView.builder(
                  itemCount: Voucher.vouchers.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1x',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              Voucher.vouchers[index].code,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          BlocBuilder<BasketBloc, BasketState>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () {
                                  context
                                      .read<BasketBloc>()
                                      .add(AddVoucher(Voucher.vouchers[index]));
                                  Navigator.pop(context);
                                },
                                child: const Text('Apply'),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  }))
            ],
          ),
        ));
  }
}
