import 'dart:async';

import 'package:asallenshih_flutter_tdx/bus/route/util.dart';
import 'package:asallenshih_flutter_tdx/type/bus/estimated_time.dart';
import 'package:asallenshih_flutter_tdx/type/bus/route.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';
import 'package:collection/collection.dart';
import 'package:cross_platform_ui/cross_platform/tile.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_color/flutter_color.dart';

class EstimatedTimeOfArrivalListTile extends CrossPlatformListTile {
  EstimatedTimeOfArrivalListTile(
    EstimatedTime? estimatedTime, {
    Stop? stop,
    Route? route,
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcLeading =
        dFuncBusIcon,
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcTitle =
        dFuncTitle,
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcTrailing =
        dFuncNull,
    FutureOr<void> Function(
      EstimatedTime? estimatedTime,
      Stop? stop,
      Route? route,
    )?
    onTap,
    FutureOr<void> Function(
      EstimatedTime? estimatedTime,
      Stop? stop,
      Route? route,
    )?
    onLongPress,
    super.type,
  }) : super(
         leading: funcLeading(estimatedTime, stop, route),
         title: funcTitle(estimatedTime, stop, route),
         trailing: funcTrailing(estimatedTime, stop, route),
         onTap: onTap == null ? null : () => onTap(estimatedTime, stop, route),
         onLongPress: onLongPress == null
             ? null
             : () => onLongPress(estimatedTime, stop, route),
       );
  static List<EstimatedTimeOfArrivalListTile> fromStops(
    List<EstimatedTime>? estimatedTimes,
    List<Stop> stops, {
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcLeading =
        dFuncBusIcon,
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcTitle =
        dFuncTitle,
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcTrailing =
        dFuncNull,
    FutureOr<void> Function(
      EstimatedTime? estimatedTime,
      Stop? stop,
      Route? route,
    )?
    onTap,
    FutureOr<void> Function(
      EstimatedTime? estimatedTime,
      Stop? stop,
      Route? route,
    )?
    onLongPress,
  }) {
    stops.sort(
      (Stop a, Stop b) => a.stopSequence != null && b.stopSequence != null
          ? a.stopSequence!.compareTo(b.stopSequence!)
          : a.stopSequence != null
          ? -1
          : b.stopSequence != null
          ? 1
          : 0,
    );
    return stops
        .map(
          (Stop stop) => EstimatedTimeOfArrivalListTile(
            estimatedTimes?.firstWhereOrNull(
              (EstimatedTime e) => e.stopUID == stop.stopUID,
            ),
            stop: stop,
            funcLeading: funcLeading,
            funcTitle: funcTitle,
            funcTrailing: funcTrailing,
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        )
        .toList();
  }

  static List<EstimatedTimeOfArrivalListTile> fromRoutes(
    List<EstimatedTime>? estimatedTimes,
    List<Route> routes, {
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcLeading =
        dFuncBusIcon,
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcTitle =
        dFuncTitle,
    dynamic Function(EstimatedTime? estimatedTime, Stop? stop, Route? route)
        funcTrailing =
        dFuncNull,
    FutureOr<void> Function(
      EstimatedTime? estimatedTime,
      Stop? stop,
      Route? route,
    )?
    onTap,
    FutureOr<void> Function(
      EstimatedTime? estimatedTime,
      Stop? stop,
      Route? route,
    )?
    onLongPress,
  }) {
    routes.sort(TdxBusRouteUtil.sort);
    return routes
        .map(
          (Route route) => EstimatedTimeOfArrivalListTile(
            estimatedTimes?.firstWhereOrNull(
              (EstimatedTime e) => e.routeUID == route.routeUID,
            ),
            route: route,
            funcLeading: funcLeading,
            funcTitle: funcTitle,
            funcTrailing: funcTrailing,
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        )
        .toList();
  }
}

Color dEtaColor(int? sec) {
  if (sec == null) {
    return Colors.grey;
  }
  final Map<int, Color> colors = {
    90: Colors.purple,
    180: Colors.red,
    450: Colors.yellow,
    600: Colors.green,
  };
  final List<int> colorSec = colors.keys.toList();
  colorSec.sort((int a, int b) => a.compareTo(b));
  for (int i = 0; i < colorSec.length; i++) {
    if (sec > colorSec[i]) {
      continue;
    } else if (i == 0) {
      return colors[colorSec[i]]!;
    }
    return colors[colorSec[i - 1]]!.mix(
          colors[colorSec[i]]!,
          (sec - colorSec[i - 1]) / (colorSec[i] - colorSec[i - 1]),
        ) ??
        colors[colorSec[i - 1]]!;
  }
  return colors[colorSec.last]!;
}

Icon dFuncBusIcon(EstimatedTime? estimatedTime, Stop? stop, Route? route) =>
    Icon(Icons.directions_bus, color: dEtaColor(estimatedTime?.estimateTime));

Text dFuncTitle(EstimatedTime? estimatedTime, Stop? stop, Route? route) => Text(
  [
    route?.routeName?.text,
    stop?.stopName?.text,
  ].where((e) => e != null && e.isNotEmpty).join(' '),
);

Null dFuncNull(EstimatedTime? estimatedTime, Stop? stop, Route? route) => null;
