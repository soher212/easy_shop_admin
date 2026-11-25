import 'package:easy_shop_admin/core/helpers/location_helper.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/open_settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// Reads the device location; null when it can't, after telling the user why.
Future<Position?> pickCurrentLocation(BuildContext context) async {
  try {
    return await LocationHelper.getCurrentPosition();
  } on LocationFailure catch (failure) {
    if (!context.mounted) return null;
    if (failure == LocationFailure.deniedForever) {
      await showOpenSettingsDialog(
        context,
        title: context.l10n.locationBlocked,
        message: context.l10n.locationPermissionBlocked,
        openSettings: Geolocator.openAppSettings,
      );
    } else {
      final message = switch (failure) {
        LocationFailure.serviceDisabled => context.l10n.locationServicesOff,
        LocationFailure.denied => context.l10n.locationPermissionNeeded,
        LocationFailure.deniedForever => context.l10n.locationPermissionBlocked,
        LocationFailure.unavailable => context.l10n.locationRequestFailed,
      };
      showAppSnackBar(context, message, isError: true);
    }
    return null;
  }
}
