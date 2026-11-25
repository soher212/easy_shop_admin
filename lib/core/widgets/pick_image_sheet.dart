import 'package:easy_shop_admin/core/helpers/image_picker_helper.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/open_settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

// Picks straight from the gallery (used for documents).
Future<XFile?> pickGalleryImage(BuildContext context) async {
  try {
    return await ImagePickerHelper.pickImage(ImageSource.gallery);
  } on PickImageFailure catch (failure) {
    if (context.mounted) {
      showAppSnackBar(
        context,
        _failureMessage(context, failure),
        isError: true,
      );
    }
    return null;
  }
}

// Asks camera or gallery, then picks; null when the user cancels or it fails.
Future<XFile?> pickImageFromSheet(BuildContext context) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: Text(context.l10n.takePhoto),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(context.l10n.chooseFromGallery),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    ),
  );
  if (source == null || !context.mounted) return null;

  try {
    return await ImagePickerHelper.pickImage(source);
  } on PickImageFailure catch (failure) {
    if (!context.mounted) return null;
    if (failure.canOpenSettings) {
      await showOpenSettingsDialog(
        context,
        title: context.l10n.permissionNeeded,
        message: _failureMessage(context, failure),
        openSettings: Geolocator.openAppSettings,
      );
    } else {
      showAppSnackBar(
        context,
        _failureMessage(context, failure),
        isError: true,
      );
    }
    return null;
  }
}

String _failureMessage(BuildContext context, PickImageFailure failure) {
  return switch (failure) {
    PickImageFailure.cameraDenied => context.l10n.cameraPermissionBlocked,
    PickImageFailure.photosDenied => context.l10n.photosPermissionBlocked,
    PickImageFailure.restricted => context.l10n.cameraRestricted,
    PickImageFailure.noCamera => context.l10n.noCameraAvailable,
    PickImageFailure.failed => context.l10n.imagePickFailed,
  };
}
