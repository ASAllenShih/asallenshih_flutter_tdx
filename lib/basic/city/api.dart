import 'package:asallenshih_flutter_tdx/http.dart' deferred as tdx_http;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';

class TdxBasicCityApi {
  static Future<List<City>> get({
    List<String> select = const [],
    void Function(int, int)? onProgress,
  }) async {
    tdx_http.loadLibrary();
    return City.fromMaps(
      await tdx_http.TdxHttp.getIterable(
        'basic/v2/Basic/City',
        select: select,
        onProgress: onProgress,
      ),
    );
  }

  static Future<City?> getByCityID(
    String cityID, {
    List<String> select = const [],
    void Function(int, int)? onProgress,
  }) async {
    return (await get(select: select, onProgress: onProgress) as List<City?>)
        .firstWhere((city) => city?.cityID == cityID, orElse: () => null);
  }
}
