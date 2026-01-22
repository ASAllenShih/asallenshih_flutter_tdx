import 'package:asallenshih_flutter_tdx/type/bus/bearing.dart';
import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';
import 'package:asallenshih_flutter_tdx/type/universal/position.dart';

class Station {
  final String? stationUID;
  final Lang? stationName;
  final Position? stationPosition;
  final String? stationAddress;
  final Bearing? bearing;
  Station({
    this.stationUID,
    this.stationName,
    this.stationPosition,
    this.stationAddress,
    this.bearing,
  });
  static Station? fromMap(Map<String, dynamic>? map) {
    return map == null
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
          );
  }

  static List<Station> fromMaps(Iterable<dynamic>? maps) {
    return (maps ?? <dynamic>[])
        .map((e) => fromMap(e as Map<String, dynamic>?))
        .whereType<Station>()
        .toList();
  }
}
