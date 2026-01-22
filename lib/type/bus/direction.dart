enum Direction {
  outbound(0),
  inbound(1),
  loop(2),
  circularLine(10),
  unknown(255);

  const Direction(this.value);
  final int value;
  static Direction? fromValue(int? value) {
    return value == null
        ? null
        : (Direction.values as List<Direction?>).firstWhere(
            (e) => e?.value == value,
            orElse: () => null,
          );
  }
}
