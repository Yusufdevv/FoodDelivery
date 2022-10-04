// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:project/models/models.dart';

class Basket extends Equatable {
  final List<MenuItem> items;
  final bool cutlery;
  const Basket({
    this.items = const <MenuItem>[],
    this.cutlery = false,
  });

  @override
  List<Object?> get props => [items, cutlery];

  Basket copyWith({List<MenuItem>? items, bool? cutlery}) {
    return Basket(items: items ?? this.items, cutlery: cutlery ?? this.cutlery);
  }

  Map itemCuantity(items) {
    var quantity = Map();

    items.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      items.fold(0, (total, current) => total + current.price);

  double total(subtotal) {
    return subtotal + 5;
  }

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal).toStringAsFixed(2);
}
