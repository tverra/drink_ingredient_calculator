import 'dart:io';

import 'package:args/args.dart';
import 'package:drink_calculator/models/drink.dart';

void listDrinks(ArgResults results) {
  final List<Drink> drinks =
      Drink.fromJson(File('drinks.json').readAsStringSync());

  for (final Drink drink in drinks) {
    print(drink.name);
  }
}
