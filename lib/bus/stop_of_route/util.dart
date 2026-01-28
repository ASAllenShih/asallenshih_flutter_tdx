import 'package:asallenshih_flutter_tdx/type/bus/direction.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop_of_route.dart';
import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';

class TdxBusStopOfRouteUtil {
  static Map<Lang, Map<Direction, List<Stop>>> groupStops(
    List<StopOfRoute> stopOfRoutes,
  ) => stopOfRoutes
      .where(
        (sor) =>
            sor.subRouteName != null &&
            sor.direction != null &&
            sor.stops != null,
      )
      .fold<Map<Lang, Map<Direction, List<Stop>>>>({}, (map, sor) {
        map.putIfAbsent(sor.subRouteName!, () => {});
        map[sor.subRouteName!]!.putIfAbsent(sor.direction!, () => []);
        map[sor.subRouteName!]![sor.direction!]!.addAll(sor.stops!);
        return map;
      });
}
