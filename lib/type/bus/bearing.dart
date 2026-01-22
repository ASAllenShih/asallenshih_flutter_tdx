import 'package:collection/collection.dart';

enum Bearing {
  east('E'),
  west('W'),
  south('S'),
  north('N'),
  southeast('SE'),
  northeast('NE'),
  southwest('SW'),
  northwest('NW');

  final String code;
  const Bearing(this.code);
  static Bearing? fromValue(String? code) => code == null
      ? null
      : Bearing.values.firstWhereOrNull((e) => e.code == code);
}
