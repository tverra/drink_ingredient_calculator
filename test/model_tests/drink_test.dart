import 'dart:convert';

import 'package:drink_calculator/models/amount.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:test/test.dart';

void main() {
  final List<dynamic> drinkIngredientsMap = <dynamic>[
    <String, dynamic>{"id": "gin", "amount": "2 cl"},
    <String, dynamic>{"id": "campari", "amount": "2 cl"},
    <String, dynamic>{"id": "vermouth_rosso", "amount": "2 cl"},
    <String, dynamic>{"id": "orange_peel", "amount": "1 pc"}
  ];
  final Map<String, dynamic> drinkMap = <String, dynamic>{
    "id": "negroni",
    "name": "Negroni",
    "ingredients": drinkIngredientsMap,
  };

  group('from map', () {
    test('drink is parsed from map', () {
      final Drink drink = Drink.fromMap(drinkMap);

      expect(drink.id, drinkMap['id']);
      expect(drink.name, drinkMap['name']);

      for (int i = 0; i < drinkIngredientsMap.length; i++) {
        final Map<String, dynamic> ingredientMap =
            drinkIngredientsMap[i] as Map<String, dynamic>;

        expect(drink.ingredients[i].id, ingredientMap['id']);
        expect(
          drink.ingredients[i].amount,
          Amount.parse(ingredientMap['amount'] as String),
        );
      }
    });
  });

  group('fromJson', () {
    test('drink is parsed from json', () {
      final List<Drink> drinks =
          Drink.fromJson(jsonEncode(<dynamic>[drinkMap]));
      final Drink drink = drinks[0];

      expect(drinks.length, 1);
      expect(drink.id, drinkMap['id']);
      expect(drink.name, drinkMap['name']);

      for (int i = 0; i < drinkIngredientsMap.length; i++) {
        final Map<String, dynamic> ingredientMap =
            drinkIngredientsMap[i] as Map<String, dynamic>;

        expect(drink.ingredients[i].id, ingredientMap['id']);
        expect(
          drink.ingredients[i].amount,
          Amount.parse(ingredientMap['amount'] as String),
        );
      }
    });
  });

  group('toString', () {
    final DrinkIngredient ingredient = DrinkIngredient(
      id: 'ingredient',
      amount: Amount.empty(),
    );

    final Drink drink = Drink(
      id: 'drink',
      name: 'Drink',
      ingredients: <DrinkIngredient>[ingredient],
    );

    test('string representation of a drink is name', () {
      expect(drink.toString(), drink.name);
    });

    test('string representation of an ingredient is id', () {
      expect(ingredient.toString(), ingredient.id);
    });
  });
}
