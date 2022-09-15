import 'package:args/args.dart';
import 'package:decimal/decimal.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/config.dart';
import 'package:drink_calculator/models/ingredient.dart';
import 'package:drink_calculator/models/ingredient_amounts.dart';
import 'package:drink_calculator/utils.dart';

void summarizeList(ArgResults args) {
  final String fileName = args[constants.fileNameOption] as String;
  final Config config = readConfig(fileName);
  final List<Ingredient> ingredients = readIngredients();
  final int numberOfDrinks = getNumberOfDrinks(args);

  final IngredientAmounts ingredientAmounts =
      IngredientAmounts(ingredients, config.skipInCalculation)
        ..addDrinkList(config.drinks)
        ..multiply(numberOfDrinks);

  final List<SelectedAlternatives> bestAlternatives =
      ingredientAmounts.getBestOptions();

  for (final SelectedAlternatives item in bestAlternatives) {
    final Decimal purchaseSum = item.sumPrice;

    print('${item.ingredient.name}: ${item.requiredAmount}');
    print('purchase amount: ${IngredientOption.sumAmount(item.options)}');
    print('price: ${purchaseSum.formatPrice()}');
    print('');
  }

  print('Total: ${ingredientAmounts.getTotalSum().formatPrice()}');
}
