import 'package:collection/collection.dart';

enum BusRouteType {
  cityBus(11),
  interCityBus(12),
  freewayBus(13),
  shuttleBus(14);

  final int code;
  const BusRouteType(this.code);
  static BusRouteType? fromValue(int? code) => code == null
      ? null
      : BusRouteType.values.firstWhereOrNull((e) => e.code == code);
}
