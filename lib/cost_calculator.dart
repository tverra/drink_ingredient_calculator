import 'package:args/args.dart';
import 'package:decimal/decimal.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';
import 'package:drink_calculator/models/ingredient_amounts.dart';
import 'package:drink_calculator/utils.dart';

void calculateCost(ArgResults args) {
  final String fileName = args[constants.fileNameOption] as String;
  final List<Drink> drinks = readDrinks(fileName);
  final List<Ingredient> ingredients = readIngredients();
  final int numberOfDrinks = getNumberOfDrinks(args);

  Decimal totalSum = Decimal.zero;

  final IngredientAmounts ingredientAmounts = IngredientAmounts(ingredients)
    ..addDrinkList(drinks)
    ..multiply(numberOfDrinks);

  final List<SelectedAlternatives> bestAlternatives = ingredientAmounts.getBestOptions();


  for (final SelectedAlternatives item in bestAlternatives) {
    final Decimal purchaseSum = item.sumPrice;
    totalSum += purchaseSum;

    print('${item.ingredient.name}: ${item.requiredAmount.toString()}');
    print('purchase amount: ${IngredientOption.sumAmount(item.options).toString()}');
    print('price: ${purchaseSum.formatPrice()}');
    print('');
  }

  print('Total: ${totalSum.formatPrice()}');
}
