import 'package:asallenshih_flutter_tdx/type/basic/city.dart';

class TdxApi {
  static Future<Map<City, T>> citiesGet<T>(
    List<City> cities,
    Future<T> Function(City city) func,
  ) async {
    final Map<City, T> result = {};
    for (final city in cities) {
      result[city] = await func(city);
    }
    return result;
  }
}
