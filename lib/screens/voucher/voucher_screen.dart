import 'package:flutter/material.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  static const String routeName = '/voucher';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => VoucherScreen(), settings:const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/location');
              },
              child: const Text('Go location'))),
    );
  }
}
