import 'package:asallenshih_flutter_tdx/asallenshih_flutter_tdx.dart';
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/route.dart';
import 'package:asallenshih_flutter_util/device.dart';
import 'package:asallenshih_flutter_util/log.dart';
import 'package:asallenshih_flutter_util/open_url.dart' deferred as ou;
import 'package:asallenshih_flutter_util/webview.dart' deferred as wv;
import 'package:cross_platform_ui/cross_platform.dart';
import 'package:flutter/material.dart' hide Route;

class TdxBusRouteDetail {
  final City city;
  final Route route;
  final String closeText;
  final String? loadingText;
  final String? operatorText;
  final String? departureText;
  final String? destinationText;
  final String? ticketPriceText;
  final String? viewRouteMapText;
  final String? openInBrowserText;
  Route? routeDetail;
  TdxBusRouteDetail(
    this.city,
    this.route, {
    required this.closeText,
    this.loadingText,
    this.operatorText,
    this.departureText,
    this.destinationText,
    this.ticketPriceText,
    this.viewRouteMapText,
    this.openInBrowserText,
  });
  Future<void> popup(BuildContext context) async {
    if (routeDetail == null) {
      dialogShow(
        context: context,
        builder: (context) {
          return CrossPlatformDialogAlert(
            title: Text(loadingText ?? ''),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CrossPlatformProgressIndicator().widget],
            ),
          ).widget;
        },
        barrierDismissible: false,
      );
      routeDetail = await TdxBusRouteApi.getPopup(city, route);
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
    }
    final String routeName = route.routeName?.text ?? '';
    final String? operator = routeDetail?.operators
        ?.map((o) => o.operatorName?.text ?? '')
        .join(', ');
    final String? departureStop = route.departureStopName?.text;
    final String? destinationStop = route.destinationStopName?.text;
    final String? ticketPrice = routeDetail?.ticketPriceDescription?.text;
    await dialogShow(
      context: context,
      builder: (context) {
        return CrossPlatformDialogAlert(
          icon: const Icon(Icons.directions_bus),
          title: Text(routeName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (operator != null && operatorText != null)
                Text('$operatorText: $operator'),
              if (departureStop != null && departureText != null)
                Text('$departureText: $departureStop'),
              if (destinationStop != null && destinationText != null)
                Text('$destinationText: $destinationStop'),
              if (ticketPrice != null && ticketPriceText != null)
                Text('$ticketPriceText: $ticketPrice'),
            ],
          ),
          actions: [
            if (routeDetail?.routeMapImageUrl != null &&
                viewRouteMapText != null)
              CrossPlatformButtonDialog(
                child: Text(viewRouteMapText!),
                onPressed: () {
                  map(context);
                },
              ),
            CrossPlatformButtonDialog(
              child: Text(closeText),
              onPressed: () {
                Navigator.of(context).pop();
              },
              isDefaultAction: true,
            ),
          ],
        ).widget;
      },
    );
  }

  Future<void> map(BuildContext context) async {
    final String routeName = route.routeName?.text ?? '';
    final String? mapUrl = routeDetail?.routeMapImageUrl;
    if (mapUrl == null || mapUrl.isEmpty) {
      return;
    } else if (!Device.supportedWebViewOrIframe) {
      await openBrowser(mapUrl: mapUrl);
      return;
    }
    await dialogShow(
      context: context,
      builder: (context) {
        return CrossPlatformDialogAlert(
          icon: const Icon(Icons.directions_bus),
          title: Text(routeName),
          content: SizedBox(
            width: MediaQuery.of(
              context,
            ).removePadding(removeLeft: true, removeRight: true).size.width,
            child: _map(mapUrl: _mapUrl(mapUrl)),
          ),
          actions: [
            if (openInBrowserText != null)
              CrossPlatformButtonDialog(
                child: Text(openInBrowserText!),
                onPressed: () {
                  openBrowser(mapUrl: mapUrl);
                },
              ),
            CrossPlatformButtonDialog(
              child: Text(closeText),
              onPressed: () {
                Navigator.of(context).pop();
              },
              isDefaultAction: true,
            ),
          ],
        ).widget;
      },
    );
  }

  static String _mapUrl(String mapUrl) => mapUrl.startsWith('https://')
      ? mapUrl
      : mapUrl.startsWith('http://')
      ? 'https://${mapUrl.substring(7)}'
      : 'https://$mapUrl';
  static Widget _map({required String mapUrl}) {
    if (mapUrl.endsWith('.png') ||
        mapUrl.endsWith('.jpg') ||
        mapUrl.endsWith('.jpeg')) {
      return Image.network(
        _mapUrl(mapUrl),
        webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
              log.e('Image load error: $error');
              return _webviewWidget(mapUrl: _mapUrl(mapUrl));
            },
      );
    }
    return _webviewWidget(mapUrl: _mapUrl(mapUrl));
  }

  static Widget _webviewWidget({required String mapUrl}) => FutureBuilder(
    future: _webview(mapUrl: mapUrl),
    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData) {
        return snapshot.data!;
      }
      return Container();
    },
  );

  static Future<Widget> _webview({required String mapUrl}) async {
    await wv.loadLibrary();
    final webview = wv.Webview();
    final webViewSettings = wv.Webview.settings();
    final webViewEnvironmentFuture = wv.Webview.environment();
    final webViewEnvironment = webViewEnvironmentFuture is Future<dynamic>
        ? await webViewEnvironmentFuture
        : webViewEnvironmentFuture;
    return webview.widget(
          webViewEnvironment: webViewEnvironment,
          webViewSettings: webViewSettings,
          initialUri: Uri.tryParse(mapUrl),
        ) ??
        Container();
  }

  static Future<void> openBrowser({required String mapUrl}) async {
    await ou.loadLibrary();
    await ou.OpenUrl.openExtApp(_mapUrl(mapUrl));
  }
}
