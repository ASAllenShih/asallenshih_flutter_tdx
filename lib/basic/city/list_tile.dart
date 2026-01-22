import 'dart:async';

import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:cross_platform_ui/cross_platform/tile.dart';
import 'package:flutter/material.dart';

class TdxBasicCityListTile extends CrossPlatformListTile {
  TdxBasicCityListTile(
    City city, {
    FutureOr<void> Function(City city)? onTap,
    FutureOr<void> Function(City city)? onLongPress,
    dynamic Function(City city) funcTitle = _funcTitle,
    dynamic Function(City city) funcSubtitle = _funcSubtitle,
    dynamic Function(City city) funcTrailing = _funcTrailing,
  }) : super(
         title: funcTitle(city),
         subtitle: funcSubtitle(city),
         leading: Icon(Icons.location_city),
         trailing: funcTrailing(city),
         cupertinoTrailingWidget: true,
         onTap: onTap == null ? null : () => onTap(city),
         onLongPress: onLongPress == null ? null : () => onLongPress(city),
       );
  static List<TdxBasicCityListTile> fromCities(
    List<City> cities, {
    FutureOr<void> Function(City city)? onTap,
    FutureOr<void> Function(City city)? onLongPress,
    dynamic Function(City city) funcTitle = _funcTitle,
    dynamic Function(City city) funcSubtitle = _funcSubtitle,
    dynamic Function(City city) funcTrailing = _funcTrailing,
  }) => cities
      .map(
        (city) => TdxBasicCityListTile(
          city,
          onTap: onTap,
          onLongPress: onLongPress,
          funcTitle: funcTitle,
          funcSubtitle: funcSubtitle,
          funcTrailing: funcTrailing,
        ),
      )
      .toList();
}

Text _funcTitle(City city) => Text(city.displayName);
Null _funcSubtitle(City city) => null;
Null _funcTrailing(City city) => null;
