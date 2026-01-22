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
  static Bearing? fromValue(String? code) {
    return code == null
        ? null
        : (Bearing.values as List<Bearing?>).firstWhere(
            (e) => e?.code == code,
            orElse: () => null,
          );
  }
}
