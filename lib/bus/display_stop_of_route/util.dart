import 'package:asallenshih_flutter_tdx/type/bus/direction.dart';
import 'package:asallenshih_flutter_tdx/type/bus/display_stop_of_route.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';

class TdxBusDisplayStopOfRouteUtil {
  static Map<Direction, List<Stop>> groupStopsByDirection(
    List<DisplayStopOfRoute> displayStopOfRoutes,
  ) => displayStopOfRoutes
      .where((dsr) => dsr.direction != null && dsr.stops != null)
      .fold<Map<Direction, List<Stop>>>({}, (map, dsr) {
        map.putIfAbsent(dsr.direction!, () => []).addAll(dsr.stops!);
        return map;
      });

  static int sort(Stop? a, Stop? b) {
    if (a?.stopSequence != null && b?.stopSequence != null) {
      return a!.stopSequence!.compareTo(b!.stopSequence!);
    } else if (a?.stopSequence != null) {
      return -1;
    } else if (b?.stopSequence != null) {
      return 1;
    } else {
      return 0;
    }
  }
}
