import 'package:asallenshih_flutter_tdx/type/bus/bus_route_type.dart';
import 'package:asallenshih_flutter_tdx/type/bus/operator.dart';
import 'package:asallenshih_flutter_tdx/type/bus/sub_route.dart';
import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';

class Route {
  Route({
    this.routeUID,
    this.hasSubRoutes,
    this.operators,
    this.subRoutes,
    this.busRouteType,
    this.routeName,
    this.departureStopName,
    this.destinationStopName,
    this.ticketPriceDescription,
    this.routeMapImageUrl,
  });
  final String? routeUID;
  final bool? hasSubRoutes;
  final List<Operator>? operators;
  final List<SubRoute>? subRoutes;
  final BusRouteType? busRouteType;
  final Lang? routeName;
  final Lang? departureStopName;
  final Lang? destinationStopName;
  final Lang? ticketPriceDescription;
  final String? routeMapImageUrl;
  static Route? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : Route(
            routeUID: map['RouteUID'] as String?,
            hasSubRoutes: map['HasSubRoutes'] as bool?,
            operators: Operator.fromMaps(
              map['Operators'] as Iterable<dynamic>?,
            ),
            subRoutes: SubRoute.fromMaps(
              map['SubRoutes'] as Iterable<dynamic>?,
            ),
            busRouteType: BusRouteType.fromValue(map['BusRouteType'] as int?),
            routeName: Lang.fromMap(map['RouteName'] as Map<String, dynamic>?),
            departureStopName: Lang(
              zhTw: map['DepartureStopNameZh'] as String?,
              en: map['DepartureStopNameEn'] as String?,
            ),
            destinationStopName: Lang(
              zhTw: map['DestinationStopNameZh'] as String?,
              en: map['DestinationStopNameEn'] as String?,
            ),
            ticketPriceDescription: Lang(
              zhTw: map['TicketPriceDescriptionZh'] as String?,
              en: map['TicketPriceDescriptionEn'] as String?,
            ),
            routeMapImageUrl: map['RouteMapImageUrl'] as String?,
          );
  }

  static List<Route> fromMaps(Iterable<dynamic>? maps) => (maps ?? <dynamic>[])
      .map((e) => fromMap(e as Map<String, dynamic>?))
      .whereType<Route>()
      .toList();
}
