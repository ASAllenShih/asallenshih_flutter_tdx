import 'package:asallenshih_flutter_util/lang.dart' as util_lang;
import 'package:asallenshih_flutter_util/langs.dart';

class Lang {
  Lang({this.zhTw, this.en});
  final String? zhTw;
  final String? en;
  String get text => util_lang.Lang.t({Langs.zhHantTW: zhTw, Langs.en: en});
  static Lang? fromMap(Map<String, dynamic>? json) => json == null
      ? null
      : Lang(zhTw: json['Zh_tw'] as String?, en: json['En'] as String?);
}
