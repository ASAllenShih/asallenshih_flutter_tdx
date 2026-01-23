import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/display_stop_of_route.dart';
import 'package:asallenshih_flutter_tdx/type/bus/route.dart';

class TdxBusDisplayStopOfRouteApi {
  static Future<List<DisplayStopOfRoute>?> get(
    City city,
    Route route, {
    List<String> select = const [],
    void Function(int, int)? onProgress,
  }) async {
    final cityData = city.city;
    if (cityData != null) {
      await tdx_http.loadLibrary();
      return DisplayStopOfRoute.fromMaps(
        await tdx_http.TdxHttp.getIterable(
          'basic/v2/Bus/DisplayStopOfRoute',
          select: select,
          query: {'City': cityData},
          onProgress: onProgress,
          duration: const Duration(days: 30),
        ),
      );
    }
    return null;
  }

  static Future<List<DisplayStopOfRoute>?> getList(
    City city,
    Route route, {
    void Function(int, int)? onProgress,
  }) => get(
    city,
    route,
    select: [
      'RouteUID',
      'Direction',
      'Stops/StopUID',
      'Stops/StopName',
      'Stops/StopSequence',
      'StopSequence',
    ],
    onProgress: onProgress,
  );
}
