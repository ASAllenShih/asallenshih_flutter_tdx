import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';

class TdxBusDisplayStopOfRouteUtil {
  static int sort(Stop a, Stop b) {
    if (a.stopSequence != null && b.stopSequence != null) {
      return a.stopSequence!.compareTo(b.stopSequence!);
    } else if (a.stopSequence != null) {
      return -1;
    } else if (b.stopSequence != null) {
      return 1;
    } else {
      return 0;
    }
  }
}
