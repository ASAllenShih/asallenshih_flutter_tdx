import 'package:collection/collection.dart';

enum Direction {
  outbound(0),
  inbound(1),
  loop(2),
  circularLine(10),
  unknown(255);

  const Direction(this.value);
  final int value;
  static Direction? fromValue(int? value) => value == null
      ? null
      : Direction.values.firstWhereOrNull((e) => e.value == value);
}
