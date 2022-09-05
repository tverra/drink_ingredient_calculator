import 'dart:io';

import 'package:args/args.dart';
import 'package:drink_calculator/amount.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';

void calculateCost(ArgResults argResults) {
  final List<Drink> drinks =
      Drink.fromJson(File('drinks.json').readAsStringSync());
  final List<Ingredient> ingredients =
      Ingredient.fromJson(File('ingredients.json').readAsStringSync());

  final String? numberOfDrinksOption =
      argResults[constants.numberOfDrinksOption] as String?;
  final int numberOfDrinks = int.tryParse(numberOfDrinksOption ?? '') ?? 1;
  double totalSum = 0;

  for (final Drink drink in drinks) {
    for (final DrinkIngredient ingredient in drink.ingredients) {
      final Amount amount = ingredient.amount.multiply(numberOfDrinks);

      Ingredient.singleMatchOnName(ingredients, ingredient.name).amount +=
          amount;
    }
  }

  for (final Ingredient ingredient in ingredients) {
    final Amount requiredAmount = ingredient.amount;
    final List<Alternative> items = <Alternative>[];

    while (Alternative.calculateAmount(items) < requiredAmount) {
      for (int i = 0; i < ingredient.alternatives.length; i++) {
        final Alternative alternative = ingredient.alternatives[i];

        if (requiredAmount - Alternative.calculateAmount(items) <=
                alternative.amount ||
            i == ingredient.alternatives.length - 1) {
          items.add(alternative);
        } else {
          continue;
        }

        if (Alternative.calculateAmount(items) >= requiredAmount) {
          break;
        }
      }
    }

    totalSum += Alternative.calculateSum(items);

    print('${ingredient.name}: ${requiredAmount.toString()}');
    print('purchase amount: ${Alternative.calculateAmount(items).toString()}');
    print('price: ${Alternative.calculateSum(items).formatPrice()}');
    print('');
  }

  print('Total: ${totalSum.formatPrice()}');
}
