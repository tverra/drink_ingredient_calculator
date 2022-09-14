import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:drink_calculator/constants.dart';
import 'package:drink_calculator/cost_calculator.dart';
import 'package:drink_calculator/list_drinks.dart';
import 'package:drink_calculator/utils.dart';

Future<void> main(List<String> arguments) async {
  final CommandRunner<void> runner =
      CommandRunner<void>('drink_calculator', introMessage('0.0.1'))
        ..addCommand(ListCommand())
        ..addCommand(CalculateCommand());

  await runner.run(arguments);
}

String introMessage(String version) {
  final String fill = generateString('═', version.length + 3);

  return '''
  ═════════════════════════$fill
      DRINK CALCULATOR (v$version)                               
  ═════════════════════════$fill
  ''';
}

class ListCommand extends Command<void> {
  ListCommand() {
    argParser.addOption(
      fileNameOption,
      abbr: 'f',
      help: 'The name of the config',
    );
  }

  @override
  String get name => 'list';

  @override
  String get description => 'Lists out all drinks.';

  @override
  void run() {
    final ArgResults? results = argResults;

    if (results != null) {
      listDrinks(results);
    } else {
      print('argResults is null');
    }
  }
}

class CalculateCommand extends Command<void> {
  CalculateCommand() {
    argParser
      ..addOption(
        numberOfDrinksOption,
        abbr: 'n',
        help: 'The expected number of each drink',
      )
      ..addOption(
        fileNameOption,
        abbr: 'f',
        help: 'The name of the config',
      );
  }

  @override
  String get name => 'calculate';

  @override
  String get description => 'Calculate cost of all drinks';

  @override
  void run() {
    final ArgResults? results = argResults;

    if (results != null) {
      calculateCost(results);
    } else {
      print('argResults is null');
    }
  }
}
