import 'package:args/args.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/models/config.dart';
import 'package:drink_calculator/models/drink_list_modifier.dart';
import 'package:drink_calculator/models/ingredient.dart';
import 'package:drink_calculator/utils.dart';

void shrinkList(ArgResults args) {
  final String fileName = args[constants.fileNameOption] as String;
  final Config config = readConfig(fileName);
  final List<Ingredient> ingredients = readIngredients();
  final int numberOfDrinks = getNumberOfDrinks(args);

  final DrinkListModifier modifier =
      DrinkListModifier(config, ingredients, numberOfDrinks: numberOfDrinks);

  modifier.shrinkDrinkListTo(10);
}
