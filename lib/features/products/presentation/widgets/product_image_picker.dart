import 'dart:io';

import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_image.dart';
import 'package:easy_shop_admin/core/widgets/dashed_border.dart';
import 'package:easy_shop_admin/core/widgets/pick_image_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatelessWidget {
  final XFile? image;
  final String? existingImagePath;
  final ValueChanged<XFile> onPicked;

  const ProductImagePicker({
    super.key,
    required this.image,
    required this.onPicked,
    this.existingImagePath,
  });

  static const _height = 150.0;

  Future<void> _pick(BuildContext context) async {
    final file = await pickImageFromSheet(context);
    if (file != null) onPicked(file);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      onTap: () => _pick(context),
      child: DashedBorder(
        radius: AppDimensions.radiusCard,
        child: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final radius = BorderRadius.circular(AppDimensions.radiusCard);
    if (image != null) {
      return Container(
        height: _height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: radius,
          image: DecorationImage(
            image: FileImage(File(image!.path)),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    if (existingImagePath != null) {
      return AppImage(
        path: existingImagePath!,
        size: _height,
        width: double.infinity,
        borderRadius: radius,
      );
    }
    return Container(
      height: _height,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.field, borderRadius: radius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.photo_camera_outlined,
            size: 28,
            color: AppColors.textGrey,
          ),
          const SizedBox(height: AppDimensions.spaceSmall),
          Text(
            context.l10n.addProductImageOptional,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
