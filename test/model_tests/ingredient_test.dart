import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/amount.dart';
import 'package:drink_calculator/models/ingredient.dart';
import 'package:test/test.dart';

import '../test_data.dart';

void main() {
  final List<dynamic> optionsMap = <dynamic>[
    <String, dynamic>{"amount": "1 pc", "price": 5.20, "type": "Lime per kilo"},
    <String, dynamic>{"amount": "10 pc", "price": 39.90, "type": "Lime net"},
  ];
  final List<dynamic> subItemsMap = <dynamic>[
    <String, dynamic>{
      "id": "lime_peel",
      "name": "Lime peel",
      "updated": "2022-09-09",
      "equals_to": "8 pc"
    },
    <String, dynamic>{
      "id": "fresh_lime_juice",
      "name": "Fresh lime juice",
      "updated": "2022-09-11",
      "equals_to": "25 ml"
    },
    <String, dynamic>{
      "id": "lime_wedge",
      "name": "Lime wedge",
      "updated": "2022-09-09",
      "equals_to": "8 pc"
    },
    <String, dynamic>{
      "id": "lime_wheel",
      "name": "Lime wheel",
      "updated": "2022-09-09",
      "equals_to": "8 pc"
    },
  ];
  final Map<String, dynamic> ingredientMap = <String, dynamic>{
    "id": "lime",
    "name": "Lime",
    "updated": "2022-09-11",
    "options": optionsMap,
    "contains": subItemsMap,
  };

  group('from map', () {
    test('ingredient is parsed from map', () {
      final Ingredient ingredient = Ingredient.fromMap(ingredientMap);

      expect(ingredient.id, ingredientMap['id']);
      expect(ingredient.name, ingredientMap['name']);
      expect(
        ingredient.updated,
        DateTime.parse(ingredientMap['updated'] as String),
      );
      expect(ingredient.equalsTo, null);

      for (int i = 0; i < optionsMap.length; i++) {
        final Map<String, dynamic> optionMap =
            optionsMap[i] as Map<String, dynamic>;

        expect(
          ingredient.options?[i].amount,
          Amount.parse(optionMap['amount'] as String),
        );
        expect(
          ingredient.options?[i].price,
          (optionMap['price'] as double).toDecimal(),
        );
        expect(ingredient.options?[i].type, optionMap['type']);
      }

      for (int i = 0; i < subItemsMap.length; i++) {
        final Map<String, dynamic> subItemMap =
            subItemsMap[i] as Map<String, dynamic>;

        expect(ingredient.contains?[i].id, subItemMap['id']);
        expect(ingredient.contains?[i].name, subItemMap['name']);
        expect(
          ingredient.contains?[i].updated,
          DateTime.parse(subItemMap['updated'] as String),
        );
        expect(ingredient.contains?[i].options, null);
        expect(ingredient.contains?[i].contains, null);
        expect(
          ingredient.contains?[i].equalsTo,
          Amount.parse(subItemMap['equals_to'] as String),
        );
      }
    });
  });

  group('from json', () {
    test('ingredient is parsed from json', () {
      final List<Ingredient> ingredients =
          Ingredient.fromJson(jsonEncode(<dynamic>[ingredientMap]));
      final Ingredient ingredient = ingredients[0];

      expect(ingredients.length, 1);
      expect(ingredient.id, ingredientMap['id']);
      expect(ingredient.name, ingredientMap['name']);
      expect(
        ingredient.updated,
        DateTime.parse(ingredientMap['updated'] as String),
      );
      expect(ingredient.equalsTo, null);

      for (int i = 0; i < optionsMap.length; i++) {
        final Map<String, dynamic> optionMap =
            optionsMap[i] as Map<String, dynamic>;

        expect(
          ingredient.options?[i].amount,
          Amount.parse(optionMap['amount'] as String),
        );
        expect(
          ingredient.options?[i].price,
          (optionMap['price'] as double).toDecimal(),
        );
        expect(ingredient.options?[i].type, optionMap['type']);
      }

      for (int i = 0; i < subItemsMap.length; i++) {
        final Map<String, dynamic> subItemMap =
            subItemsMap[i] as Map<String, dynamic>;

        expect(ingredient.contains?[i].id, subItemMap['id']);
        expect(ingredient.contains?[i].name, subItemMap['name']);
        expect(
          ingredient.contains?[i].updated,
          DateTime.parse(subItemMap['updated'] as String),
        );
        expect(ingredient.contains?[i].options, null);
        expect(ingredient.contains?[i].contains, null);
        expect(
          ingredient.contains?[i].equalsTo,
          Amount.parse(subItemMap['equals_to'] as String),
        );
      }
    });
  });

  group('singleMatch', () {
    late List<Ingredient> ingredients;

    setUp(() {
      ingredients = getIngredients();
    });

    test('returns single match', () {
      final Ingredient match =
          Ingredient.singleMatch('minttu_peppermint', ingredients);

      expect(match.name, 'Minttu Peppermint');
    });

    test('returns single match on contained ingredient', () {
      final Ingredient match =
          Ingredient.singleMatch('fresh_orange_juice', ingredients);

      expect(match.name, 'Orange');
    });

    test('throws error if the id is not in the list', () {
      expect(
        () => Ingredient.singleMatch('invalid', ingredients),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error if the list contains more than a single match', () {
      ingredients.add(ingredients[0]);

      expect(
        () => Ingredient.singleMatch(ingredients[0].id, ingredients),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('sumAmount', () {
    final List<IngredientOption> options = <IngredientOption>[
      IngredientOption(
        amount: Amount.pieces(pc: 4.toDecimal()),
        price: 0.toDecimal(),
        type: 'Type',
      ),
      IngredientOption(
        amount: Amount.pieces(pc: 1.5.toDecimal()),
        price: 0.toDecimal(),
        type: 'Type',
      ),
      IngredientOption(
        amount: Amount.pieces(pc: 40.toDecimal()),
        price: 0.toDecimal(),
        type: 'Type',
      ),
    ];

    test('returns sum of amounts', () {
      final Amount sum = IngredientOption.sumAmount(options);
      expect(sum, Amount.pieces(pc: 45.5.toDecimal()));
    });

    test('returns empty amount if list is empty', () {
      final Amount sum = IngredientOption.sumAmount(<IngredientOption>[]);
      expect(sum, Amount.empty());
    });

    test('throws error if the list contains different kinds of amounts', () {
      final List<IngredientOption> newOptions =
          List<IngredientOption>.from(options)
            ..add(
              IngredientOption(
                amount: Amount.volume(l: 1.toDecimal()),
                price: 0.toDecimal(),
                type: 'type',
              ),
            );

      expect(
        () => IngredientOption.sumAmount(newOptions),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('toString', () {
    final IngredientOption option = IngredientOption(
      amount: Amount.empty(),
      price: 0.0.toDecimal(),
      type: 'Type',
    );
    final Ingredient ingredient = Ingredient(
      id: 'ingredient',
      name: 'Ingredient',
      updated: DateTime.now(),
      options: <IngredientOption>[option],
    );

    test('string representation of an ingredient is name', () {
      expect(ingredient.toString(), ingredient.name);
    });

    test('string representation of an ingredientOption is type', () {
      expect(option.toString(), option.type);
    });
  });
}
