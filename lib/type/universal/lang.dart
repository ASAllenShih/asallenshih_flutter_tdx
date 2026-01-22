class Lang {
  Lang({this.zhTw, this.en});
  final String? zhTw;
  final String? en;
  static Lang? fromMap(Map<String, dynamic>? json) {
    return json == null
        ? null
        : Lang(zhTw: json['Zh_tw'] as String?, en: json['En'] as String?);
  }
}
