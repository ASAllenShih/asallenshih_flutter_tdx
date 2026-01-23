import 'package:asallenshih_flutter_tdx/type/universal/lang.dart';

class Operator {
  Operator({
    this.operatorID,
    this.operatorName,
    this.operatorCode,
    this.operatorNo,
  });
  final String? operatorID;
  final Lang? operatorName;
  final String? operatorCode;
  final String? operatorNo;
  static Operator? fromMap(Map<String, dynamic>? json) {
    return json == null
        ? null
        : Operator(
            operatorID: json['OperatorID'] as String?,
            operatorName: Lang.fromMap(
              json['OperatorName'] as Map<String, dynamic>?,
            ),
            operatorCode: json['OperatorCode'] as String?,
            operatorNo: json['OperatorNo'] as String?,
          );
  }

  static List<Operator> fromMaps(Iterable<dynamic>? jsons) =>
      (jsons ?? <dynamic>[])
          .map((e) => fromMap(e as Map<String, dynamic>?))
          .whereType<Operator>()
          .toList();
}
