import 'package:asallenshih_flutter_util/lang.dart';
import 'package:asallenshih_flutter_util/langs.dart';

class City {
  City({this.cityID, this.cityName, this.cityCode, this.city});
  final String? cityID;
  final String? cityName;
  final String? cityCode;
  final String? city;
  String? get cityNameEn =>
      city?.replaceAllMapped(RegExp(r'(?<!^)([A-Z])'), (m) => ' ${m.group(1)}');
  String get displayName =>
      Lang.t({Langs.zhHantTW: cityName, Langs.en: cityNameEn});
  static City? fromMap(Map<String, dynamic>? json) {
    return json == null
        ? null
        : City(
            cityID: json['CityID'] as String?,
            cityName: json['CityName'] as String?,
            cityCode: json['CityCode'] as String?,
            city: json['City'] as String?,
          );
  }

  static List<City> fromMaps(Iterable<dynamic>? jsons) {
    return (jsons ?? <dynamic>[])
        .map((e) => fromMap(e as Map<String, dynamic>?))
        .whereType<City>()
        .toList();
  }

  static final City busInter = City(
    cityID: '1',
    city: 'Inter',
    cityName: '公路客運',
  );
}
