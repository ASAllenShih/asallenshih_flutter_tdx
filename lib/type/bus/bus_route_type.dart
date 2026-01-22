enum BusRouteType {
  cityBus(11),
  interCityBus(12),
  freewayBus(13),
  shuttleBus(14);

  final int code;
  const BusRouteType(this.code);
  static BusRouteType? fromValue(int? code) {
    return code == null
        ? null
        : (BusRouteType.values as List<BusRouteType?>).firstWhere(
            (e) => e?.code == code,
            orElse: () => null,
          );
  }
}
