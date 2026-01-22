import 'package:asallenshih_flutter_tdx/type/bus/route.dart';

class TdxBusRouteUtil {
  static List<List<String>> sortTopText = [
    [r'幹線$', r'Metro Bus$'],
  ];
  static List<List<String>> sortEndText = [
    [r'^紅', r'^R'],
    [r'^藍', r'^BL'],
    [r'^綠', r'^G'],
    [r'^棕', r'^BR'],
    [r'^橘', r'^O'],
    [r'^黃', r'^Y'],
    [r'^小', r'^S'],
    [r'^市民小巴', r'^M'],
    [r'^內科', r'^NH'],
    [r'^南軟通勤專車', r'^(NK|NS)'],
    [r'^通勤', r'^CB'],
    [r'^懷恩專車', r'^S'],
    [r'^貓空', r'^Maokong'],
    [r'^兒樂', r"^TPE Child's Amuse."],
    [r'^臺北觀光巴士', r'^Taipei Sightseeing Bus'],
  ];
  static void sortRun(List<Route> routes) {
    routes.sort(sort);
  }

  static int sort(Route a, Route b) {
    final [aResult, bResult] = [a, b].map((route) {
      final zhTw = route.routeName?.zhTw;
      final en = route.routeName?.en;
      for (int i = 0; i < sortTopText.length; i++) {
        if (zhTw != null) {
          final zhTwPattern = RegExp(sortTopText[i][0]);
          if (zhTwPattern.hasMatch(zhTw)) {
            if (en != null) {
              final enPattern = RegExp(sortTopText[i][1]);
              if (enPattern.hasMatch(en)) {
                return '0000${i.toString().padLeft(4, '0')}$en';
              }
            } else {
              return '0000${i.toString().padLeft(4, '0')}$zhTw';
            }
          }
        } else {
          if (en != null) {
            final enPattern = RegExp(sortTopText[i][1]);
            if (enPattern.hasMatch(en)) {
              return '0000${i.toString().padLeft(4, '0')}$en';
            }
          }
        }
      }
      for (int i = 0; i < sortEndText.length; i++) {
        if (zhTw != null) {
          final zhTwPattern = RegExp(sortEndText[i][0]);
          if (zhTwPattern.hasMatch(zhTw)) {
            if (en != null) {
              final enPattern = RegExp(sortEndText[i][1]);
              if (enPattern.hasMatch(en)) {
                return 'ZZZZ${i.toString().padLeft(4, '0')}$en';
              }
            } else {
              return 'ZZZZ${i.toString().padLeft(4, '0')}$zhTw';
            }
          }
        } else {
          if (en != null) {
            final enPattern = RegExp(sortEndText[i][1]);
            if (enPattern.hasMatch(en)) {
              return 'ZZZZ${i.toString().padLeft(4, '0')}$en';
            }
          }
        }
      }
      return en ?? zhTw ?? '';
    }).toList();
    return aResult.compareTo(bResult);
  }
}
