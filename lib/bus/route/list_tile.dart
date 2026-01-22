import 'dart:async';

import 'package:asallenshih_flutter_tdx/bus/route/util.dart';
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/route.dart' as tdx_route;
import 'package:asallenshih_flutter_util/lang.dart';
import 'package:asallenshih_flutter_util/langs.dart';
import 'package:cross_platform_ui/cross_platform/tile.dart';
import 'package:flutter/material.dart';

class TdxBusRouteListTile extends CrossPlatformListTile {
  TdxBusRouteListTile(
    tdx_route.Route route, {
    City? city,
    FutureOr<void> Function(tdx_route.Route route, City? city)? onTap,
    FutureOr<void> Function(tdx_route.Route route, City? city)? onLongPress,
    dynamic Function(tdx_route.Route route, City? city) funcTitle = _funcTitle,
    dynamic Function(tdx_route.Route route, City? city) funcSubtitle =
        _funcSubtitle,
    dynamic Function(tdx_route.Route route, City? city) funcTrailing =
        _funcTrailing,
  }) : super(
         title: funcTitle(route, city),
         subtitle: funcSubtitle(route, city),
         leading: Icon(Icons.directions_bus),
         trailing: funcTrailing(route, city),
         cupertinoTrailingWidget: true,
         onTap: onTap == null ? null : () => onTap(route, city),
         onLongPress: onLongPress == null
             ? null
             : () => onLongPress(route, city),
       );
  static List<tdx_route.Route> _getRoutes(
    List<tdx_route.Route> routes, {
    TextEditingController? searchController,
  }) {
    final searchText = searchController?.text.toLowerCase() ?? '';
    if (searchText.isEmpty) {
      return routes;
    }
    final filterRoutes = routes
        .where(
          (route) =>
              (route.routeName?.zhTw?.toLowerCase() ?? '').contains(
                searchText,
              ) ||
              (route.routeName?.en?.toLowerCase() ?? '').contains(searchText),
        )
        .toList();
    if (filterRoutes.isEmpty) {
      return [];
    }
    final startsWithRoutes = filterRoutes
        .where(
          (route) =>
              (route.routeName?.zhTw?.toLowerCase() ?? '').startsWith(
                searchText,
              ) ||
              (route.routeName?.en?.toLowerCase() ?? '').startsWith(searchText),
        )
        .toList();
    if (startsWithRoutes.isEmpty) {
      return filterRoutes;
    }
    return startsWithRoutes;
  }

  static List<TdxBusRouteListTile> fromRoutes(
    List<tdx_route.Route> routes, {
    TextEditingController? searchController,
    FutureOr<void> Function(tdx_route.Route route, City? city)? onTap,
    FutureOr<void> Function(tdx_route.Route route, City? city)? onLongPress,
    dynamic Function(tdx_route.Route route, City? city) funcTitle = _funcTitle,
    dynamic Function(tdx_route.Route route, City? city) funcSubtitle =
        _funcSubtitle,
    dynamic Function(tdx_route.Route route, City? city) funcTrailing =
        _funcTrailing,
  }) {
    final filteredRoutes = _getRoutes(
      routes,
      searchController: searchController,
    );
    TdxBusRouteUtil.sortRun(filteredRoutes);
    return filteredRoutes
        .map(
          (route) => TdxBusRouteListTile(
            route,
            onTap: onTap,
            onLongPress: onLongPress,
            funcTitle: funcTitle,
            funcSubtitle: funcSubtitle,
            funcTrailing: funcTrailing,
          ),
        )
        .toList();
  }

  static List<TdxBusRouteListTile> fromRoutesWithCity(
    Map<City, List<tdx_route.Route>> cityRoutes, {
    TextEditingController? searchController,
    FutureOr<void> Function(tdx_route.Route route, City? city)? onTap,
    FutureOr<void> Function(tdx_route.Route route, City? city)? onLongPress,
    dynamic Function(tdx_route.Route route, City? city) funcTitle = _funcTitle,
    dynamic Function(tdx_route.Route route, City? city) funcSubtitle =
        _funcSubtitle,
    dynamic Function(tdx_route.Route route, City? city) funcTrailing =
        _funcTrailing,
  }) {
    final routes = cityRoutes.entries.expand((entry) {
      final city = entry.key;
      final routes = entry.value;
      final filteredRoutes = _getRoutes(
        routes,
        searchController: searchController,
      );
      return filteredRoutes.map((route) => MapEntry(city, route));
    }).toList();
    routes.sort((a, b) => TdxBusRouteUtil.sort(a.value, b.value));
    return routes
        .map(
          (entry) => TdxBusRouteListTile(
            entry.value,
            city: entry.key,
            onTap: onTap,
            onLongPress: onLongPress,
            funcTitle: funcTitle,
            funcSubtitle: funcSubtitle,
            funcTrailing: funcTrailing,
          ),
        )
        .toList();
  }
}

Text _funcTitle(tdx_route.Route route, City? city) {
  final routeName = Lang.t({
    Langs.en: route.routeName?.en,
    Langs.zhHantTW: route.routeName?.zhTw,
  });
  return Text(routeName);
}

Text _funcSubtitle(tdx_route.Route route, City? city) {
  final departureStopName = Lang.t({
    Langs.en: route.departureStopName?.en,
    Langs.zhHantTW: route.departureStopName?.zhTw,
  });
  final destinationStopName = Lang.t({
    Langs.en: route.destinationStopName?.en,
    Langs.zhHantTW: route.destinationStopName?.zhTw,
  });
  final String stop = departureStopName == '' || destinationStopName == ''
      ? ''
      : '$departureStopName → $destinationStopName';
  return Text(stop);
}

Text? _funcTrailing(tdx_route.Route route, City? city) {
  if (city == null) {
    return null;
  }
  final cityName = Lang.t({
    Langs.en: city.cityNameEn,
    Langs.zhHantTW: city.cityName,
  });
  return Text(cityName);
}
