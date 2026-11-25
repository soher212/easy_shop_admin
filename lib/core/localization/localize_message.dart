import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:flutter/widgets.dart';

String localizeAppMessage(BuildContext context, String message) {
  switch (message.trim().toLowerCase()) {
    case 'something went wrong, please try again':
    case 'something went wrong. please try again.':
    case 'something went wrong':
      return context.l10n.requestFailed;
    case 'connection timed out, please try again':
      return context.l10n.connectionTimedOut;
    case 'could not reach the server, check your internet connection':
      return context.l10n.serverUnavailable;
    case 'could not load your profile.':
      return context.l10n.profileLoadFailed;
    case 'could not save your profile':
      return context.l10n.couldNotSaveProfile;
    default:
      return message;
  }
}
