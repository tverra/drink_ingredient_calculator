import 'package:args/args.dart';
import 'package:drink_calculator/constants.dart' as constants;
import 'package:drink_calculator/models/config.dart';
import 'package:drink_calculator/utils.dart';

void listDrinks(ArgResults args) {
  final String fileName = args[constants.fileNameOption] as String;
  final Config config = readConfig(fileName);

  for (int i = 0; i < config.drinks.length; i++) {
    print('${i + 1}:\t ${config.drinks[i].name}');
  }
}
