import 'dart:async';

import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/station.dart';
import 'package:cross_platform_ui/cross_platform/tile.dart';
import 'package:flutter/material.dart';

class TdxBusStationListTile extends CrossPlatformListTile {
  TdxBusStationListTile(
    Station station, {
    City? city,
    super.type,
    FutureOr<void> Function(Station station, City? city)? onTap,
    FutureOr<void> Function(Station station, City? city)? onLongPress,
    dynamic Function(Station station, City? city) funcTitle = dFuncTitle,
    dynamic Function(Station station, City? city) funcSubtitle = dFuncSubtitle,
    dynamic Function(Station station, City? city) funcTrailing = dFuncTrailing,
    dynamic Function(Station station, City? city) funcLeading = dFuncLeading,
  }) : super(
         title: funcTitle(station, city),
         subtitle: funcSubtitle(station, city),
         leading: funcLeading(station, city),
         trailing: funcTrailing(station, city),
         cupertinoTrailingWidget: true,
         onTap: onTap == null ? null : () => onTap(station, city),
         onLongPress: onLongPress == null
             ? null
             : () => onLongPress(station, city),
       );
  static List<TdxBusStationListTile> fromStations(
    List<Station> stations, {
    String? searchText,
    FutureOr<void> Function(Station station, City? city)? onTap,
    FutureOr<void> Function(Station station, City? city)? onLongPress,
    dynamic Function(Station station, City? city) funcTitle = dFuncTitle,
    dynamic Function(Station station, City? city) funcSubtitle = dFuncSubtitle,
    dynamic Function(Station station, City? city) funcTrailing = dFuncTrailing,
    dynamic Function(Station station, City? city) funcLeading = dFuncLeading,
  }) => stations
      .where((Station station) {
        final text = searchText?.toLowerCase() ?? '';
        final stationNameZhTw = station.stationName?.zhTw?.toLowerCase() ?? '';
        final stationNameEn = station.stationName?.en?.toLowerCase() ?? '';
        return stationNameZhTw.contains(text) || stationNameEn.contains(text);
      })
      .map(
        (station) => TdxBusStationListTile(
          station,
          onTap: onTap,
          onLongPress: onLongPress,
          funcTitle: funcTitle,
          funcSubtitle: funcSubtitle,
          funcTrailing: funcTrailing,
          funcLeading: funcLeading,
        ),
      )
      .toList();
}

Text dFuncTitle(Station station, City? city) =>
    Text(station.stationName?.text ?? '');
Text dFuncSubtitle(Station station, City? city) =>
    Text(station.stationAddress ?? '');
Null dFuncTrailing(Station station, City? city) => null;
Icon dFuncLeading(Station station, City? city) => Icon(Icons.departure_board);
