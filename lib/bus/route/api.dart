import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/route.dart';

class TdxBusRouteApi {
  static Future<List<Route>?> get(
    City city, {
    List<String> select = const [],
    List<String> routeUID = const [],
    void Function(int, int)? onProgress,
  }) async {
    final cityData = city.city;
    if (cityData != null) {
      tdx_http.loadLibrary();
      return Route.fromMaps(
        await tdx_http.TdxHttp.getIterable(
          'basic/v2/Bus/Route',
          select: select,
          query: {
            'City': cityData,
            if (routeUID.isNotEmpty) 'RouteUID': routeUID.join(','),
          },
          onProgress: onProgress,
          duration: const Duration(days: 30),
        ),
      );
    }
    return null;
  }

  static Future<List<Route>?> getList(
    City city, {
    List<String> routeUID = const [],
    void Function(int, int)? onProgress,
  }) => get(
    city,
    select: [
      'RouteUID',
      'RouteName',
      'DepartureStopNameZh',
      'DepartureStopNameEn',
      'DestinationStopNameZh',
      'DestinationStopNameEn',
    ],
    routeUID: routeUID,
    onProgress: onProgress,
  );

  static Future<Route?> getPopup(City city, Route route) async => (await get(
    city,
    routeUID: [route.routeUID!],
    select: [
      'RouteUID',
      'Operators',
      'TicketPriceDescriptionZh',
      'TicketPriceDescriptionEn',
      'RouteMapImageUrl',
    ],
  ))?.firstOrNull;

  static Future<Route?> getListDataByID(
    City city,
    String routeUID, {
    void Function(int, int)? onProgress,
  }) async => (await getList(
    city,
    routeUID: [routeUID],
    onProgress: onProgress,
  ))?.firstOrNull;
}
