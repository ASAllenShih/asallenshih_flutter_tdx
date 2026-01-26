// 車輛狀態備註 : [0:'正常',1:'尚未發車',2:'交管不停靠',3:'末班車已過',4:'今日未營運']
import 'package:collection/collection.dart';

enum StopStatus {
  normal(0),
  noDeparture(1),
  reRouted(2),
  serviceOver(3),
  noService(4);

  final int value;
  const StopStatus(this.value);

  static StopStatus? fromValue(int? value) =>
      StopStatus.values.firstWhereOrNull((status) => status.value == value);
}
