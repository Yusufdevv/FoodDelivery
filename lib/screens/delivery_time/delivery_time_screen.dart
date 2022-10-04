import 'package:flutter/material.dart';

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
