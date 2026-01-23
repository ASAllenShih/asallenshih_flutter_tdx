import 'package:asallenshih_flutter_tdx/type/bus/stop_boarding.dart';
import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';

class Stop {
  final String? stopUID;
  final Lang? stopName;
  final String? routeUID;
  final Lang? routeName;
  final StopBoarding? stopBoarding;
  final int? stopSequence;
  final String? stationID;
  final String? locationCityCode;
  Stop({
    this.stopUID,
    this.stopName,
    this.routeUID,
    this.routeName,
    this.stopBoarding,
    this.stopSequence,
    this.stationID,
    this.locationCityCode,
  });
  String? get stationUID => (stationID == null || stopUID == null)
      ? null
      : '${stopUID!.substring(0, 3)}$stationID';
  static Stop? fromMap(Map<String, dynamic>? map) => map == null
      ? null
      : Stop(
          stopUID: map['StopUID'] as String?,
          stopName: Lang.fromMap(map['StopName'] as Map<String, dynamic>?),
          routeUID: map['RouteUID'] as String?,
          routeName: Lang.fromMap(map['RouteName'] as Map<String, dynamic>?),
          stopBoarding: StopBoarding.fromValue(map['StopBoarding'] as int?),
          stopSequence: map['StopSequence'] as int?,
          stationID: map['StationID'] as String?,
          locationCityCode: map['LocationCityCode'] as String?,
        );
  static List<Stop> fromMaps(Iterable<dynamic>? maps) => (maps ?? <dynamic>[])
      .map((e) => fromMap(e as Map<String, dynamic>?))
      .whereType<Stop>()
      .toList();
}
