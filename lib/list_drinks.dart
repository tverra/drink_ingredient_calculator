import 'package:args/args.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/utils.dart';

void listDrinks(ArgResults args) {
  final String fileName = args[constants.fileNameOption] as String;
  final List<Drink> drinks = readDrinks(fileName);

  for (int i = 0; i < drinks.length; i++) {
    print('${i + 1}:\t ${drinks[i].name}');
  }
}
