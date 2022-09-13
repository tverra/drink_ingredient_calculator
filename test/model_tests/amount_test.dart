import 'package:decimal/decimal.dart';
import 'package:drink_calculator/constants.dart';
import 'package:drink_calculator/extensions.dart';
import 'package:drink_calculator/models/amount.dart';
import 'package:test/test.dart';

void main() {
  group('constructors', () {
    test('volume is created with integer value', () {
      final Decimal decimal = Decimal.fromInt(1);
      final Amount amount = Amount(decimal, AmountType.volume);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('weight is created with integer value', () {
      final Decimal decimal = Decimal.fromInt(1);
      final Amount amount = Amount(decimal, AmountType.weight);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('pieces is created with integer value', () {
      final Decimal decimal = Decimal.fromInt(1);
      final Amount amount = Amount(decimal, AmountType.pieces);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.pieces);
    });

    test('amount is created with no type and amount equal to zero', () {
      final Decimal decimal = Decimal.fromInt(0);
      final Amount amount = Amount(decimal, AmountType.none);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.none);
    });

    test("amount bigger than zero needs a type", () {
      final Decimal decimal = Decimal.fromInt(1);

      expect(
        () => Amount(decimal, AmountType.none),
        throwsA(isA<AssertionError>()),
      );
    });

    test("amount less than zero needs a type", () {
      final Decimal decimal = Decimal.fromInt(-1);

      expect(
        () => Amount(decimal, AmountType.none),
        throwsA(isA<AssertionError>()),
      );
    });

    test('volume is created with double value', () {
      final Decimal decimal = Decimal.parse('199.90');
      final Amount amount = Amount(decimal, AmountType.volume);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('weight is created with double value', () {
      final Decimal decimal = Decimal.parse('199.90');
      final Amount amount = Amount(decimal, AmountType.weight);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('pieces is created with double value', () {
      final Decimal decimal = Decimal.parse('199.90');
      final Amount amount = Amount(decimal, AmountType.pieces);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.pieces);
    });

    test('volume from int is created with integer value', () {
      final Amount amount = Amount.fromInt(1, AmountType.volume);

      expect(amount.amount, Decimal.fromInt(1));
      expect(amount.type, AmountType.volume);
    });

    test('weight from int is created with integer value', () {
      final Amount amount = Amount.fromInt(1, AmountType.weight);

      expect(amount.amount, Decimal.fromInt(1));
      expect(amount.type, AmountType.weight);
    });

    test('pieces from int is created with integer value', () {
      final Amount amount = Amount.fromInt(1, AmountType.pieces);

      expect(amount.amount, Decimal.fromInt(1));
      expect(amount.type, AmountType.pieces);
    });

    test('amount from int is created with no type and amount equal to zero',
        () {
      final Amount amount = Amount.fromInt(0, AmountType.none);

      expect(amount.amount, Decimal.fromInt(0));
      expect(amount.type, AmountType.none);
    });

    test("amount from int bigger than zero needs a type", () {
      expect(
        () => Amount.fromInt(1, AmountType.none),
        throwsA(isA<AssertionError>()),
      );
    });

    test("amount from int less than zero needs a type", () {
      expect(
        () => Amount.fromInt(-1, AmountType.none),
        throwsA(isA<AssertionError>()),
      );
    });

    test('volume from double is created with double value', () {
      final Amount amount = Amount.fromDouble(1.5, AmountType.volume);

      expect(amount.amount, Decimal.parse('1.5'));
      expect(amount.type, AmountType.volume);
    });

    test('weight from double is created with double value', () {
      final Amount amount = Amount.fromDouble(1.5, AmountType.weight);

      expect(amount.amount, Decimal.parse('1.5'));
      expect(amount.type, AmountType.weight);
    });

    test('pieces from double is created with double value', () {
      final Amount amount = Amount.fromDouble(1.5, AmountType.pieces);

      expect(amount.amount, Decimal.parse('1.5'));
      expect(amount.type, AmountType.pieces);
    });

    test('amount from double is created with no type and amount equal to zero',
        () {
      final Amount amount = Amount.fromDouble(0.0, AmountType.none);

      expect(amount.amount, Decimal.parse('0.0'));
      expect(amount.type, AmountType.none);
    });

    test("amount from double bigger than zero needs a type", () {
      expect(
        () => Amount.fromDouble(1.5, AmountType.none),
        throwsA(isA<AssertionError>()),
      );
    });

    test("amount from double less than zero needs a type", () {
      expect(
        () => Amount.fromDouble(-1.5, AmountType.none),
        throwsA(isA<AssertionError>()),
      );
    });

    test('doubles are truncated to ten decimal places', () {
      final Amount amount =
          Amount.fromDouble(1.12345678912345, AmountType.volume);

      expect(amount.amount, Decimal.parse('1.1234567891'));
      expect(amount.type, AmountType.volume);
    });

    test('volume is created with zero constructor', () {
      final Decimal decimal = Decimal.zero;
      final Amount amount = Amount.zero(AmountType.volume);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('weight is created with zero constructor', () {
      final Decimal decimal = Decimal.zero;
      final Amount amount = Amount.zero(AmountType.weight);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('pieces is created with zero constructor', () {
      final Decimal decimal = Decimal.zero;
      final Amount amount = Amount.zero(AmountType.pieces);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.pieces);
    });

    test('empty amount is created with empty constructor', () {
      final Decimal decimal = Decimal.zero;
      final Amount amount = Amount.empty();

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.none);
    });
  });

  group('parse factory', () {
    test('positive integer is parsed as ml', () {
      final Amount amount = Amount.parse('1 ml');
      final Decimal decimal = Decimal.fromInt(1);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as ml', () {
      final Amount amount = Amount.parse('-1 ml');
      final Decimal decimal = Decimal.fromInt(-1);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as ml', () {
      final Amount amount = Amount.parse('499.90 ml');
      final Decimal decimal = Decimal.parse('499.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as ml', () {
      final Amount amount = Amount.parse('-499.90 ml');
      final Decimal decimal = Decimal.parse('-499.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as dash', () {
      final Amount amount = Amount.parse('1 dash');
      final Decimal decimal = Decimal.parse((1 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as dash', () {
      final Amount amount = Amount.parse('-1 dash');
      final Decimal decimal = Decimal.parse((-1 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as dash', () {
      final Amount amount = Amount.parse('499.90 dash');
      final Decimal decimal = Decimal.parse((499.90 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as dash', () {
      final Amount amount = Amount.parse('-499.90 dash');
      final Decimal decimal = Decimal.parse((-499.90 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as dashes', () {
      final Amount amount = Amount.parse('2 dashes');
      final Decimal decimal = Decimal.parse((2 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as dashes', () {
      final Amount amount = Amount.parse('-2 dashes');
      final Decimal decimal = Decimal.parse((-2 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as dashes', () {
      final Amount amount = Amount.parse('499.90 dashes');
      final Decimal decimal = Decimal.parse((499.90 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as dashes', () {
      final Amount amount = Amount.parse('-499.90 dashes');
      final Decimal decimal = Decimal.parse((-499.90 * dashToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as drop', () {
      final Amount amount = Amount.parse('1 drop');
      final Decimal decimal = Decimal.parse((1.00 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as drop', () {
      final Amount amount = Amount.parse('-1 drop');
      final Decimal decimal = Decimal.parse((-1 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as drop', () {
      final Amount amount = Amount.parse('499.90 drop');
      final Decimal decimal = Decimal.parse((499.90 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as drop', () {
      final Amount amount = Amount.parse('-499.90 drop');
      final Decimal decimal = Decimal.parse((-499.90 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as drops', () {
      final Amount amount = Amount.parse('2 drops');
      final Decimal decimal = Decimal.parse((2 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as drops', () {
      final Amount amount = Amount.parse('-2 drops');
      final Decimal decimal = Decimal.parse((-2 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as drops', () {
      final Amount amount = Amount.parse('499.90 drops');
      final Decimal decimal = Decimal.parse((499.90 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as drops', () {
      final Amount amount = Amount.parse('-499.90 drops');
      final Decimal decimal = Decimal.parse((-499.90 * dropToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as cl', () {
      final Amount amount = Amount.parse('1 cl');
      final Decimal decimal = Decimal.fromInt(10);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as cl', () {
      final Amount amount = Amount.parse('-1 cl');
      final Decimal decimal = Decimal.fromInt(-10);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as cl', () {
      final Amount amount = Amount.parse('499.99 cl');
      final Decimal decimal = Decimal.parse('4999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as cl', () {
      final Amount amount = Amount.parse('-499.99 cl');
      final Decimal decimal = Decimal.parse('-4999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as dl', () {
      final Amount amount = Amount.parse('1 dl');
      final Decimal decimal = Decimal.fromInt(100);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as dl', () {
      final Amount amount = Amount.parse('-1 dl');
      final Decimal decimal = Decimal.fromInt(-100);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as dl', () {
      final Amount amount = Amount.parse('499.999 dl');
      final Decimal decimal = Decimal.parse('49999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as dl', () {
      final Amount amount = Amount.parse('-499.999 dl');
      final Decimal decimal = Decimal.parse('-49999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as l', () {
      final Amount amount = Amount.parse('1 l');
      final Decimal decimal = Decimal.fromInt(1000);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as l', () {
      final Amount amount = Amount.parse('-1 l');
      final Decimal decimal = Decimal.fromInt(-1000);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as l', () {
      final Amount amount = Amount.parse('499.9999 l');
      final Decimal decimal = Decimal.parse('499999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as l', () {
      final Amount amount = Amount.parse('-499.9999 l');
      final Decimal decimal = Decimal.parse('-499999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as l', () {
      final Amount amount = Amount.parse('1 l');
      final Decimal decimal = Decimal.fromInt(1000);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as l', () {
      final Amount amount = Amount.parse('-1 l');
      final Decimal decimal = Decimal.fromInt(-1000);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as l', () {
      final Amount amount = Amount.parse('499.9999 l');
      final Decimal decimal = Decimal.parse('499999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as l', () {
      final Amount amount = Amount.parse('-499.9999 l');
      final Decimal decimal = Decimal.parse('-499999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as pc', () {
      final Amount amount = Amount.parse('1 pc');
      final Decimal decimal = Decimal.fromInt(1);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.pieces);
    });

    test('negative integer is parsed as pc', () {
      final Amount amount = Amount.parse('-1 pc');
      final Decimal decimal = Decimal.fromInt(-1);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.pieces);
    });

    test('positive double is parsed as pc', () {
      final Amount amount = Amount.parse('499.90 pc');
      final Decimal decimal = Decimal.parse('499.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.pieces);
    });

    test('negative double is parsed as pc', () {
      final Amount amount = Amount.parse('-499.90 pc');
      final Decimal decimal = Decimal.parse('-499.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.pieces);
    });

    test('positive integer is parsed as tsp', () {
      final Amount amount = Amount.parse('1 tsp');
      final Decimal decimal = Decimal.parse((1 * teaspoonToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative integer is parsed as tsp', () {
      final Amount amount = Amount.parse('-1 tsp');
      final Decimal decimal = Decimal.parse((-1 * teaspoonToMl).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive double is parsed as tsp', () {
      final Amount amount = Amount.parse('499.90 tsp');
      final Decimal decimal =
          Decimal.parse((499.90 * teaspoonToMl).toStringAsFixed(3));

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('negative double is parsed as tsp', () {
      final Amount amount = Amount.parse('-499.90 tsp');
      final Decimal decimal =
          Decimal.parse((-499.90 * teaspoonToMl).toStringAsFixed(3));

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });

    test('positive integer is parsed as kg', () {
      final Amount amount = Amount.parse('1 kg');
      final Decimal decimal = Decimal.fromInt(1000);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative integer is parsed as kg', () {
      final Amount amount = Amount.parse('-1 kg');
      final Decimal decimal = Decimal.fromInt(-1000);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('positive double is parsed as kg', () {
      final Amount amount = Amount.parse('499.9999 kg');
      final Decimal decimal = Decimal.parse('499999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative double is parsed as kg', () {
      final Amount amount = Amount.parse('-499.9999 kg');
      final Decimal decimal = Decimal.parse('-499999.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('positive integer is parsed as g', () {
      final Amount amount = Amount.parse('1 g');
      final Decimal decimal = Decimal.fromInt(1);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative integer is parsed as g', () {
      final Amount amount = Amount.parse('-1 g');
      final Decimal decimal = Decimal.fromInt(-1);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('positive double is parsed as g', () {
      final Amount amount = Amount.parse('499.90 g');
      final Decimal decimal = Decimal.parse('499.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative double is parsed as g', () {
      final Amount amount = Amount.parse('-499.90 g');
      final Decimal decimal = Decimal.parse('-499.90');

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('positive integer is parsed as pinch', () {
      final Amount amount = Amount.parse('1 pinch');
      final Decimal decimal = Decimal.parse((1 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative integer is parsed as pinch', () {
      final Amount amount = Amount.parse('-1 pinch');
      final Decimal decimal = Decimal.parse((-1 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('positive double is parsed as pinch', () {
      final Amount amount = Amount.parse('499.90 pinch');
      final Decimal decimal = Decimal.parse((499.90 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative double is parsed as pinch', () {
      final Amount amount = Amount.parse('-499.90 pinch');
      final Decimal decimal =
          Decimal.parse((-499.90 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('positive integer is parsed as pinches', () {
      final Amount amount = Amount.parse('1 pinches');
      final Decimal decimal = Decimal.parse((1 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative integer is parsed as pinches', () {
      final Amount amount = Amount.parse('-1 pinches');
      final Decimal decimal = Decimal.parse((-1 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('positive double is parsed as pinches', () {
      final Amount amount = Amount.parse('499.90 pinches');
      final Decimal decimal = Decimal.parse((499.90 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('negative double is parsed as pinches', () {
      final Amount amount = Amount.parse('-499.90 pinches');
      final Decimal decimal =
          Decimal.parse((-499.90 * pinchToGrams).toString());

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.weight);
    });

    test('throws error if the unit is invalid', () {
      expect(
        () => Amount.parse('1 stk'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error if the string is empty', () {
      expect(
        () => Amount.parse(''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error if the unit is missing', () {
      expect(
        () => Amount.parse('1'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error if the number is invalid', () {
      expect(
        () => Amount.parse('1# l'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('parsing is insensitive to whitespaces', () {
      final Amount amount = Amount.parse('    1  0 00   m  l         ');
      final Decimal decimal = Decimal.fromInt(1000);

      expect(amount.amount, decimal);
      expect(amount.type, AmountType.volume);
    });
  });

  group('sumFromList factory', () {
    test('returns the sum of the given amounts', () {
      final List<Amount> amounts = <Amount>[];

      for (int i = 0; i < 10; i++) {
        amounts.add(Amount.fromInt(i, AmountType.volume));
      }

      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.fromInt(45));
    });

    test('returns empty amount if empty list is given', () {
      final List<Amount> amounts = <Amount>[];
      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.zero);
      expect(amount.type, AmountType.none);
    });

    test('returns volume if the list contains volumes', () {
      final List<Amount> amounts = <Amount>[];

      for (int i = 0; i < 10; i++) {
        amounts.add(Amount.fromInt(i, AmountType.volume));
      }

      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.fromInt(45));
      expect(amount.type, AmountType.volume);
    });

    test('returns weight if the list contains weights', () {
      final List<Amount> amounts = <Amount>[];

      for (int i = 0; i < 10; i++) {
        amounts.add(Amount.fromInt(i, AmountType.weight));
      }

      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.fromInt(45));
      expect(amount.type, AmountType.weight);
    });

    test('returns pieces if the list contains pieces', () {
      final List<Amount> amounts = <Amount>[];

      for (int i = 0; i < 10; i++) {
        amounts.add(Amount.fromInt(i, AmountType.pieces));
      }

      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.fromInt(45));
      expect(amount.type, AmountType.pieces);
    });

    test('throws error if the list contains different types', () {
      final List<Amount> amounts = <Amount>[
        Amount.fromInt(10, AmountType.pieces),
        Amount.fromInt(10, AmountType.volume),
        Amount.fromInt(10, AmountType.pieces),
      ];

      expect(
        () => Amount.sumFromList(amounts),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amounts are counted as zero', () {
      final List<Amount> amounts = <Amount>[
        Amount.fromInt(10, AmountType.pieces),
        Amount.empty(),
        Amount.fromInt(10, AmountType.pieces),
      ];

      expect(
        Amount.sumFromList(amounts),
        Amount.fromInt(20, AmountType.pieces),
      );
    });

    test('sums only one item', () {
      final List<Amount> amounts = <Amount>[
        Amount.fromInt(10, AmountType.volume),
      ];

      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.fromInt(10));
      expect(amount.type, AmountType.volume);
    });

    test('sums items with zero amount', () {
      final List<Amount> amounts = <Amount>[];

      for (int i = 0; i < 10; i++) {
        amounts.add(Amount.zero(AmountType.weight));
      }

      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.fromInt(0));
      expect(amount.type, AmountType.weight);
    });

    test('sums empty items', () {
      final List<Amount> amounts = <Amount>[];

      for (int i = 0; i < 10; i++) {
        amounts.add(Amount.empty());
      }

      final Amount amount = Amount.sumFromList(amounts);

      expect(amount.amount, Decimal.fromInt(0));
      expect(amount.type, AmountType.none);
    });
  });

  group('volume factory', () {
    test('adds positive integer as millilitres', () {
      final Amount amount = Amount.volume(ml: 4.toDecimal());
      expect(amount.amount, 4.toDecimal());
    });

    test('adds negative integer as millilitres', () {
      final Amount amount = Amount.volume(ml: -4.toDecimal());
      expect(amount.amount, -4.toDecimal());
    });

    test('adds decimal number as millilitres', () {
      final Amount amount = Amount.volume(ml: 4.4.toDecimal());
      expect(amount.amount, 4.4.toDecimal());
    });

    test('adds zero millilitres', () {
      final Amount amount = Amount.volume(ml: Decimal.zero);
      expect(amount.amount, Decimal.zero);
    });

    test('adds positive integer as centilitres', () {
      final Amount amount = Amount.volume(cl: 4.toDecimal());
      expect(amount.amount, 40.toDecimal());
    });

    test('adds negative integer as centilitres', () {
      final Amount amount = Amount.volume(cl: -4.toDecimal());
      expect(amount.amount, -40.toDecimal());
    });

    test('adds decimal number as centilitres', () {
      final Amount amount = Amount.volume(cl: 4.44.toDecimal());
      expect(amount.amount, 44.4.toDecimal());
    });

    test('adds zero centilitres', () {
      final Amount amount = Amount.volume(cl: Decimal.zero);
      expect(amount.amount, Decimal.zero);
    });

    test('adds positive integer as decilitres', () {
      final Amount amount = Amount.volume(dl: 4.toDecimal());
      expect(amount.amount, 400.toDecimal());
    });

    test('adds negative integer as decilitres', () {
      final Amount amount = Amount.volume(dl: -4.toDecimal());
      expect(amount.amount, -400.toDecimal());
    });

    test('adds decimal number as decilitres', () {
      final Amount amount = Amount.volume(dl: 4.444.toDecimal());
      expect(amount.amount, 444.4.toDecimal());
    });

    test('adds zero decilitres', () {
      final Amount amount = Amount.volume(dl: Decimal.zero);
      expect(amount.amount, Decimal.zero);
    });

    test('adds positive integer as litres', () {
      final Amount amount = Amount.volume(l: 4.toDecimal());
      expect(amount.amount, 4000.toDecimal());
    });

    test('adds negative integer as litres', () {
      final Amount amount = Amount.volume(l: -4.toDecimal());
      expect(amount.amount, -4000.toDecimal());
    });

    test('adds decimal number as litres', () {
      final Amount amount = Amount.volume(l: 4.4444.toDecimal());
      expect(amount.amount, 4444.4.toDecimal());
    });

    test('adds zero litres', () {
      final Amount amount = Amount.volume(l: Decimal.zero);
      expect(amount.amount, Decimal.zero);
    });

    test('adding nothing returns amount', () {
      final Amount amount = Amount.volume();
      expect(amount.amount, Decimal.zero);
    });

    test('all the different values are added', () {
      final Amount amount = Amount.volume(
        ml: 4.toDecimal(),
        cl: 3.toDecimal(),
        dl: 2.toDecimal(),
        l: 1.toDecimal(),
      );

      expect(amount.amount, 1234.toDecimal());
    });

    test('returned amount is volume', () {
      final Amount amount = Amount.volume(ml: 224244.toDecimal());
      expect(amount.type, AmountType.volume);
    });
  });

  group('weight factory', () {
    test('adds positive integer as grams', () {
      final Amount amount = Amount.weight(g: 4.toDecimal());
      expect(amount.amount, 4.toDecimal());
    });

    test('adds negative integer as grams', () {
      final Amount amount = Amount.weight(g: -4.toDecimal());
      expect(amount.amount, -4.toDecimal());
    });

    test('adds decimal number as grams', () {
      final Amount amount = Amount.weight(g: 4.4.toDecimal());
      expect(amount.amount, 4.4.toDecimal());
    });

    test('adds zero grams', () {
      final Amount amount = Amount.weight(g: Decimal.zero);
      expect(amount.amount, Decimal.zero);
    });

    test('adds positive integer as kilos', () {
      final Amount amount = Amount.weight(kg: 4.toDecimal());
      expect(amount.amount, 4000.toDecimal());
    });

    test('adds negative integer as kilos', () {
      final Amount amount = Amount.weight(kg: -4.toDecimal());
      expect(amount.amount, -4000.toDecimal());
    });

    test('adds decimal number as kilos', () {
      final Amount amount = Amount.weight(kg: 4.4444.toDecimal());
      expect(amount.amount, 4444.4.toDecimal());
    });

    test('adds zero kilos', () {
      final Amount amount = Amount.weight(kg: Decimal.zero);
      expect(amount.amount, Decimal.zero);
    });

    test('adding nothing returns amount', () {
      final Amount amount = Amount.weight();
      expect(amount.amount, Decimal.zero);
    });

    test('all the different values are added', () {
      final Amount amount =
          Amount.weight(g: 34.toDecimal(), kg: 1.2.toDecimal());

      expect(amount.amount, 1234.toDecimal());
    });

    test('returned amount is weight', () {
      final Amount amount = Amount.weight(g: 224244.toDecimal());
      expect(amount.type, AmountType.weight);
    });
  });

  group('pieces factory', () {
    test('adds positive integer as pieces', () {
      final Amount amount = Amount.pieces(pc: 4.toDecimal());
      expect(amount.amount, 4.toDecimal());
    });

    test('adds negative integer as pieces', () {
      final Amount amount = Amount.pieces(pc: -4.toDecimal());
      expect(amount.amount, -4.toDecimal());
    });

    test('adds decimal number as pieces', () {
      final Amount amount = Amount.pieces(pc: 4.4.toDecimal());
      expect(amount.amount, 4.4.toDecimal());
    });

    test('adds zero pieces', () {
      final Amount amount = Amount.pieces(pc: Decimal.zero);
      expect(amount.amount, Decimal.zero);
    });

    test('adding nothing returns amount', () {
      final Amount amount = Amount.pieces();
      expect(amount.amount, Decimal.zero);
    });

    test('all the different values are added', () {
      final Amount amount = Amount.pieces(pc: 1234.toDecimal());

      expect(amount.amount, 1234.toDecimal());
    });

    test('returned amount is pieces', () {
      final Amount amount = Amount.pieces(pc: 224244.toDecimal());
      expect(amount.type, AmountType.pieces);
    });
  });

  group('getters', () {
    test('returns true only on isVolume if amount is volume', () {
      final Amount amount = Amount.fromInt(1, AmountType.volume);

      expect(amount.isVolume, true);
      expect(amount.isWeight, false);
      expect(amount.isPieces, false);
      expect(amount.isEmpty, false);
    });

    test('returns true only on isWeight if amount is weight', () {
      final Amount amount = Amount.fromInt(1, AmountType.weight);

      expect(amount.isVolume, false);
      expect(amount.isWeight, true);
      expect(amount.isPieces, false);
      expect(amount.isEmpty, false);
    });

    test('returns true only on isPieces if amount is pieces', () {
      final Amount amount = Amount.fromInt(1, AmountType.pieces);

      expect(amount.isVolume, false);
      expect(amount.isWeight, false);
      expect(amount.isPieces, true);
      expect(amount.isEmpty, false);
    });

    test('returns true only on isEmpty if amount is empty', () {
      final Amount amount = Amount.empty();

      expect(amount.isVolume, false);
      expect(amount.isWeight, false);
      expect(amount.isPieces, false);
      expect(amount.isEmpty, true);
    });

    test('returns true on isZero only if amount is zero', () {
      final Amount zeroAmount = Amount.zero(AmountType.volume);
      final Amount nonZeroPositiveAmount = Amount.fromInt(1, AmountType.volume);
      final Amount nonZeroNegativeAmount =
          Amount.fromInt(-1, AmountType.volume);

      expect(zeroAmount.isZero, true);
      expect(nonZeroPositiveAmount.isZero, false);
      expect(nonZeroNegativeAmount.isZero, false);
    });

    test('returns litres on positive integer', () {
      final Amount amount = Amount.fromInt(1000, AmountType.volume);
      expect(amount.litres, Decimal.fromInt(1));
    });

    test('returns litres on negative integer', () {
      final Amount amount = Amount.fromInt(-10, AmountType.volume);
      expect(amount.litres, Decimal.parse('-0.01'));
    });

    test('returns litres on positive double', () {
      final Amount amount = Amount.fromDouble(1550.690, AmountType.volume);
      expect(amount.litres, Decimal.parse('1.55069'));
    });

    test('returns litres on negative double', () {
      final Amount amount = Amount.fromDouble(-1.690, AmountType.volume);
      expect(amount.litres, Decimal.parse('-0.00169'));
    });

    test('returns litres on zero amount', () {
      final Amount amount = Amount.zero(AmountType.volume);
      expect(amount.litres, Decimal.fromInt(0));
    });

    test("throws error on litres if not volume", () {
      final Amount weight = Amount.fromInt(1000, AmountType.weight);
      final Amount pieces = Amount.fromInt(1000, AmountType.pieces);
      final Amount empty = Amount.empty();

      expect(() => weight.litres, throwsA(isA<ArgumentError>()));
      expect(() => pieces.litres, throwsA(isA<ArgumentError>()));
      expect(() => empty.litres, throwsA(isA<ArgumentError>()));
    });

    test('returns decilitres on positive integer', () {
      final Amount amount = Amount.fromInt(1000, AmountType.volume);
      expect(amount.decilitres, Decimal.fromInt(10));
    });

    test('returns decilitres on negative integer', () {
      final Amount amount = Amount.fromInt(-10, AmountType.volume);
      expect(amount.decilitres, Decimal.parse('-0.1'));
    });

    test('returns decilitres on positive double', () {
      final Amount amount = Amount.fromDouble(1550.690, AmountType.volume);
      expect(amount.decilitres, Decimal.parse('15.5069'));
    });

    test('returns decilitres on negative double', () {
      final Amount amount = Amount.fromDouble(-1.690, AmountType.volume);
      expect(amount.decilitres, Decimal.parse('-00.0169'));
    });

    test('returns decilitres on zero amount', () {
      final Amount amount = Amount.zero(AmountType.volume);
      expect(amount.decilitres, Decimal.fromInt(0));
    });

    test("throws error on decilitres if not volume", () {
      final Amount weight = Amount.fromInt(1000, AmountType.weight);
      final Amount pieces = Amount.fromInt(1000, AmountType.pieces);
      final Amount empty = Amount.empty();

      expect(() => weight.decilitres, throwsA(isA<ArgumentError>()));
      expect(() => pieces.decilitres, throwsA(isA<ArgumentError>()));
      expect(() => empty.decilitres, throwsA(isA<ArgumentError>()));
    });

    test('returns centilitres on positive integer', () {
      final Amount amount = Amount.fromInt(1000, AmountType.volume);
      expect(amount.centilitres, Decimal.fromInt(100));
    });

    test('returns centilitres on negative integer', () {
      final Amount amount = Amount.fromInt(-10, AmountType.volume);
      expect(amount.centilitres, Decimal.parse('-1'));
    });

    test('returns centilitres on positive double', () {
      final Amount amount = Amount.fromDouble(1550.690, AmountType.volume);
      expect(amount.centilitres, Decimal.parse('155.069'));
    });

    test('returns centilitres on negative double', () {
      final Amount amount = Amount.fromDouble(-1.690, AmountType.volume);
      expect(amount.centilitres, Decimal.parse('-0.169'));
    });

    test('returns centilitres on zero amount', () {
      final Amount amount = Amount.zero(AmountType.volume);
      expect(amount.decilitres, Decimal.fromInt(0));
    });

    test("throws error on centilitres if not volume", () {
      final Amount weight = Amount.fromInt(1000, AmountType.weight);
      final Amount pieces = Amount.fromInt(1000, AmountType.pieces);
      final Amount empty = Amount.empty();

      expect(() => weight.centilitres, throwsA(isA<ArgumentError>()));
      expect(() => pieces.centilitres, throwsA(isA<ArgumentError>()));
      expect(() => empty.centilitres, throwsA(isA<ArgumentError>()));
    });

    test('returns millilitres on positive integer', () {
      final Amount amount = Amount.fromInt(1000, AmountType.volume);
      expect(amount.millilitres, Decimal.fromInt(1000));
    });

    test('returns millilitres on negative integer', () {
      final Amount amount = Amount.fromInt(-10, AmountType.volume);
      expect(amount.millilitres, Decimal.parse('-10'));
    });

    test('returns millilitres on positive double', () {
      final Amount amount = Amount.fromDouble(1550.690, AmountType.volume);
      expect(amount.millilitres, Decimal.parse('1550.69'));
    });

    test('returns millilitres on negative double', () {
      final Amount amount = Amount.fromDouble(-1.690, AmountType.volume);
      expect(amount.millilitres, Decimal.parse('-1.69'));
    });

    test('returns millilitres on zero amount', () {
      final Amount amount = Amount.zero(AmountType.volume);
      expect(amount.millilitres, Decimal.fromInt(0));
    });

    test("throws error on millilitres if not volume", () {
      final Amount weight = Amount.fromInt(1000, AmountType.weight);
      final Amount pieces = Amount.fromInt(1000, AmountType.pieces);
      final Amount empty = Amount.empty();

      expect(() => weight.millilitres, throwsA(isA<ArgumentError>()));
      expect(() => pieces.millilitres, throwsA(isA<ArgumentError>()));
      expect(() => empty.millilitres, throwsA(isA<ArgumentError>()));
    });

    test('returns kilos on positive integer', () {
      final Amount amount = Amount.fromInt(1000, AmountType.weight);
      expect(amount.kilos, Decimal.fromInt(1));
    });

    test('returns kilos on negative integer', () {
      final Amount amount = Amount.fromInt(-10, AmountType.weight);
      expect(amount.kilos, Decimal.parse('-0.010'));
    });

    test('returns kilos on positive double', () {
      final Amount amount = Amount.fromDouble(1550.690, AmountType.weight);
      expect(amount.kilos, Decimal.parse('1.55069'));
    });

    test('returns kilos on negative double', () {
      final Amount amount = Amount.fromDouble(-1.690, AmountType.weight);
      expect(amount.kilos, Decimal.parse('-0.00169'));
    });

    test('returns kilos on zero amount', () {
      final Amount amount = Amount.zero(AmountType.weight);
      expect(amount.kilos, Decimal.fromInt(0));
    });

    test("throws error on kilos if not weight", () {
      final Amount volume = Amount.fromInt(1000, AmountType.volume);
      final Amount pieces = Amount.fromInt(1000, AmountType.pieces);
      final Amount empty = Amount.empty();

      expect(() => volume.kilos, throwsA(isA<ArgumentError>()));
      expect(() => pieces.kilos, throwsA(isA<ArgumentError>()));
      expect(() => empty.kilos, throwsA(isA<ArgumentError>()));
    });

    test('returns grams on positive integer', () {
      final Amount amount = Amount.fromInt(1000, AmountType.weight);
      expect(amount.grams, Decimal.fromInt(1000));
    });

    test('returns grams on negative integer', () {
      final Amount amount = Amount.fromInt(-10, AmountType.weight);
      expect(amount.grams, Decimal.parse('-10'));
    });

    test('returns grams on positive double', () {
      final Amount amount = Amount.fromDouble(1550.690, AmountType.weight);
      expect(amount.grams, Decimal.parse('1550.69'));
    });

    test('returns grams on negative double', () {
      final Amount amount = Amount.fromDouble(-1.690, AmountType.weight);
      expect(amount.grams, Decimal.parse('-1.69'));
    });

    test('returns grams on zero amount', () {
      final Amount amount = Amount.zero(AmountType.weight);
      expect(amount.grams, Decimal.fromInt(0));
    });

    test("throws error on grams if not weight", () {
      final Amount volume = Amount.fromInt(1000, AmountType.volume);
      final Amount pieces = Amount.fromInt(1000, AmountType.pieces);
      final Amount empty = Amount.empty();

      expect(() => volume.grams, throwsA(isA<ArgumentError>()));
      expect(() => pieces.grams, throwsA(isA<ArgumentError>()));
      expect(() => empty.grams, throwsA(isA<ArgumentError>()));
    });

    test('returns pieces on positive integer', () {
      final Amount amount = Amount.fromInt(1000, AmountType.pieces);
      expect(amount.pieces, Decimal.fromInt(1000));
    });

    test('returns pieces on negative integer', () {
      final Amount amount = Amount.fromInt(-10, AmountType.pieces);
      expect(amount.pieces, Decimal.parse('-10'));
    });

    test('returns pieces on positive double', () {
      final Amount amount = Amount.fromDouble(1550.690, AmountType.pieces);
      expect(amount.pieces, Decimal.parse('1550.69'));
    });

    test('returns pieces on negative double', () {
      final Amount amount = Amount.fromDouble(-1.690, AmountType.pieces);
      expect(amount.pieces, Decimal.parse('-1.69'));
    });

    test('returns pieces on zero amount', () {
      final Amount amount = Amount.zero(AmountType.pieces);
      expect(amount.pieces, Decimal.fromInt(0));
    });

    test("throws error on pieces if not pieces", () {
      final Amount volume = Amount.fromInt(1000, AmountType.volume);
      final Amount weight = Amount.fromInt(1000, AmountType.weight);
      final Amount empty = Amount.empty();

      expect(() => volume.pieces, throwsA(isA<ArgumentError>()));
      expect(() => weight.pieces, throwsA(isA<ArgumentError>()));
      expect(() => empty.pieces, throwsA(isA<ArgumentError>()));
    });
  });

  group('modifiers', () {
    test('volume integer is multiplied', () {
      final Amount amount = Amount.fromInt(10, AmountType.volume);
      final Amount modified = amount.multiply(10);

      expect(modified.amount, Decimal.fromInt(100));
      expect(amount.type, AmountType.volume);
    });

    test('weight integer is multiplied', () {
      final Amount amount = Amount.fromInt(10, AmountType.weight);
      final Amount modified = amount.multiply(-10);

      expect(modified.amount, Decimal.fromInt(-100));
      expect(amount.type, AmountType.weight);
    });

    test('pieces integer is multiplied', () {
      final Amount amount = Amount.fromInt(-10, AmountType.pieces);
      final Amount modified = amount.multiply(10);

      expect(modified.amount, Decimal.fromInt(-100));
      expect(amount.type, AmountType.pieces);
    });

    test('zero amount is multiplied', () {
      final Amount amount = Amount.zero(AmountType.volume);
      final Amount modified = amount.multiply(10);

      expect(modified.amount, Decimal.zero);
      expect(amount.type, AmountType.volume);
    });

    test('empty amount is multiplied', () {
      final Amount amount = Amount.empty();
      final Amount modified = amount.multiply(10);

      expect(modified.amount, Decimal.zero);
      expect(amount.type, AmountType.none);
    });

    test('original amount is not modified', () {
      final Amount amount = Amount.fromInt(10, AmountType.volume);
      amount.multiply(10);

      expect(amount.amount, Decimal.fromInt(10));
    });

    test('values are copied', () {
      final Amount amount = Amount.fromInt(10, AmountType.volume);
      final Amount copy = amount.copyWith();

      expect(amount, copy);
    });

    test('amount is overridden in copy', () {
      final Amount amount = Amount.fromInt(10, AmountType.volume);
      final Amount copy = amount.copyWith(amount: Decimal.fromInt(20));

      expect(copy.amount, Decimal.fromInt(20));
      expect(copy.type, AmountType.volume);
    });

    test('type is overridden in copy', () {
      final Amount amount = Amount.fromInt(10, AmountType.volume);
      final Amount copy = amount.copyWith(type: AmountType.weight);

      expect(copy.amount, Decimal.fromInt(10));
      expect(copy.type, AmountType.weight);
    });

    test('none-type can only be set if amount is zero', () {
      final Amount volume = Amount.fromInt(10, AmountType.volume);
      final Amount zeroVolume = Amount.zero(AmountType.volume);
      final Amount empty = Amount.empty();

      expect(
        () => volume.copyWith(type: AmountType.none),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => empty.copyWith(amount: Decimal.fromInt(1)),
        throwsA(isA<AssertionError>()),
      );

      final Amount zeroTypeCopy = zeroVolume.copyWith(type: AmountType.none);
      final Amount zeroAmountCopy = zeroVolume.copyWith(amount: Decimal.zero);
      final Amount emptyTypeCopy = zeroVolume.copyWith(type: AmountType.none);
      final Amount emptyAmountCopy = zeroVolume.copyWith(amount: Decimal.zero);

      expect(zeroTypeCopy.type, AmountType.none);
      expect(zeroAmountCopy.amount, Decimal.zero);
      expect(emptyTypeCopy.type, AmountType.none);
      expect(emptyAmountCopy.amount, Decimal.zero);
    });
  });

  group('=', () {
    test('amounts are equal if amount and type are the same', () {
      final Amount amount = Amount.fromInt(40, AmountType.volume);

      expect(amount == Amount.fromInt(40, AmountType.weight), false);
      expect(amount == Amount.fromInt(39, AmountType.volume), false);
      expect(amount == Amount.fromInt(39, AmountType.weight), false);
      expect(amount == Amount.fromInt(40, AmountType.volume), true);
    });

    test('empty and zero amounts can be compared', () {
      final Amount zero = Amount.zero(AmountType.volume);
      final Amount empty = Amount.empty();

      expect(zero == Amount.fromInt(1, AmountType.volume), false);
      expect(zero == Amount.fromInt(0, AmountType.volume), true);
      expect(empty == Amount.fromInt(0, AmountType.weight), false);
      expect(empty == Amount.fromInt(0, AmountType.none), true);
      expect(empty == empty, true);
      expect(zero == zero, true);
    });
  });

  group('<', () {
    test('amount is smaller if amount is smaller', () {
      final Amount amount = Amount.fromInt(40, AmountType.volume);

      expect(amount < Amount.fromInt(39, AmountType.volume), false);
      expect(amount < Amount.fromInt(40, AmountType.volume), false);
      expect(amount < Amount.fromInt(41, AmountType.volume), true);
    });

    test('comparing on different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume < weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();

      expect(Amount.fromInt(1, AmountType.volume) < empty, false);
      expect(empty < Amount.fromInt(1, AmountType.volume), true);
      expect(Amount.fromInt(-1, AmountType.volume) < empty, true);
      expect(empty < Amount.fromInt(-1, AmountType.volume), false);
      expect(Amount.fromInt(0, AmountType.volume) < empty, false);
      expect(empty < Amount.fromInt(0, AmountType.volume), false);
      expect(empty < empty, false);
    });
  });

  group('<=', () {
    test('amount is smaller or equal if amount is smaller or equal', () {
      final Amount amount = Amount.fromInt(40, AmountType.volume);

      expect(amount <= Amount.fromInt(39, AmountType.volume), false);
      expect(amount <= Amount.fromInt(40, AmountType.volume), true);
      expect(amount <= Amount.fromInt(41, AmountType.volume), true);
    });

    test('comparing different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume <= weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();

      expect(Amount.fromInt(1, AmountType.volume) <= empty, false);
      expect(empty <= Amount.fromInt(1, AmountType.volume), true);
      expect(Amount.fromInt(-1, AmountType.volume) <= empty, true);
      expect(empty <= Amount.fromInt(-1, AmountType.volume), false);
      expect(Amount.fromInt(0, AmountType.volume) <= empty, true);
      expect(empty <= Amount.fromInt(0, AmountType.volume), true);
      expect(empty <= empty, true);
    });
  });

  group('>', () {
    test('amount is bigger if amount is bigger', () {
      final Amount amount = Amount.fromInt(40, AmountType.volume);

      expect(amount > Amount.fromInt(39, AmountType.volume), true);
      expect(amount > Amount.fromInt(40, AmountType.volume), false);
      expect(amount > Amount.fromInt(41, AmountType.volume), false);
    });

    test('comparing different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume > weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();

      expect(Amount.fromInt(1, AmountType.volume) > empty, true);
      expect(empty > Amount.fromInt(1, AmountType.volume), false);
      expect(Amount.fromInt(-1, AmountType.volume) > empty, false);
      expect(empty > Amount.fromInt(-1, AmountType.volume), true);
      expect(Amount.fromInt(0, AmountType.volume) > empty, false);
      expect(empty > Amount.fromInt(0, AmountType.volume), false);
      expect(empty > empty, false);
    });
  });

  group('>=', () {
    test('amount is bigger if amount is bigger', () {
      final Amount amount = Amount.fromInt(40, AmountType.volume);

      expect(amount > Amount.fromInt(39, AmountType.volume), true);
      expect(amount > Amount.fromInt(40, AmountType.volume), false);
      expect(amount > Amount.fromInt(41, AmountType.volume), false);
    });

    test('comparing different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume > weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();

      expect(Amount.fromInt(1, AmountType.volume) >= empty, true);
      expect(empty >= Amount.fromInt(1, AmountType.volume), false);
      expect(Amount.fromInt(-1, AmountType.volume) >= empty, false);
      expect(empty >= Amount.fromInt(-1, AmountType.volume), true);
      expect(Amount.fromInt(0, AmountType.volume) >= empty, true);
      expect(empty >= Amount.fromInt(0, AmountType.volume), true);
      expect(empty >= empty, true);
    });
  });

  group('+', () {
    test('amounts are added', () {
      final Amount amount1 = Amount.fromInt(40, AmountType.volume);
      final Amount amount2 = Amount.fromInt(20, AmountType.volume);

      expect((amount1 + amount2).amount, Decimal.fromInt(60));
    });

    test('adding different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume + weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();
      final Amount volume = Amount.fromInt(1, AmountType.volume);

      expect(volume + empty, volume);
      expect(empty + volume, volume);
      expect(empty + empty, empty);
    });
  });

  group('unary-', () {
    test('amount is inverted', () {
      final Amount positive = Amount.volume(ml: 10.toDecimal());
      final Amount negative = Amount.volume(ml: -10.toDecimal());

      expect(-positive.amount, -10.toDecimal());
      expect(-negative.amount, 10.toDecimal());
    });

    test('zero is unchanged', () {
      final Amount amount = Amount.volume(ml: 0.toDecimal());

      expect(-amount, amount);
    });

    test('empty amount is unchanged', () {
      final Amount amount = Amount.empty();

      expect(-amount, amount);
    });
  });

  group('-', () {
    test('amounts are subtracted', () {
      final Amount amount1 = Amount.fromInt(40, AmountType.volume);
      final Amount amount2 = Amount.fromInt(20, AmountType.volume);

      expect((amount1 - amount2).amount, Decimal.fromInt(20));
    });

    test('subtracting different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume - weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();
      final Amount volume = Amount.fromInt(1, AmountType.volume);

      expect(volume - empty, volume);
      expect(empty - volume, -volume);
      expect(empty - empty, empty);
    });
  });

  group('*', () {
    test('amounts are multiplied', () {
      final Amount amount1 = Amount.fromInt(40, AmountType.volume);
      final Amount amount2 = Amount.fromInt(20, AmountType.volume);

      expect((amount1 * amount2).amount, Decimal.fromInt(800));
    });

    test('adding different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume * weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();
      final Amount volume = Amount.fromInt(1, AmountType.volume);

      expect(empty * volume, Amount.volume());
      expect(volume * empty, Amount.volume());
      expect(empty * empty, empty);
    });
  });

  group('/', () {
    test('amounts are divided', () {
      final Amount amount1 = Amount.fromInt(40, AmountType.volume);
      final Amount amount2 = Amount.fromInt(20, AmountType.volume);

      expect((amount1 / amount2).amount, Decimal.fromInt(2));
    });

    test('adding different types throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount weight = Amount.fromInt(40, AmountType.weight);

      expect(
        () => volume / weight,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('dividing by zero throws error', () {
      final Amount volume = Amount.fromInt(40, AmountType.volume);
      final Amount zero = Amount.fromInt(0, AmountType.volume);

      expect(
        () => volume / zero,
        throwsA(isA<ArgumentError>()),
      );
    });

    test('empty amount is treated as zero', () {
      final Amount empty = Amount.empty();
      final Amount volume = Amount.fromInt(1, AmountType.volume);

      expect(empty / volume, Amount.volume());

      expect(
        () => volume / empty,
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => empty / empty,
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('toString', () {
    test('returns zero millilitres', () {
      final Amount amount = Amount.fromInt(0, AmountType.volume);
      expect(amount.toString(), '0 ml');
    });

    test('returns millilitres if under one centilitre', () {
      final Amount amount = Amount.fromInt(9, AmountType.volume);
      expect(amount.toString(), '9 ml');
    });

    test('returns millilitres if negative', () {
      final Amount amount = Amount.fromInt(-9, AmountType.volume);
      expect(amount.toString(), '-9 ml');
    });

    test('returns millilitres with decimals', () {
      final Amount amount = Amount.fromDouble(4.20, AmountType.volume);
      expect(amount.toString(), '4.2 ml');
    });

    test('returns negative millilitres with decimals', () {
      final Amount amount = Amount.fromDouble(-4.20, AmountType.volume);
      expect(amount.toString(), '-4.2 ml');
    });

    test('returns centilitres if exactly one centilitre', () {
      final Amount amount = Amount.fromInt(10, AmountType.volume);
      expect(amount.toString(), '1 cl');
    });

    test('returns centilitres if under one decilitre', () {
      final Amount amount = Amount.fromInt(90, AmountType.volume);
      expect(amount.toString(), '9 cl');
    });

    test('returns centilitres if negative', () {
      final Amount amount = Amount.fromInt(-90, AmountType.volume);
      expect(amount.toString(), '-9 cl');
    });

    test('returns centilitres with decimals', () {
      final Amount amount = Amount.fromDouble(42.90, AmountType.volume);
      expect(amount.toString(), '4.29 cl');
    });

    test('returns negative centilitres with decimals', () {
      final Amount amount = Amount.fromDouble(-42.90, AmountType.volume);
      expect(amount.toString(), '-4.29 cl');
    });

    test('returns decilitres if exactly one decilitre', () {
      final Amount amount = Amount.fromInt(100, AmountType.volume);
      expect(amount.toString(), '1 dl');
    });

    test('returns decilitres if under one decilitre', () {
      final Amount amount = Amount.fromInt(900, AmountType.volume);
      expect(amount.toString(), '9 dl');
    });

    test('returns decilitres if negative', () {
      final Amount amount = Amount.fromInt(-900, AmountType.volume);
      expect(amount.toString(), '-9 dl');
    });

    test('returns decilitres with decimals', () {
      final Amount amount = Amount.fromDouble(420.90, AmountType.volume);
      expect(amount.toString(), '4.21 dl');
    });

    test('returns negative decilitres with decimals', () {
      final Amount amount = Amount.fromDouble(-420.90, AmountType.volume);
      expect(amount.toString(), '-4.21 dl');
    });

    test('returns litres if exactly one litre', () {
      final Amount amount = Amount.fromInt(1000, AmountType.volume);
      expect(amount.toString(), '1 l');
    });

    test('returns litres if negative', () {
      final Amount amount = Amount.fromInt(-9000, AmountType.volume);
      expect(amount.toString(), '-9 l');
    });

    test('returns litres with decimals', () {
      final Amount amount = Amount.fromDouble(1234567.89, AmountType.volume);
      expect(amount.toString(), '1234.57 l');
    });

    test('returns negative litres with decimals', () {
      final Amount amount = Amount.fromDouble(-1234567.89, AmountType.volume);
      expect(amount.toString(), '-1234.57 l');
    });

    test('returns zero grams', () {
      final Amount amount = Amount.fromInt(0, AmountType.weight);
      expect(amount.toString(), '0 g');
    });

    test('returns grams if under one kilo', () {
      final Amount amount = Amount.fromInt(999, AmountType.weight);
      expect(amount.toString(), '999 g');
    });

    test('returns grams if negative', () {
      final Amount amount = Amount.fromInt(-999, AmountType.weight);
      expect(amount.toString(), '-999 g');
    });

    test('returns grams if decimal', () {
      final Amount amount = Amount.fromDouble(12.34, AmountType.weight);
      expect(amount.toString(), '12.34 g');
    });

    test('returns one kilo if exactly one kilo', () {
      final Amount amount = Amount.fromInt(1000, AmountType.weight);
      expect(amount.toString(), '1 kg');
    });

    test('returns kilos if more than one kilo', () {
      final Amount amount = Amount.fromInt(420000, AmountType.weight);
      expect(amount.toString(), '420 kg');
    });

    test('returns kilos if negative', () {
      final Amount amount = Amount.fromInt(-420000, AmountType.weight);
      expect(amount.toString(), '-420 kg');
    });

    test('returns kilos if decimal', () {
      final Amount amount = Amount.fromDouble(1234.56, AmountType.weight);
      expect(amount.toString(), '1.23 kg');
    });

    test('returns pieces if pieces', () {
      final Amount amount = Amount.fromInt(1000, AmountType.pieces);
      expect(amount.toString(), '1000 pc');
    });

    test('returns piece if exactly one piece', () {
      final Amount amount = Amount.fromInt(1, AmountType.pieces);
      expect(amount.toString(), '1 pc');
    });

    test('returns piece if exactly negative one piece', () {
      final Amount amount = Amount.fromInt(-1, AmountType.pieces);
      expect(amount.toString(), '-1 pc');
    });

    test('returns pieces if negative', () {
      final Amount amount = Amount.fromInt(-420000, AmountType.pieces);
      expect(amount.toString(), '-420000 pc');
    });

    test('returns pieces if decimal', () {
      final Amount amount = Amount.fromDouble(12.34, AmountType.pieces);
      expect(amount.toString(), '12.34 pc');
    });
  });
}
