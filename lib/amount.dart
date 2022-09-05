import 'package:intl/intl.dart';

class Amount {
  int? _millilitres;
  double? _pieces;

  Amount({int? millilitres, double? pieces})
      : _millilitres = millilitres,
        _pieces = pieces;

  factory Amount.volume({
    int? litres,
    int? decilitres,
    int? centilitres,
    int? millilitres,
  }) {
    int sum = 0;

    if (litres != null) sum += litres * 1000;
    if (decilitres != null) sum += decilitres * 100;
    if (centilitres != null) sum += centilitres * 10;
    if (millilitres != null) sum += millilitres;

    return Amount(millilitres: sum);
  }

  factory Amount.pieces(double pieces) {
    return Amount(pieces: pieces);
  }

  factory Amount.parse(String amount) {
    final int length = amount.length;

    if (length >= 2 &&
        amount.substring(length - 2, length).toLowerCase() == 'ml') {
      final int millilitres = int.parse(amount.substring(0, length - 2));

      return Amount(millilitres: millilitres);
    } else if (length >= 4 &&
        amount.substring(length - 4, length).toLowerCase() == 'dash') {
      final int millilitres = int.parse(amount.substring(0, length - 4));

      return Amount(millilitres: millilitres);
    } else if (length >= 6 &&
        amount.substring(length - 6, length).toLowerCase() == 'dashes') {
      final int millilitres = int.parse(amount.substring(0, length - 6));

      return Amount(millilitres: millilitres);
    } else if (length >= 2 &&
        amount.substring(length - 2, length).toLowerCase() == 'cl') {
      final int millilitres = int.parse(amount.substring(0, length - 2)) * 10;

      return Amount(millilitres: millilitres);
    } else if (length >= 2 &&
        amount.substring(length - 2, length).toLowerCase() == 'dl') {
      final int millilitres = int.parse(amount.substring(0, length - 2)) * 100;

      return Amount(millilitres: millilitres);
    } else if (length >= 1 &&
        amount.substring(length - 1, length).toLowerCase() == 'l') {
      final int millilitres = int.parse(amount.substring(0, length - 1)) * 1000;

      return Amount(millilitres: millilitres);
    } else if (length >= 3 &&
        amount.substring(length - 3, length).toLowerCase() == 'pc.') {
      final double pieces = double.parse(amount.substring(0, length - 3));

      return Amount(pieces: pieces);
    }

    return Amount();
  }

  factory Amount.calculateSum(List<Amount> amounts) {
    Amount sum = Amount();

    for (final Amount amount in amounts) {
      sum += amount;
    }

    return sum;
  }

  bool get isVolume => _millilitres != null && _pieces == null;

  bool get isPieces => _pieces != null && _millilitres == null;

  bool get isEmpty => !isVolume && !isPieces;

  double get litres {
    final int? millilitres = _millilitres;

    if (millilitres == null) {
      throw Exception('The amount is not a volume');
    }

    return millilitres / 1000.0;
  }

  double get decilitres {
    final int? millilitres = _millilitres;

    if (millilitres == null) {
      throw Exception('The amount is not a volume');
    }

    return millilitres / 100.0;
  }

  double get centilitres {
    final int? millilitres = _millilitres;

    if (millilitres == null) {
      throw Exception('The amount is not a volume');
    }

    return millilitres / 10.0;
  }

  int get millilitres {
    final int? millilitres = _millilitres;

    if (millilitres == null) {
      throw Exception('The amount is not a volume');
    }

    return millilitres;
  }

  double get pieces {
    final double? pieces = _pieces;

    if (pieces == null) {
      throw Exception('The amount is not pieces');
    }

    return pieces;
  }

  Amount multiply(int multiplier) {
    final int? millilitres = _millilitres;
    final double? pieces = _pieces;

    if (millilitres != null) {
      return Amount(millilitres: millilitres * multiplier);
    }
    if (pieces != null) {
      return Amount(pieces: pieces * multiplier);
    }

    return this;
  }

  Amount copyWith({int? millilitres, double? pieces}) {
    return Amount(
      millilitres: millilitres ?? _millilitres,
      pieces: pieces ?? _pieces,
    );
  }

  @override
  String toString() {
    final NumberFormat piecesFormat = NumberFormat('#.##', 'nb_NO');

    if (!isVolume && !isPieces) {
      return 'nothing';
    }

    if (isPieces) {
      return '${piecesFormat.format(pieces)} pieces';
    }

    final NumberFormat volumeFormat = NumberFormat('#.##', 'nb_NO');

    if (millilitres >= 1000 || millilitres <= -1000) {
      return '${volumeFormat.format(litres)} l';
    } else if (millilitres >= 100 || millilitres <= -100) {
      return '${volumeFormat.format(decilitres)} dl';
    } else if (millilitres >= 10 || millilitres <= -10) {
      return '${volumeFormat.format(centilitres)} cl';
    } else {
      return '${volumeFormat.format(millilitres)} ml';
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is Amount &&
        ((isVolume && other.isPieces) || (isPieces && other.isVolume))) {
      throw Exception("Volume and pieces can't be compared");
    }

    if (isVolume) {
      return identical(this, other) ||
          (other is Amount && millilitres == other.millilitres);
    } else if (isPieces) {
      return identical(this, other) ||
          (other is Amount && pieces == other.pieces);
    }

    return false;
  }

  bool operator <(Object other) {
    return other is Amount && _isLessThan(this, other);
  }

  bool operator <=(Object other) {
    return other is Amount && (_isLessThan(this, other) || this == other);
  }

  bool operator >(Object other) {
    return other is Amount && _isBiggerThan(this, other);
  }

  bool operator >=(Object other) {
    return other is Amount && (_isBiggerThan(this, other) || this == other);
  }

  @override
  int get hashCode => millilitres.hashCode ^ pieces.hashCode;

  Amount operator +(Amount other) {
    if ((isVolume && other.isPieces) || (isPieces && other.isVolume)) {
      throw ArgumentError("Volume and pieces can't be added together");
    }

    if (isEmpty) {
      return other.copyWith();
    } else if (other.isEmpty) {
      return copyWith();
    } else if (isVolume) {
      return Amount(millilitres: millilitres + other.millilitres);
    } else if (isPieces) {
      return Amount(pieces: pieces + other.pieces);
    }

    return Amount();
  }

  Amount operator -(Amount other) {
    if ((isVolume && other.isPieces) || (isPieces && other.isVolume)) {
      throw ArgumentError("Volume and pieces can't be subtracted from another");
    }

    if (isVolume) {
      if (isEmpty) {
        return Amount(millilitres: -other.millilitres);
      } else if (other.isEmpty) {
        return Amount(millilitres: millilitres);
      } else {
        return Amount(millilitres: millilitres - other.millilitres);
      }
    } else if (isPieces) {
      if (isEmpty) {
        return Amount(pieces: -other.pieces);
      } else if (other.isEmpty) {
        return Amount(pieces: pieces);
      } else {
        return Amount(pieces: pieces - other.pieces);
      }
    }

    return Amount();
  }

  Amount operator *(Amount other) {
    if ((isVolume && other.isPieces) || (isPieces && other.isVolume)) {
      throw ArgumentError(
        "Volume and pieces can't be multiplied by each other",
      );
    }

    if (isEmpty || other.isEmpty) {
      return Amount();
    } else if (isVolume) {
      return Amount(millilitres: millilitres * other.millilitres);
    } else if (isPieces) {
      return Amount(pieces: pieces * other.pieces);
    }

    return Amount();
  }

  Amount operator /(Amount other) {
    if ((isVolume && other.isPieces) || (isPieces && other.isVolume)) {
      throw ArgumentError("Volume and pieces can't be divided by each other");
    }

    if (isEmpty || other.isEmpty) {
      return Amount();
    } else if (isVolume) {
      return Amount(millilitres: millilitres ~/ other.millilitres);
    } else if (isPieces) {
      return Amount(pieces: pieces / other.pieces);
    }

    return Amount();
  }

  bool _isBiggerThan(Amount a, Amount b) {
    if ((a.isVolume && b.isPieces) || (a.isPieces && b.isVolume)) {
      throw ArgumentError("Volume and pieces can't be compared");
    }

    if (a.isEmpty) {
      return false;
    } else if (b.isEmpty) {
      return true;
    } else if (a.isVolume) {
      return a.millilitres > b.millilitres;
    } else if (a.isPieces) {
      return a.pieces > b.pieces;
    }

    return false;
  }

  bool _isLessThan(Amount a, Amount b) {
    if ((a.isVolume && b.isPieces) || (a.isPieces && b.isVolume)) {
      throw ArgumentError("Volume and pieces can't be compared");
    }

    if (a.isEmpty) {
      return true;
    } else if (b.isEmpty) {
      return false;
    } else if (a.isVolume) {
      return a.millilitres < b.millilitres;
    } else if (a.isPieces) {
      return a.pieces < b.pieces;
    }

    return false;
  }
}
