import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/estimated_time.dart';
import 'package:asallenshih_flutter_tdx/type/bus/route.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';

class TdxBusEstimatedTimeOfArrivalApi {
  static Future<List<EstimatedTime>?> get(
    City city, {
    Route? route,
    List<Stop>? stops,
    List<String> select = const [],
    void Function(int, int)? onProgress,
  }) async {
    final cityData = city.city;
    if (cityData != null) {
      final routeUID = route?.routeUID;
      final stopUIDs = stops
          ?.map((e) => e.stopUID)
          .whereType<String>()
          .toList();
      await tdx_http.loadLibrary();
      return EstimatedTime.fromMaps(
        await tdx_http.TdxHttp.getIterable(
          'basic/v2/Bus/EstimatedTimeOfArrival',
          select: select,
          query: {
            'City': cityData,
            if (routeUID != null) 'RouteUID': routeUID,
            if (stopUIDs != null && stopUIDs.isNotEmpty)
              'StopUID': stopUIDs.join('|'),
          },
          onProgress: onProgress,
          duration: const Duration(seconds: 20),
        ),
      );
    }
    return null;
  }
}
