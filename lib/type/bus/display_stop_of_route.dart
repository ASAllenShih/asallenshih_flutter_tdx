import 'package:asallenshih_flutter_tdx/type/bus/direction.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';

class DisplayStopOfRoute {
  final String? routeUID;
  final Direction? direction;
  final List<Stop>? stops;
  DisplayStopOfRoute({this.routeUID, this.direction, this.stops});
  static DisplayStopOfRoute? fromMap(Map<String, dynamic>? map) => map == null
      ? null
      : DisplayStopOfRoute(
          routeUID: map['RouteUID'] as String?,
          direction: Direction.fromValue(map['Direction'] as int?),
          stops: Stop.fromMaps(map['Stops'] as Iterable<dynamic>?),
        );
  static List<DisplayStopOfRoute> fromMaps(Iterable<dynamic>? maps) =>
      (maps ?? <dynamic>[])
          .map((e) => fromMap(e as Map<String, dynamic>?))
          .whereType<DisplayStopOfRoute>()
          .toList();
}
