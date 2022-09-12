import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

extension DecimalFormatting on Decimal {
  String formatPrice({String? locale}) {
    final NumberFormat format = NumberFormat('0.00', locale ?? 'nb_NO');

    return '${format.format(this)} kr';
  }
}

extension DoubleConversion on double {
  Decimal toDecimal() {
    return Decimal.parse(toStringAsFixed(10));
  }
}

extension StringParsing on String {
  Decimal toDecimal() {
    return Decimal.parse(this);
  }
}
