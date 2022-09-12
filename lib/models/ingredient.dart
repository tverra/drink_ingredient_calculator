import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:drink_calculator/models/amount.dart';

class Ingredient {
  final String id;
  final String name;
  final DateTime updated;
  final List<IngredientOption>? options;
  final List<Ingredient>? contains;
  final Amount? equalsTo;

  Ingredient({
    required this.id,
    required this.name,
    required this.updated,
    this.options,
    this.contains,
    this.equalsTo,
  });

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    try {
      return Ingredient(
        id: map['id'] as String,
        name: map['name'] as String,
        updated: DateTime.parse(map['updated'] as String),
        options: (map['options'] as List<dynamic>?)
            ?.map(
              (dynamic a) =>
                  IngredientOption.fromMap(a as Map<String, dynamic>),
            )
            .toList(),
        contains: (map['contains'] as List<dynamic>?)
            ?.map((dynamic c) => Ingredient.fromMap(c as Map<String, dynamic>))
            .toList(),
        equalsTo: map['equals_to'] is String
            ? Amount.parse(map['equals_to'] as String)
            : null,
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to parse map: $map\n');
    }
  }

  static List<Ingredient> fromJson(String json) {
    final List<dynamic> parsed = jsonDecode(json) as List<dynamic>;
    return parsed
        .map((dynamic d) => Ingredient.fromMap(d as Map<String, dynamic>))
        .toList();
  }

  static Ingredient singleMatch(String id, List<Ingredient> list) {
    final List<Ingredient> matches = _matchOnId(id, list);

    if (matches.isEmpty) {
      throw ArgumentError('The following ingredient is missing: $id');
    } else if (matches.length > 1) {
      throw ArgumentError('Duplicate ingredient: $id');
    }

    return matches.single;
  }

  static List<Ingredient> _matchOnId(String id, List<Ingredient> list) {
    final List<Ingredient> matches = <Ingredient>[];

    for (final Ingredient ingredient in list) {
      final List<Ingredient>? contains = ingredient.contains;

      if (ingredient.id == id ||
          (contains != null && _matchOnId(id, contains).isNotEmpty)) {
        matches.add(ingredient);
      }
    }
    return matches;
  }

  @override
  String toString() => name;
}

class IngredientOption {
  final Amount amount;
  final Decimal price;
  final String type;

  IngredientOption({
    required this.amount,
    required this.price,
    required this.type,
  });

  factory IngredientOption.fromMap(Map<String, dynamic> map) {
    try {
      return IngredientOption(
        amount: Amount.parse(map['amount'] as String),
        price: Decimal.parse((map['price'] as double).toString()),
        type: map['type'] as String,
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to parse map: $map\n');
    }
  }

  static Amount sumAmount(List<IngredientOption> list) {
    final List<Amount> amounts =
        list.map((IngredientOption a) => a.amount).toList();

    return Amount.sumFromList(amounts);
  }

  @override
  String toString() {
    return type;
  }
}
