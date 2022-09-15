import 'package:decimal/decimal.dart';
import 'package:drink_calculator/models/amount.dart';
import 'package:drink_calculator/models/drink.dart';
import 'package:drink_calculator/models/ingredient.dart';

class IngredientAmounts {
  final List<Ingredient> _ingredients;
  final List<Ingredient> _excluded;
  final List<_IngredientAmountItem> _ingredientAmounts =
      <_IngredientAmountItem>[];

  IngredientAmounts(
    List<Ingredient> ingredients, [
    List<Ingredient> excluded = const <Ingredient>[],
  ])  : _ingredients = ingredients,
        _excluded = excluded;

  void addDrinkList(List<Drink> drinks) {
    for (final Drink drink in drinks) {
      for (final DrinkIngredient ingredient in drink.ingredients) {
        if (_excluded
            .where((Ingredient i) => i.id == ingredient.id)
            .isNotEmpty) {
          break;
        }

        final Ingredient match =
            Ingredient.singleMatch(ingredient.id, _ingredients);
        final _IngredientAmountItem? alreadyAddedMatch = _singleMatch(match.id);

        final Amount ingredientAmount = match.convertFrom(ingredient);

        if (alreadyAddedMatch != null) {
          alreadyAddedMatch.addAmount(ingredientAmount);
        } else {
          _ingredientAmounts
              .add(_IngredientAmountItem(match, ingredientAmount));
        }
      }
    }
  }

  void multiply(int multiplier) {
    for (final _IngredientAmountItem item in _ingredientAmounts) {
      item.multiply(multiplier);
    }
  }

  List<SelectedAlternatives> getBestOptions() {
    final List<SelectedAlternatives> selectedAlternatives =
        <SelectedAlternatives>[];

    for (final _IngredientAmountItem ingredientAmount in _ingredientAmounts) {
      final Ingredient ingredient = ingredientAmount.ingredient;
      final List<IngredientOption> selected =
          _selectAlternativesForIngredient(ingredientAmount);

      selectedAlternatives.add(
        SelectedAlternatives(ingredient, ingredientAmount.amount, selected),
      );
    }

    selectedAlternatives.sort((SelectedAlternatives a, SelectedAlternatives b) {
      if (a.requiredAmount.amount > b.requiredAmount.amount) {
        return 1;
      } else if (a.requiredAmount.amount == b.requiredAmount.amount) {
        return 0;
      } else {
        return -1;
      }
    });
    return selectedAlternatives;
  }

  List<IngredientOption> _selectAlternativesForIngredient(
    _IngredientAmountItem ingredientAmount,
  ) {
    final Amount requiredAmount = ingredientAmount.amount;
    final List<IngredientOption>? options = ingredientAmount.ingredient.options;
    final List<IngredientOption> selected = <IngredientOption>[];

    while (options != null &&
        IngredientOption.sumAmount(selected) < requiredAmount) {
      for (int i = 0; i < options.length; i++) {
        final Amount currentSum = IngredientOption.sumAmount(selected);
        final Amount restSum = requiredAmount - currentSum;
        final IngredientOption alternative = options[i];

        if (restSum <= Amount.zero(restSum.type)) {
          break;
        } else if (restSum <= alternative.amount) {
          selected.add(options[i]);
        } else if (i == options.length - 1) {
          selected.add(options[i]);
        } else {
          continue;
        }
      }
    }
    return selected;
  }

  _IngredientAmountItem? _singleMatch(String id) {
    final Iterable<_IngredientAmountItem> matches = _ingredientAmounts
        .where((_IngredientAmountItem i) => i.ingredient.id == id);

    if (matches.isEmpty) {
      return null;
    } else if (matches.length > 1) {
      throw ArgumentError('Duplicate ingredient: $id');
    } else {
      return matches.single;
    }
  }

/*  _IngredientAmountItem? _singleMatch(String id) {
    final List<_IngredientAmountItem> matches = <_IngredientAmountItem>[];

    for (final _IngredientAmountItem item in _ingredientAmounts) {
      final Ingredient ingredient = item.ingredient;
      final List<Ingredient>? contains = ingredient.contains;

      if (ingredient.id == id ||
          (contains != null && Ingredient.matchOnId(id, contains).isNotEmpty)) {
        matches.add(item);
      }
    }

    if (matches.isEmpty) {
      return null;
    } else if (matches.length > 1) {
      throw ArgumentError('Duplicate ingredient: $id');
    } else {
      return matches.single;
    }
  }*/
}

class SelectedAlternatives {
  final Ingredient ingredient;
  final Amount requiredAmount;
  final List<IngredientOption> _options;

  SelectedAlternatives(
    this.ingredient,
    this.requiredAmount,
    List<IngredientOption> alternatives,
  ) : _options = alternatives;

  List<IngredientOption> get options {
    return List<IngredientOption>.from(_options);
  }

  Decimal get sumPrice {
    return _options.fold(
      Decimal.zero,
      (Decimal previous, IngredientOption current) => previous + current.price,
    );
  }

  Amount get sumAmount {
    if (_options.isEmpty) {
      return Amount.empty();
    }

    final List<Amount> amounts =
        _options.map((IngredientOption a) => a.amount).toList();
    return Amount.sumFromList(amounts);
  }
}

class _IngredientAmountItem {
  final Ingredient ingredient;
  Amount _amount;

  _IngredientAmountItem(this.ingredient, Amount amount) : _amount = amount;

  Amount get amount => _amount;

  void addAmount(Amount amount) {
    _amount += amount;
  }

  void multiply(int multiplier) {
    _amount *= Amount(Decimal.fromInt(multiplier), _amount.type);
  }
}
