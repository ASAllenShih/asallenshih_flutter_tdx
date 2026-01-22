import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/station.dart';

class TdxBusStationApi {
  static Future<List<Station>?> get(
    City city, {
    List<String> select = const [],
    void Function(int, int)? onProgress,
  }) async {
    final cityData = city.city;
    if (cityData != null) {
      await tdx_http.loadLibrary();
      return Station.fromMaps(
        await tdx_http.TdxHttp.getIterable(
          'basic/v2/Bus/Station',
          select: select,
          query: {'City': cityData},
          onProgress: onProgress,
        ),
      );
    }
    return null;
  }

  static Future<List<Station>?> getMap(
    City city, {
    void Function(int, int)? onProgress,
  }) => get(
    city,
    select: [
      'StationUID',
      'StationPosition.PositionLon',
      'StationPosition.PositionLat',
    ],
    onProgress: onProgress,
  );
}
