import 'package:asallenshih_flutter_util/cache/addon/time.dart';
import 'package:asallenshih_flutter_util/http.dart';
import 'package:asallenshih_flutter_util/http/addon/cache.dart';
import 'package:asallenshih_flutter_util/http/addon/retry.dart';
import 'package:retry/retry.dart' deferred as retry;

class TdxHttp extends Http {
  TdxHttp(
    String tdx, {
    List<String> select = const [],
    Map<String, String> query = const {},
    Duration duration = Duration.zero,
  }) : super(
         Uri(
           scheme: 'https',
           host: 'api.asallenshih.tw',
           path: '/',
           queryParameters: {
             'service': 'tdx',
             'version': '1',
             'tdx': tdx,
             if (select.isNotEmpty) 'select': select.join(','),
             ...query,
           },
         ),
         addons: [
           HttpAddonCache(
             addons: [
               if (duration != Duration.zero)
                 CacheAddonTime(duration: duration, ignoreExpire: true),
             ],
           ),
           HttpAddonRetry(),
         ],
       );
  @override
  Future<void> request({
    void Function(int downloaded, int total)? onProgress,
  }) async {
    await retry.loadLibrary();
    await retry.retry(
      () => super.request(onProgress: onProgress),
      delayFactor: const Duration(seconds: 1),
      retryIf: (e) => e is HttpRetryException,
      maxAttempts: 10,
    );
  }

  @override
  Future<dynamic> get getJson async {
    final data = await super.getJson;
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      throw Exception(data['error']);
    }
    return data;
  }

  static Future<dynamic> get(
    String tdx, {
    List<String> select = const [],
    Map<String, String> query = const {},
    void Function(int, int)? onProgress,
    Duration duration = Duration.zero,
  }) async {
    final req = TdxHttp(tdx, select: select, query: query, duration: duration);
    await req.request(onProgress: onProgress);
    return await req.getJson;
  }

  static Future<Iterable<dynamic>?> getIterable(
    String tdx, {
    List<String> select = const [],
    Map<String, String> query = const {},
    void Function(int, int)? onProgress,
    Duration duration = Duration.zero,
  }) async {
    final json = await get(
      tdx,
      select: select,
      query: query,
      onProgress: onProgress,
      duration: duration,
    );
    return (json is Iterable<dynamic>) ? json : null;
  }
}
