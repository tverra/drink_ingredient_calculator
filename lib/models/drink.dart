import 'dart:convert';

import 'package:drink_calculator/models/amount.dart';

class Drink {
  final String id;
  final String name;
  final List<DrinkIngredient> ingredients;

  Drink({required this.id, required this.name, required this.ingredients});

  factory Drink.fromMap(Map<String, dynamic> map) {
    try {
      return Drink(
        id: map['id'] as String,
        name: map['name'] as String,
        ingredients: (map['ingredients'] as List<dynamic>)
            .map(
              (dynamic i) => DrinkIngredient.fromMap(i as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to parse map: $map\n');
    }
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
  final String id;
  final Amount amount;

  DrinkIngredient({required this.id, required this.amount});

  factory DrinkIngredient.fromMap(Map<String, dynamic> map) {
    try {
      return DrinkIngredient(
        id: map['id'] as String,
        amount: Amount.parse(map['amount'] as String),
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to parse map: $map\n');
    }
  }

  @override
  String toString() => id;
}
