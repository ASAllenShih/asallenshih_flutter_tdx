import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/route.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop_of_route.dart';

class TdxBusStopOfRouteApi {
  static Future<List<StopOfRoute>?> get(
    City city,
    Route route, {
    List<String> select = const [],
    void Function(int, int)? onProgress,
  }) async {
    final cityData = city.city;
    if (cityData != null) {
      await tdx_http.loadLibrary();
      return StopOfRoute.fromMaps(
        await tdx_http.TdxHttp.getIterable(
          'basic/v2/Bus/StopOfRoute',
          select: select,
          query: {'City': cityData, 'RouteUID': route.routeUID!},
          onProgress: onProgress,
          duration: const Duration(days: 30),
        ),
      );
    }
    return null;
  }

  static Future<List<StopOfRoute>?> getList(
    City city,
    Route route, {
    void Function(int, int)? onProgress,
  }) => get(
    city,
    route,
    select: [
      'RouteUID',
      'Operators',
      'SubRouteUID',
      'SubRouteName',
      'Direction',
      'Stops/StopUID',
      'Stops/StopName',
      'Stops/StopSequence',
    ],
    onProgress: onProgress,
  );
}
