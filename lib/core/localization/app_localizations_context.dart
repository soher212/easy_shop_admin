import 'package:easy_shop_admin/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
