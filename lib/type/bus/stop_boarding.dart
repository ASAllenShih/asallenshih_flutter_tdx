import 'package:collection/collection.dart';

enum StopBoarding {
  canGetOff(-1),
  canGetOnAndOff(0),
  canGetOn(1);

  final int value;
  const StopBoarding(this.value);
  static StopBoarding? fromValue(int? value) =>
      StopBoarding.values.firstWhereOrNull((e) => e.value == value);
}
