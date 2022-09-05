import 'dart:convert';

import 'package:drink_calculator/amount.dart';

class Ingredient {
  final String name;
  final List<Alternative> alternatives;
  Amount amount = Amount();

  Ingredient({required this.name, required this.alternatives});

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'] as String,
      alternatives: (map['alternatives'] as List<dynamic>)
          .map((dynamic a) => Alternative.fromMap(a as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<Ingredient> fromJson(String json) {
    final List<dynamic> parsed = jsonDecode(json) as List<dynamic>;
    return parsed
        .map((dynamic d) => Ingredient.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  static Ingredient singleMatchOnName(List<Ingredient> list, String name) {
    final Iterable<Ingredient> matches =
        list.where((Ingredient i) => i.name == name);

    if (matches.isEmpty) {
      throw ArgumentError('The following ingredient is missing: $name');
    } else if (matches.length > 1) {
      throw ArgumentError('Duplicate ingredient: $name');
    }

    return matches.single;
  }

  @override
  String toString() => name;
}

class Alternative {
  final Amount amount;
  final double price;
  final String type;

  Alternative({required this.amount, required this.price, required this.type});

  factory Alternative.fromMap(Map<String, dynamic> map) {
    return Alternative(
      amount: Amount.parse(map['amount'] as String),
      price: map['price'] as double,
      type: map['type'] as String,
    );
  }

  static double calculateSum(List<Alternative> list) {
    return list.fold(
      0,
      (double previous, Alternative current) => previous + current.price,
    );
  }

  static Amount calculateAmount(List<Alternative> list) {
    final List<Amount> amounts = list.map((Alternative a) => a.amount).toList();
    return Amount.calculateSum(amounts);
  }
}
