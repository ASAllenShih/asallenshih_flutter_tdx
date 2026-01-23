import 'package:asallenshih_flutter_tdx/type/bus/direction.dart';
import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';

class SubRoute {
  SubRoute({
    this.subRouteUID,
    this.subRouteID,
    this.operatorIDs,
    this.subRouteName,
    this.direction,
    this.firstBusTime,
    this.lastBusTime,
    this.holidayFirstBusTime,
    this.holidayLastBusTime,
  });
  final String? subRouteUID;
  final String? subRouteID;
  final List<String>? operatorIDs;
  final Lang? subRouteName;
  final Direction? direction;
  final String? firstBusTime;
  final String? lastBusTime;
  final String? holidayFirstBusTime;
  final String? holidayLastBusTime;
  static SubRoute? fromMap(Map<String, dynamic>? json) => json == null
      ? null
      : SubRoute(
          subRouteUID: json['SubRouteUID'] as String?,
          subRouteID: json['SubRouteID'] as String?,
          operatorIDs: (json['OperatorIDs'] as Iterable<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          subRouteName: Lang.fromMap(
            json['SubRouteName'] as Map<String, dynamic>?,
          ),
          direction: Direction.fromValue(json['Direction'] as int?),
          firstBusTime: json['FirstBusTime'] as String?,
          lastBusTime: json['LastBusTime'] as String?,
          holidayFirstBusTime: json['HolidayFirstBusTime'] as String?,
          holidayLastBusTime: json['HolidayLastBusTime'] as String?,
        );

  static List<SubRoute> fromMaps(Iterable<dynamic>? jsons) =>
      (jsons ?? <dynamic>[])
          .map((e) => fromMap(e as Map<String, dynamic>?))
          .whereType<SubRoute>()
          .toList();
}
