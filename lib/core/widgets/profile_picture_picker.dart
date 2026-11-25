import 'dart:io';

import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/pick_image_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicturePicker extends StatelessWidget {
  final XFile? picture;
  final ValueChanged<XFile> onPicked;

  const ProfilePicturePicker({
    super.key,
    required this.picture,
    required this.onPicked,
  });

  Future<void> _pick(BuildContext context) async {
    final file = await pickImageFromSheet(context);
    if (file != null) onPicked(file);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _pick(context),
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.hiddenLight,
              border: Border.all(color: AppColors.border, width: 2),
              image: picture == null
                  ? null
                  : DecorationImage(
                      image: FileImage(File(picture!.path)),
                      fit: BoxFit.cover,
                    ),
            ),
            child: picture == null
                ? const Icon(
                    Icons.photo_camera_outlined,
                    color: AppColors.textGrey,
                  )
                : null,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceMedium),
        GestureDetector(
          onTap: () => _pick(context),
          child: Row(
            children: [
              const Icon(
                Icons.photo_camera_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                picture == null
                    ? context.l10n.uploadPhoto
                    : context.l10n.changePhoto,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
