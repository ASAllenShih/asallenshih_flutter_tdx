import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:collection/collection.dart';

class TdxBasicCityApi {
  static Future<List<City>> get({
    List<String> select = const [],
    void Function(int, int)? onProgress,
    bool bus = false,
  }) async {
    tdx_http.loadLibrary();
    final cities = City.fromMaps(
      await tdx_http.TdxHttp.getIterable(
        'basic/v2/Basic/City',
        select: select,
        onProgress: onProgress,
        duration: const Duration(days: 365),
      ),
    );
    if (bus) {
      cities.insert(0, City.busInter);
    }
    return cities;
  }

  static Future<City?> getByID(
    String cityID, {
    List<String> select = const [],
    void Function(int, int)? onProgress,
    bool bus = false,
  }) async {
    return (await get(
      select: select,
      onProgress: onProgress,
      bus: bus,
    )).firstWhereOrNull((city) => city.cityID == cityID);
  }
}
