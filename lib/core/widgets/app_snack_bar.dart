import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/localize_message.dart';
import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(localizeAppMessage(context, message)),
        backgroundColor: isError ? AppColors.error : AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
