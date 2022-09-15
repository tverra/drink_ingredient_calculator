import 'dart:convert';

import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';

class Config {
  final List<Drink> drinks;
  final List<Ingredient> skipInCalculation;

  Config(this.drinks, this.skipInCalculation);

  factory Config.fromJson(
    String json,
    List<Drink> drinks,
    List<Ingredient> ingredients,
  ) {
    final Map<String, dynamic> config =
        jsonDecode(json) as Map<String, dynamic>;

    final List<String> includedMaps =
        (config['included'] as List<dynamic>? ?? <dynamic>[])
            .map((dynamic e) => e as String)
            .toList();
    final List<String> skipInCalculationMaps =
        (config['skip_in_calculation'] as List<dynamic>? ?? <dynamic>[])
            .map((dynamic e) => e as String)
            .toList();

    final List<Drink> included = drinks
        .where(
          (Drink d) => includedMaps.contains(d.id),
        )
        .toList();
    final List<Ingredient> skipInCalculation = ingredients
        .where(
          (Ingredient i) => skipInCalculationMaps.contains(i.id),
        )
        .toList();

    return Config(included, skipInCalculation);
  }
}
