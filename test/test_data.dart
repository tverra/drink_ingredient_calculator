import 'package:decimal/decimal.dart';
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/amount.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';

List<Drink> getDrinks() {
  return <Drink>[
    Drink(
      id: 'stinky_mary',
      name: 'Stinky Mary',
      ingredients: <DrinkIngredient>[
        DrinkIngredient(
          id: 'underberg',
          amount: Amount.volume(cl: 4.toDecimal()),
        ),
        DrinkIngredient(
          id: 'onion_juice',
          amount: Amount.volume(cl: 4.toDecimal()),
        ),
        DrinkIngredient(
          id: 'alkaline_water',
          amount: Amount.volume(dl: 1.toDecimal()),
        ),
        DrinkIngredient(
          id: 'pickles',
          amount: Amount.pieces(pc: 3.toDecimal()),
        ),
        DrinkIngredient(
          id: 'garlic_clove',
          amount: Amount.pieces(pc: 0.1.toDecimal()),
        ),
      ],
    ),
    Drink(
      id: 'childhood_experiment',
      name: 'Childhood Experiment',
      ingredients: <DrinkIngredient>[
        DrinkIngredient(
          id: 'white_rum',
          amount: Amount.volume(cl: 4.toDecimal()),
        ),
        DrinkIngredient(
          id: 'coca-cola',
          amount: Amount.volume(dl: 1.toDecimal()),
        ),
        DrinkIngredient(
          id: 'love_heart',
          amount: Amount.pieces(pc: 1.toDecimal()),
        ),
      ],
    ),
    Drink(
      id: 'morning_hour',
      name: 'Morning Hour',
      ingredients: <DrinkIngredient>[
        DrinkIngredient(
          id: 'minttu',
          amount: Amount.volume(cl: 4.toDecimal()),
        ),
        DrinkIngredient(
          id: 'fresh_orange_juice',
          amount: Amount.volume(cl: 4.toDecimal()),
        ),
        DrinkIngredient(
          id: 'coffee',
          amount: Amount.volume(cl: 4.toDecimal()),
        ),
        DrinkIngredient(
          id: 'cheese_slice',
          amount: Amount.pieces(pc: 1.toDecimal()),
        ),
      ],
    ),
  ];
}

List<Ingredient> getIngredients() {
  return <Ingredient>[
    Ingredient(
      id: 'underberg',
      name: 'Underberg',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.volume(cl: 6.toDecimal()),
          price: 92.90.toDecimal(),
          type: 'Underberg Bitter (3x2cl)',
        ),
        IngredientOption(
          amount: Amount.volume(cl: 24.toDecimal()),
          price: 312.90.toDecimal(),
          type: 'Underberg Bitter (12x2cl)',
        ),
        IngredientOption(
          amount: Amount.volume(dl: 6.toDecimal()),
          price: 1133.17.toDecimal(),
          type: 'Underberg Bitter (30x2cl)',
        ),
      ],
    ),
    Ingredient(
      id: 'white_rum',
      name: 'White Rum',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.volume(cl: 5.toDecimal()),
          price: 49.90.toDecimal(),
          type: "Havana Club 3 Años",
        ),
        IngredientOption(
          amount: Amount.volume(cl: 35.toDecimal()),
          price: 209.90.toDecimal(),
          type: "Havana Club 3 Años",
        ),
        IngredientOption(
          amount: Amount.volume(dl: 5.toDecimal()),
          price: 284.90.toDecimal(),
          type: "Bacardi Carta Blanca",
        ),
        IngredientOption(
          amount: Amount.volume(dl: 7.toDecimal()),
          price: 379.90.toDecimal(),
          type: "Havana Club 3 Años",
        ),
        IngredientOption(
          amount: Amount.volume(l: 1.toDecimal()),
          price: 519.90.toDecimal(),
          type: "Bacardi Carta Blanca",
        ),
      ],
    ),
    Ingredient(
      id: 'minttu_peppermint',
      name: 'Minttu Peppermint',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.volume(),
          price: 214.90.toDecimal(),
          type: "Minttu Peppermint",
        ),
        IngredientOption(
          amount: Amount.volume(),
          price: 279.90.toDecimal(),
          type: "Minttu Peppermint",
        ),
      ],
    ),
    Ingredient(
      id: 'onion',
      name: 'Onion',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.pieces(pc: 1.toDecimal()),
          price: 3.22.toDecimal(),
          type: 'Onion per kilo',
        ),
      ],
      contains: <Ingredient>[
        Ingredient(
          id: 'onion_juice',
          name: 'Onion Juice',
          updated: DateTime.utc(2022, 9, 11),
          equalsTo: Amount.volume(cl: 2.toDecimal()),
        ),
      ],
    ),
    Ingredient(
      id: 'orange',
      name: 'Orange',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.pieces(pc: 1.toDecimal()),
          price: 10.66.toDecimal(),
          type: "Orange per kilo",
        ),
      ],
      contains: <Ingredient>[
        Ingredient(
          id: 'fresh_orange_juice',
          name: 'Fresh orange juice',
          updated: DateTime.utc(2022, 9, 11),
          equalsTo: Amount.volume(cl: 4.toDecimal()),
        ),
      ],
    ),
    Ingredient(
      id: 'baking_soda',
      name: 'Alkaline Water',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.weight(g: 225.toDecimal()),
          price: 20.90.toDecimal(),
          type: "Coop Bakepulver 225g",
        ),
      ],
      contains: <Ingredient>[
        Ingredient(
          id: 'alkaline_water',
          name: 'Alkaline water',
          updated: DateTime.utc(2022, 9, 11),
          equalsTo: Amount.volume(l: 88.875.toDecimal()),
        ),
      ],
    ),
    Ingredient(
      id: 'coffee_beans',
      name: 'Coffee beans',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.weight(g: 500.toDecimal()),
          price: 114.90.toDecimal(),
          type: "Friele Hel Mørkbrent Frokostkaffe 500g",
        ),
      ],
      contains: <Ingredient>[
        Ingredient(
          id: 'coffee',
          name: 'Coffee',
          updated: DateTime.utc(2022, 9, 11),
          equalsTo: Amount.volume(l: 8.33.toDecimal()),
        ),
      ],
    ),
    Ingredient(
      id: 'coca-cola',
      name: 'Coca-Cola',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.volume(dl: 5.toDecimal()),
          price: 20.90.toDecimal(),
          type: "Coca-Cola 0,5l",
        ),
        IngredientOption(
          amount: Amount.volume(l: 1.5.toDecimal()),
          price: 29.90.toDecimal(),
          type: "Coca-Cola 1,5l",
        ),
        IngredientOption(
          amount: Amount.volume(l: 6.toDecimal()),
          price: 84.90.toDecimal(),
          type: "Coca-Cola 4stk x 1,5l",
        ),
      ],
    ),
    Ingredient(
      id: 'pickle',
      name: 'Pickle',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.pieces(pc: 10.toDecimal()),
          price: 30.70.toDecimal(),
          type: 'Agurker hele 580g Nora',
        ),
      ],
    ),
    Ingredient(
      id: 'garlic',
      name: 'Garlic',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.weight(g: 100.toDecimal()),
          price: 17.90.toDecimal(),
          type: "Coop hvitløk 100g",
        ),
      ],
      contains: <Ingredient>[
        Ingredient(
          id: 'garlic_clove',
          name: 'Garlic Clove',
          updated: DateTime.utc(2022, 9, 11),
          equalsTo: Amount.pieces(pc: 20.toDecimal()),
        ),
      ],
    ),
    Ingredient(
      id: 'love_hearts',
      name: 'Love Hearts',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.pieces(pc: 30.toDecimal()),
          price: 18.50.toDecimal(),
          type: "Swizzels Love Hearts Gian 51g",
        ),
      ],
    ),
    Ingredient(
      id: 'cheese_slices',
      name: 'Cheese Slice',
      updated: DateTime.utc(2022, 9, 11),
      options: <IngredientOption>[
        IngredientOption(
          amount: Amount.pieces(pc: 1.toDecimal()),
          price: 33.90.toDecimal(),
          type: 'Norvegia Skivet 150g',
        ),
        IngredientOption(
          amount: Amount.pieces(pc: 2.toDecimal()),
          price: 56.90.toDecimal(),
          type: 'Norvegia Skivet 300g',
        ),
      ],
      contains: <Ingredient>[
        Ingredient(
          id: 'cheese_slice',
          name: 'Cheese slice',
          updated: DateTime.utc(2022, 9, 11),
          equalsTo: Amount.pieces(pc: 10.toDecimal()),
        ),
      ],
    ),
  ];
}
