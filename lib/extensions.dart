import 'package:intl/intl.dart';

extension DoubleFormatting on double {
  String formatPrice({String? locale}) {
    final NumberFormat format = NumberFormat('0.00', locale ?? 'nb_NO');

    return '${format.format(this)} kr';
  }
}
