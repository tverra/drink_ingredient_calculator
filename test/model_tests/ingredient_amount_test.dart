import 'package:decimal/decimal.dart';
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/amount.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';
import 'package:drink_calculator/models/ingredient_amounts.dart';
import 'package:test/test.dart';

void main() {
  group('addDrinkList', () {
    test('list of drinks are added', () {
      final List<Ingredient> ingredients = <Ingredient>[
        Ingredient(
          id: 'ingredient1',
          name: 'Ingredient1',
          updated: DateTime.now(),
          options: <IngredientOption>[
            IngredientOption(
              amount: Amount.volume(dl: 7.toDecimal()),
              price: 450.toDecimal(),
              type: 'Medium bottle',
            ),
          ],
        ),
        Ingredient(
          id: 'ingredient2',
          name: 'Ingredient2',
          updated: DateTime.now(),
          options: <IngredientOption>[
            IngredientOption(
              amount: Amount.volume(dl: 7.toDecimal()),
              price: 450.toDecimal(),
              type: 'Medium bottle',
            ),
          ],
        ),
        Ingredient(
          id: 'ingredient3',
          name: 'Ingredient3',
          updated: DateTime.now(),
          options: <IngredientOption>[
            IngredientOption(
              amount: Amount.volume(dl: 7.toDecimal()),
              price: 450.toDecimal(),
              type: 'Medium bottle',
            ),
          ],
        )
      ];

      final IngredientAmounts amounts = IngredientAmounts(ingredients);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink1',
          name: 'Drink1',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient1',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
            DrinkIngredient(
              id: 'ingredient2',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
          ],
        ),
        Drink(
          id: 'drink2',
          name: 'Drink2',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient2',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
            DrinkIngredient(
              id: 'ingredient3',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
          ],
        ),
        Drink(
          id: 'drink3',
          name: 'Drink2',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient3',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
            DrinkIngredient(
              id: 'ingredient1',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();

      expect(bestOptions.length, 3);
      expect(bestOptions[0].ingredient.id, 'ingredient1');
      expect(bestOptions[1].ingredient.id, 'ingredient2');
      expect(bestOptions[2].ingredient.id, 'ingredient3');
      expect(bestOptions[0].requiredAmount, Amount.volume(cl: 8.toDecimal()));
      expect(bestOptions[1].requiredAmount, Amount.volume(cl: 8.toDecimal()));
      expect(bestOptions[2].requiredAmount, Amount.volume(cl: 8.toDecimal()));
    });

    test('ingredients contained within other ingredients are added', () {
      final Ingredient lemon = Ingredient(
        id: 'lemon',
        name: 'Lemon',
        updated: DateTime.now(),
        options: <IngredientOption>[
          IngredientOption(
            amount: Amount.pieces(pc: 1.toDecimal()),
            price: 10.toDecimal(),
            type: 'Lemon per piece',
          ),
        ],
        contains: <Ingredient>[
          Ingredient(
            id: 'fresh_lemon_juice',
            name: 'Fresh lemon juice',
            updated: DateTime.now(),
            equalsTo: Amount.volume(cl: 4.toDecimal()),
          ),
          Ingredient(
            id: 'lemon_wedge',
            name: 'Lemon wedge',
            updated: DateTime.now(),
            equalsTo: Amount.pieces(pc: 8.toDecimal()),
          ),
          Ingredient(
            id: 'lemon_counterweight',
            name: 'Lemon counterweight',
            updated: DateTime.now(),
            equalsTo: Amount.weight(g: 400.toDecimal()),
          ),
        ],
      );
      final Drink lemonemonade = Drink(
        id: 'lemonemonade',
        name: 'Lemonemonade',
        ingredients: <DrinkIngredient>[
          DrinkIngredient(
            id: 'lemon',
            amount: Amount.pieces(pc: 0.5.toDecimal()),
          ),
          DrinkIngredient(
            id: 'fresh_lemon_juice',
            amount: Amount.volume(cl: 4.toDecimal()),
          ),
          DrinkIngredient(
            id: 'lemon_wedge',
            amount: Amount.pieces(pc: 1.toDecimal()),
          ),
          DrinkIngredient(
            id: 'lemon_counterweight',
            amount: Amount.weight(
              g: 200.toDecimal(),
            ),
          ),
        ],
      );

      final IngredientAmounts amounts = IngredientAmounts(<Ingredient>[lemon]);

      amounts.addDrinkList(<Drink>[lemonemonade]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();

      expect(bestOptions.length, 1);
      expect(bestOptions[0].ingredient.id, 'lemon');
      expect(
        bestOptions[0].requiredAmount,
        Amount.pieces(pc: 2.125.toDecimal()),
      );
    });
  });

  group('multiply', () {
    final Ingredient ingredient = Ingredient(
      id: 'ingredient',
      name: 'Ingredient',
      updated: DateTime.now(),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.volume(dl: 7.toDecimal()),
          price: 450.toDecimal(),
          type: 'Medium bottle',
        ),
      ],
    );

    test('amounts are multiplied', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink1',
          name: 'Drink1',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
          ],
        ),
        Drink(
          id: 'drink2',
          name: 'Drink2',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
          ],
        ),
      ]);

      amounts.multiply(2);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();

      expect(bestOptions.length, 1);
      expect(bestOptions[0].requiredAmount, Amount.volume(cl: 16.toDecimal()));
    });
  });

  group('getBestOptions', () {
    final Ingredient ingredient = Ingredient(
      id: 'ingredient',
      name: 'Ingredient',
      updated: DateTime.now(),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.volume(dl: 1.toDecimal()),
          price: 100.toDecimal(),
          type: 'Small bottle',
        ),
        IngredientOption(
          amount: Amount.volume(dl: 5.toDecimal()),
          price: 450.toDecimal(),
          type: 'Medium bottle',
        ),
        IngredientOption(
          amount: Amount.volume(l: 1.toDecimal()),
          price: 800.toDecimal(),
          type: 'Large bottle',
        ),
      ],
    );

    test('returns empty list if no drinks are added', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      expect(amounts.getBestOptions(), <SelectedAlternatives>[]);
    });

    test('returns empty list if drink as no ingredients', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[],
        )
      ]);

      expect(amounts.getBestOptions(), <SelectedAlternatives>[]);
    });

    test('selects the smallest possible bottle', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(ml: 1.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();
      final List<IngredientOption> options = bestOptions[0].options;

      expect(bestOptions.length, 1);
      expect(options.length, 1);
      expect(options[0].amount, Amount.volume(dl: 1.toDecimal()));
    });

    test('does not select a bigger bottle than necessary', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(dl: 1.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();
      final List<IngredientOption> options = bestOptions[0].options;

      expect(bestOptions.length, 1);
      expect(options.length, 1);
      expect(options[0].amount, Amount.volume(dl: 1.toDecimal()));
    });

    test('selects medium bottle', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(dl: 5.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();
      final List<IngredientOption> options = bestOptions[0].options;

      expect(bestOptions.length, 1);
      expect(options.length, 1);
      expect(options[0].amount, Amount.volume(dl: 5.toDecimal()));
    });

    test('selects big bottle', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(l: 1.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();
      final List<IngredientOption> options = bestOptions[0].options;

      expect(bestOptions.length, 1);
      expect(options.length, 1);
      expect(options[0].amount, Amount.volume(l: 1.toDecimal()));
    });

    test('selects big and small bottle', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(dl: 11.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();
      final List<IngredientOption> options = bestOptions[0].options;

      expect(bestOptions.length, 1);
      expect(options.length, 2);
      expect(options[0].amount, Amount.volume(l: 1.toDecimal()));
      expect(options[1].amount, Amount.volume(dl: 1.toDecimal()));
    });

    test('selects big and medium bottle', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(dl: 15.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();
      final List<IngredientOption> options = bestOptions[0].options;

      expect(bestOptions.length, 1);
      expect(options.length, 2);
      expect(options[0].amount, Amount.volume(l: 1.toDecimal()));
      expect(options[1].amount, Amount.volume(dl: 5.toDecimal()));
    });

    test('selects tho big bottles', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink',
          name: 'Drink',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(l: 2.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();
      final List<IngredientOption> options = bestOptions[0].options;

      expect(bestOptions.length, 1);
      expect(options.length, 2);
      expect(options[0].amount, Amount.volume(l: 1.toDecimal()));
      expect(options[1].amount, Amount.volume(l: 1.toDecimal()));
    });

    test('selects ingredients for two different drinks', () {
      final IngredientAmounts amounts =
          IngredientAmounts(<Ingredient>[ingredient]);

      amounts.addDrinkList(<Drink>[
        Drink(
          id: 'drink1',
          name: 'Drink1',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
          ],
        ),
        Drink(
          id: 'drink2',
          name: 'Drink2',
          ingredients: <DrinkIngredient>[
            DrinkIngredient(
              id: 'ingredient',
              amount: Amount.volume(cl: 4.toDecimal()),
            ),
          ],
        ),
      ]);

      final List<SelectedAlternatives> bestOptions = amounts.getBestOptions();

      expect(bestOptions.length, 1);
      expect(bestOptions[0].requiredAmount, Amount.volume(cl: 8.toDecimal()));
    });
  });
}
