import 'dart:convert';

import 'package:drink_calculator/amount.dart';

class Drink {
  final String name;
  final List<DrinkIngredient> ingredients;

  Drink({required this.name, required this.ingredients});

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      name: map['name'] as String,
      ingredients: (map['ingredients'] as List<dynamic>)
          .map(
            (dynamic i) => DrinkIngredient.fromMap(i as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  static List<Drink> fromJson(String json) {
    final List<dynamic> parsed = jsonDecode(json) as List<dynamic>;
    return parsed
        .map((dynamic d) => Drink.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  @override
  String toString() => name;
}

class DrinkIngredient {
  final String name;
  final Amount amount;

  DrinkIngredient({required this.name, required this.amount});

  factory DrinkIngredient.fromMap(Map<String, dynamic> map) {
    return DrinkIngredient(
      name: map['name'] as String,
      amount: Amount.parse(map['amount'] as String),
    );
  }

  @override
  String toString() => name;
}
