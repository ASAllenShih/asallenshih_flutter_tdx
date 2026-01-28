import 'package:asallenshih_flutter_tdx/type/bus/direction.dart';
import 'package:asallenshih_flutter_tdx/type/bus/operator.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';
import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';

class StopOfRoute {
  final String? routeUID;
  final List<Operator>? operators;
  final String? subRouteUID;
  final Lang? subRouteName;
  final Direction? direction;
  final List<Stop>? stops;
  StopOfRoute({
    this.routeUID,
    this.operators,
    this.subRouteUID,
    this.subRouteName,
    this.direction,
    this.stops,
  });
  static StopOfRoute? fromMap(Map<String, dynamic>? map) => map == null
      ? null
      : StopOfRoute(
          routeUID: map['RouteUID'] as String?,
          operators: Operator.fromMaps(map['Operators'] as Iterable<dynamic>?),
          subRouteUID: map['SubRouteUID'] as String?,
          subRouteName: Lang.fromMap(
            map['SubRouteName'] as Map<String, dynamic>?,
          ),
          direction: Direction.fromValue(map['Direction'] as int?),
          stops: Stop.fromMaps(map['Stops'] as Iterable<dynamic>?),
        );
  static List<StopOfRoute> fromMaps(Iterable<dynamic>? maps) =>
      (maps ?? <dynamic>[])
          .map((e) => fromMap(e as Map<String, dynamic>?))
          .whereType<StopOfRoute>()
          .toList();
}
