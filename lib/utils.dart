import 'dart:io';

import 'package:args/args.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/models/config.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';

String generateString(String pattern, int repetitions) {
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < repetitions; i++) {
    buffer.write(pattern);
  }
  return buffer.toString();
}

List<Drink> readDrinks() {
  return Drink.fromJson(File('drinks.json').readAsStringSync());
}

List<Ingredient> readIngredients() {
  return Ingredient.fromJson(File('ingredients.json').readAsStringSync());
}

Config readConfig(String name) {
  return Config.fromJson(
    File('collections/$name.json').readAsStringSync(),
    readDrinks(),
    readIngredients(),
  );
}

int getNumberOfDrinks(ArgResults args) {
  final String? numberOfDrinksOption =
      args[constants.numberOfDrinksOption] as String?;
  return int.tryParse(numberOfDrinksOption ?? '') ?? 1;
}
