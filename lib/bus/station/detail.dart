import 'dart:async';

import 'package:asallenshih_flutter_tdx/bus/station/api.dart' deferred as api;
import 'package:asallenshih_flutter_tdx/type/basic/city.dart';
import 'package:asallenshih_flutter_tdx/type/bus/bearing.dart';
import 'package:asallenshih_flutter_tdx/type/bus/station.dart';
import 'package:cross_platform_ui/cross_platform.dart';
import 'package:flutter/material.dart';

class TdxBusStationDetail {
  final City city;
  final Station station;
  final String closeText;
  final String? loadingText;
  final String? addressText;
  final String? bearingText;
  final String? bearingEastText;
  final String? bearingWestText;
  final String? bearingSouthText;
  final String? bearingNorthText;
  final String? bearingSoutheastText;
  final String? bearingNortheastText;
  final String? bearingSouthwestText;
  final String? bearingNorthwestText;
  final String? confirmText;
  FutureOr<void> Function()? onConfirm;
  Station? stationDetail;
  TdxBusStationDetail(
    this.city,
    this.station, {
    required this.closeText,
    this.loadingText,
    this.addressText,
    this.bearingText,
    this.bearingEastText,
    this.bearingWestText,
    this.bearingSouthText,
    this.bearingNorthText,
    this.bearingSoutheastText,
    this.bearingNortheastText,
    this.bearingSouthwestText,
    this.bearingNorthwestText,
    this.confirmText,
    this.onConfirm,
  });
  Future<void> popup(BuildContext context) async {
    if (stationDetail == null) {
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
      await api.loadLibrary();
      stationDetail = await api.TdxBusStationApi.getPopup(city, station);
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
    }
    final String statonName = stationDetail?.stationName?.text ?? '';
    final String? stationAddress = stationDetail?.stationAddress;
    final Bearing? bearing = stationDetail?.bearing;
    final String? bearingString = bearing == null
        ? null
        : switch (bearing) {
            Bearing.east => bearingEastText,
            Bearing.west => bearingWestText,
            Bearing.south => bearingSouthText,
            Bearing.north => bearingNorthText,
            Bearing.southeast => bearingSoutheastText,
            Bearing.northeast => bearingNortheastText,
            Bearing.southwest => bearingSouthwestText,
            Bearing.northwest => bearingNorthwestText,
          };
    await dialogShow(
      context: context,
      builder: (context) {
        return CrossPlatformDialogAlert(
          icon: const Icon(Icons.directions_bus),
          title: Text(statonName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (stationAddress != null && addressText != null)
                Text('$addressText: $stationAddress'),
              if (bearingString != null && bearingText != null)
                Text('$bearingText: $bearingString'),
            ],
          ),
          actions: [
            if (onConfirm != null && confirmText != null)
              CrossPlatformButtonDialog(
                child: Text(confirmText!),
                onPressed: () async {
                  await onConfirm!();
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
}
