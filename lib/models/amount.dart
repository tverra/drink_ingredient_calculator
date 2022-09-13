import 'package:decimal/decimal.dart';
import 'package:drink_calculator/constants.dart';
import 'package:drink_calculator/extensions.dart';
import 'package:intl/intl.dart';

enum AmountType {
  volume,
  weight,
  pieces,
  none,
}

class Amount {
  final Decimal amount;
  final AmountType type;

  Amount(this.amount, this.type)
      : assert(
          amount == Decimal.zero || type != AmountType.none,
          'Values different than zero needs a type',
        );

  Amount.fromInt(int amount, this.type)
      : amount = Decimal.fromInt(amount),
        assert(
          amount == 0 || type != AmountType.none,
          'Values different than zero needs a type',
        );

  Amount.fromDouble(double amount, this.type)
      : amount = amount.toDecimal(),
        assert(
          amount == 0.0 || type != AmountType.none,
          'Values different than zero needs a type',
        );

  Amount.zero(this.type) : amount = Decimal.zero;

  Amount.empty()
      : amount = Decimal.zero,
        type = AmountType.none;

  factory Amount.parse(String amount) {
    final String normalized = amount.replaceAll(' ', '');

    if (_hasUnit(normalized, 'ml')) {
      return Amount(
        _parseDecimal(normalized, 'ml'),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'dash')) {
      return Amount(
        _parseDecimal(normalized, 'dash', dashToMl),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'dashes')) {
      return Amount(
        _parseDecimal(normalized, 'dashes', dashToMl),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'drop')) {
      return Amount(
        _parseDecimal(normalized, 'drop', dropToMl),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'drops')) {
      return Amount(
        _parseDecimal(normalized, 'drops', dropToMl),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'cl')) {
      return Amount(
        _parseDecimal(normalized, 'cl', 10),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'dl')) {
      return Amount(
        _parseDecimal(normalized, 'dl', 100),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'l')) {
      return Amount(
        _parseDecimal(normalized, 'l', 1000),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'pc')) {
      return Amount(
        _parseDecimal(normalized, 'pc'),
        AmountType.pieces,
      );
    } else if (_hasUnit(normalized, 'tsp')) {
      return Amount(
        _parseDecimal(normalized, 'tsp', teaspoonToMl),
        AmountType.volume,
      );
    } else if (_hasUnit(normalized, 'kg')) {
      return Amount(
        _parseDecimal(normalized, 'kg', 1000),
        AmountType.weight,
      );
    } else if (_hasUnit(normalized, 'g')) {
      return Amount(
        _parseDecimal(normalized, 'g'),
        AmountType.weight,
      );
    } else if (_hasUnit(normalized, 'pinch')) {
      return Amount(
        _parseDecimal(normalized, 'pinch', pinchToGrams),
        AmountType.weight,
      );
    } else if (_hasUnit(normalized, 'pinches')) {
      return Amount(
        _parseDecimal(normalized, 'pinches', pinchToGrams),
        AmountType.weight,
      );
    } else {
      throw ArgumentError('The amount is invalid: $normalized');
    }
  }

  factory Amount.sumFromList(List<Amount> amounts) {
    if (amounts.isEmpty) return Amount.empty();

    Amount sum = Amount.zero(amounts[0].type);

    for (final Amount amount in amounts) {
      sum += amount;
    }
    return sum;
  }

  factory Amount.volume({
    Decimal? ml,
    Decimal? cl,
    Decimal? dl,
    Decimal? l,
  }) {
    Decimal sum = Decimal.zero;

    if (ml != null) {
      sum += ml;
    }
    if (cl != null) {
      sum += cl * Decimal.fromInt(10);
    }
    if (dl != null) {
      sum += dl * Decimal.fromInt(100);
    }
    if (l != null) {
      sum += l * Decimal.fromInt(1000);
    }
    return Amount(sum, AmountType.volume);
  }

  factory Amount.weight({Decimal? g, Decimal? kg}) {
    Decimal sum = Decimal.zero;

    if (g != null) {
      sum += g;
    }
    if (kg != null) {
      sum += kg * Decimal.fromInt(1000);
    }
    return Amount(sum, AmountType.weight);
  }

  factory Amount.pieces({Decimal? pc}) {
    if (pc != null) {
      return Amount(pc, AmountType.pieces);
    }
    return Amount.zero(AmountType.pieces);
  }

  bool get isVolume => type == AmountType.volume;

  bool get isWeight => type == AmountType.weight;

  bool get isPieces => type == AmountType.pieces;

  bool get isEmpty => type == AmountType.none;

  bool get isZero => amount == Decimal.zero;

  Decimal get litres {
    if (!isVolume) {
      throw ArgumentError('The amount is not a volume');
    }
    return (amount / Decimal.parse('1000')).toDecimal();
  }

  Decimal get decilitres {
    if (!isVolume) {
      throw ArgumentError('The amount is not a volume');
    }
    return (amount / Decimal.parse('100')).toDecimal();
  }

  Decimal get centilitres {
    if (!isVolume) {
      throw ArgumentError('The amount is not a volume');
    }
    return (amount / Decimal.parse('10')).toDecimal();
  }

  Decimal get millilitres {
    if (!isVolume) {
      throw ArgumentError('The amount is not a volume');
    }
    return amount;
  }

  Decimal get kilos {
    if (!isWeight) {
      throw ArgumentError('The amount is not a weight');
    }
    return (amount / Decimal.parse('1000')).toDecimal();
  }

  Decimal get grams {
    if (!isWeight) {
      throw ArgumentError('The amount is not a weight');
    }
    return amount;
  }

  Decimal get pieces {
    if (!isPieces) {
      throw ArgumentError('The amount is not pieces');
    }
    return amount;
  }

  Amount multiply(int multiplier) {
    return copyWith(amount: amount * Decimal.fromInt(multiplier));
  }

  Amount copyWith({Decimal? amount, AmountType? type}) {
    return Amount(amount ?? this.amount, type ?? this.type);
  }

  @override
  bool operator ==(Object other) {
    return other is Amount && type == other.type && amount == other.amount;
  }

  @override
  int get hashCode => amount.hashCode ^ type.hashCode;

  bool operator <(Object other) {
    if (other is! Amount || !_isSameType(other)) {
      throw ArgumentError("Different types can't be compared");
    }

    if (isEmpty) {
      return other.amount > Decimal.zero;
    } else if (other.isEmpty) {
      return amount < Decimal.zero;
    } else {
      return amount < other.amount;
    }
  }

  bool operator <=(Object other) {
    if (other is! Amount || !_isSameType(other)) {
      throw ArgumentError("Different types can't be compared");
    }

    if (isEmpty) {
      return other.amount >= Decimal.zero;
    } else if (other.isEmpty) {
      return amount <= Decimal.zero;
    } else {
      return amount <= other.amount;
    }
  }

  bool operator >(Object other) {
    if (other is! Amount || !_isSameType(other)) {
      throw ArgumentError("Different types can't be compared");
    }

    if (isEmpty) {
      return other.amount < Decimal.zero;
    } else if (other.isEmpty) {
      return amount > Decimal.zero;
    } else {
      return amount > other.amount;
    }
  }

  bool operator >=(Object other) {
    if (other is! Amount || !_isSameType(other)) {
      throw ArgumentError("Different types can't be compared");
    }

    if (isEmpty) {
      return other.amount <= Decimal.zero;
    } else if (other.isEmpty) {
      return amount >= Decimal.zero;
    } else {
      return amount >= other.amount;
    }
  }

  Amount operator +(Amount other) {
    if (!_isSameType(other)) {
      throw ArgumentError("Different types can't be added together");
    }

    if (isEmpty) {
      return other;
    } else if (other.isEmpty) {
      return this;
    } else {
      return copyWith(amount: amount + other.amount);
    }
  }

  Amount operator -() {
    return copyWith(amount: -amount);
  }

  Amount operator -(Amount other) {
    if (!_isSameType(other)) {
      throw ArgumentError("Different types can't be added together");
    }

    if (isEmpty) {
      return -other;
    } else if (other.isEmpty) {
      return this;
    } else {
      return copyWith(amount: amount - other.amount);
    }
  }

  Amount operator *(Amount other) {
    if (!_isSameType(other)) {
      throw ArgumentError("Different types can't be multiplied by each other");
    }

    if (isEmpty) {
      return other.copyWith(amount: 0.toDecimal());
    } else if (other.isEmpty) {
      return copyWith(amount: 0.toDecimal());
    } else {
      return copyWith(amount: amount * other.amount);
    }
  }

  Amount operator /(Amount other) {
    if (!_isSameType(other)) {
      throw ArgumentError(
        "Different types can't be divided by each other",
      );
    }

    if (other.isEmpty) {
      throw ArgumentError('zero can not be used as denominator');
    } else if (isEmpty) {
      return other.copyWith(amount: 0.toDecimal());
    } else {
      return copyWith(amount: (amount / other.amount).toDecimal());
    }
  }

  bool _isSameType(Amount other) {
    return type == other.type || isEmpty || other.isEmpty;
  }

  @override
  String toString() {
    final NumberFormat format = NumberFormat('#.##', 'en_US');

    if (isPieces) {
      return '${format.format(pieces.toDouble())} pc';
    } else if (isWeight) {
      if (grams >= Decimal.fromInt(1000) || grams <= Decimal.fromInt(-1000)) {
        return '${format.format(kilos.toDouble())} kg';
      } else {
        return '${format.format(grams.toDouble())} g';
      }
    } else if (isVolume) {
      if (millilitres >= Decimal.fromInt(1000) ||
          millilitres <= Decimal.fromInt(-1000)) {
        return '${format.format(litres.toDouble())} l';
      } else if (millilitres >= Decimal.fromInt(100) ||
          millilitres <= Decimal.fromInt(-100)) {
        return '${format.format(decilitres.toDouble())} dl';
      } else if (millilitres >= Decimal.fromInt(10) ||
          millilitres <= Decimal.fromInt(-10)) {
        return '${format.format(centilitres.toDouble())} cl';
      } else {
        return '${format.format(millilitres.toDouble())} ml';
      }
    } else {
      return 'nothing';
    }
  }

  static bool _hasUnit(String amount, String unit) {
    if (amount.length < unit.length) return false;

    final String substring = amount
        .substring(amount.length - unit.length, amount.length)
        .toLowerCase();

    return substring == unit;
  }

  static Decimal _parseDecimal(
    String amount,
    String unit, [
    double multiplier = 1.0,
  ]) {
    final String substring = amount.substring(0, amount.length - unit.length);
    final Decimal? parsed = Decimal.tryParse(substring);

    if (parsed == null) {
      throw ArgumentError("Unable to parse amount: $amount");
    }

    return parsed * Decimal.parse(multiplier.toString());
  }
}
