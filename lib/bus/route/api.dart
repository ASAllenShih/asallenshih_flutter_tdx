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
        ),
      );
    }
    return null;
  }

  static Future<List<Route>?> getList(
    City city, {
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
    onProgress: onProgress,
  );

  static Future<Route?> getPopup(City city, Route route) async {
    return (await get(
      city,
      select: [
        'Operators',
        'TicketPriceDescriptionZh',
        'TicketPriceDescriptionEn',
        'RouteMapImageUrl',
      ],
      routeUID: [if (route.routeUID != null) route.routeUID!],
    ))?.firstOrNull;
  }
}
