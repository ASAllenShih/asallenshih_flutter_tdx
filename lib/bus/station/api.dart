import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/station.dart';

class TdxBusStationApi {
  static Future<List<Station>?> get(
    City city, {
    Station? station,
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
          query: {
            'City': cityData,
            if (station?.stationUID != null) 'StationUID': station!.stationUID!,
          },
          onProgress: onProgress,
          duration: const Duration(days: 30),
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
      'StationPosition/PositionLon',
      'StationPosition/PositionLat',
    ],
    onProgress: onProgress,
  );

  static Future<List<Station>?> getList(
    City city, {
    Station? station,
    void Function(int, int)? onProgress,
  }) => get(
    city,
    station: station,
    select: [
      'StationUID',
      'StationName',
      'StationPosition/PositionLon',
      'StationPosition/PositionLat',
      'StationAddress',
      'Bearing',
    ],
    onProgress: onProgress,
  );

  static Future<Station?> getPopup(City city, Station station) async =>
      (await get(
        city,
        station: station,
        select: ['StationUID', 'StationName', 'StationAddress', 'Bearing'],
      ))?.firstOrNull;

  static Future<Station?> getByUID(
    City city,
    String stationUID, {
    List<String> select = const [],
    void Function(int, int)? onProgress,
  }) async => (await get(
    city,
    station: Station(stationUID: stationUID),
    select: select,
    onProgress: onProgress,
  ))?.firstOrNull;

  static Future<Station?> getEta(
    City city,
    String stationUID, {
    void Function(int, int)? onProgress,
  }) => getByUID(
    city,
    stationUID,
    select: [
      'StationUID',
      'StationName',
      'StationPosition/PositionLon',
      'StationPosition/PositionLat',
      'StationAddress',
      'Bearing',
      'Stops/StopUID',
      'Stops/RouteUID',
      'Stops/RouteName',
    ],
    onProgress: onProgress,
  );
}
