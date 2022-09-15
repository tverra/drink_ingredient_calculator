import 'package:decimal/decimal.dart';
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/config.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';
import 'package:drink_calculator/models/ingredient_amounts.dart';

class DrinkListModifier {
  final Config _config;
  final List<Ingredient> _ingredients;
  final int numberOfDrinks;

  DrinkListModifier(
    Config config,
    List<Ingredient> ingredients, {
    this.numberOfDrinks = 1,
  })  : _config = config,
        _ingredients = ingredients;

  List<Drink> shrinkDrinkListTo(int number) {
    final List<Drink> drinks = List<Drink>.from(_config.drinks);

    while (drinks.length > number) {
      final IngredientAmounts ingredientAmounts =
          IngredientAmounts(_ingredients, _config.skipInCalculation)
            ..addDrinkList(_config.drinks)
            ..multiply(numberOfDrinks);
      final List<SelectedAlternatives> bestAlternatives =
          ingredientAmounts.getBestOptions();

      for (final SelectedAlternatives alternative in bestAlternatives) {
        final Decimal unusedValue = alternative.unusedValue;

        print('${alternative.ingredient.name}: ${alternative.requiredAmount}');
        print('purchase amount: ${alternative.sumAmount}');
        print('price: ${alternative.sumPrice.formatPrice()}');
        print('unused value: ${unusedValue.formatPrice()}\n');
      }
      break;
    }

    return drinks;
  }
}
