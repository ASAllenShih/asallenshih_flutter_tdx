import 'package:asallenshih_flutter_tdx/type/bus/direction.dart';
import 'package:asallenshih_flutter_tdx/type/bus/stop_status.dart';

class EstimatedTime {
  final String? plateNumb;
  final String? stopUID;
  final String? routeUID;
  final Direction? direction;
  final int? estimateTime;
  final String? scheduledTime;
  final StopStatus? stopStatus;
  final DateTime? nextBusTime;
  final bool? isLastBus;
  final DateTime? dataTime;
  EstimatedTime({
    this.plateNumb,
    this.stopUID,
    this.routeUID,
    this.direction,
    this.estimateTime,
    this.scheduledTime,
    this.stopStatus,
    this.nextBusTime,
    this.isLastBus,
    this.dataTime,
  });
  static EstimatedTime? fromMap(Map<String, dynamic>? map) => map == null
      ? null
      : EstimatedTime(
          plateNumb: map['PlateNumb'],
          stopUID: map['StopUID'],
          routeUID: map['RouteUID'],
          direction: Direction.fromValue(map['Direction']),
          estimateTime: map['EstimateTime'],
          scheduledTime: map['ScheduledTime'],
          stopStatus: StopStatus.fromValue(map['StopStatus']),
          nextBusTime: map['NextBusTime'] != null
              ? DateTime.tryParse(map['NextBusTime'])
              : null,
          isLastBus: map['IsLastBus'],
          dataTime: map['DataTime'] != null
              ? DateTime.tryParse(map['DataTime'])
              : null,
        );

  static List<EstimatedTime> fromMaps(Iterable<dynamic>? maps) =>
      (maps ?? <dynamic>[])
          .map((e) => fromMap(e as Map<String, dynamic>?))
          .whereType<EstimatedTime>()
          .toList();
}
