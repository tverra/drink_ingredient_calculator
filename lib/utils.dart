import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';

String generateString(String pattern, int repetitions) {
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < repetitions; i++) {
    buffer.write(pattern);
  }
  return buffer.toString();
}

List<Drink> readDrinks(String name) {
  final List<Drink> drinks =
      Drink.fromJson(File('drinks.json').readAsStringSync());

  final Map<String, dynamic> config =
      jsonDecode(File('collections/$name.json').readAsStringSync())
          as Map<String, dynamic>;

  final List<String> included = (config['included'] as List<dynamic>)
      .map((dynamic e) => e as String)
      .toList();

  return drinks.where((Drink d) => included.contains(d.id)).toList();
}

List<Ingredient> readIngredients() {
  return Ingredient.fromJson(File('ingredients.json').readAsStringSync());
}

int getNumberOfDrinks(ArgResults args) {
  final String? numberOfDrinksOption =
  args[constants.numberOfDrinksOption] as String?;
  return int.tryParse(numberOfDrinksOption ?? '') ?? 1;
}
