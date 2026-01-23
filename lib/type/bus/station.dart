import 'package:asallenshih_flutter_tdx/type/bus/bearing.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop.dart';
import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';
import 'package:asallenshih_flutter_tdx/type/universal/position.dart';

class Station {
  final String? stationUID;
  final Lang? stationName;
  final Position? stationPosition;
  final String? stationAddress;
  final Bearing? bearing;
  final List<Stop>? stops;
  Station({
    this.stationUID,
    this.stationName,
    this.stationPosition,
    this.stationAddress,
    this.bearing,
    this.stops,
  });
  static Station? fromMap(Map<String, dynamic>? map) => map == null
      ? null
      : Station(
          stationUID: map['StationUID'] as String?,
          stationName: Lang.fromMap(
            map['StationName'] as Map<String, dynamic>?,
          ),
          stationPosition: Position.fromMap(
            map['StationPosition'] as Map<String, dynamic>?,
          ),
          stationAddress: map['StationAddress'] as String?,
          bearing: Bearing.fromValue(map['Bearing'] as String?),
          stops: Stop.fromMaps(map['Stops'] as Iterable<dynamic>?),
        );

  static List<Station> fromMaps(Iterable<dynamic>? maps) =>
      (maps ?? <dynamic>[])
          .map((e) => fromMap(e as Map<String, dynamic>?))
          .whereType<Station>()
          .toList();
}
