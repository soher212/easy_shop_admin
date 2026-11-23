import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/dashed_border.dart';
import 'package:easy_shop_admin/core/widgets/field_label.dart';
import 'package:flutter/material.dart';

class ActionField extends StatelessWidget {
  final String label;
  final bool isOptional;
  final IconData emptyIcon;
  final String emptyText;
  final String? doneText;
  final VoidCallback onTap;
  final VoidCallback? onClear;
  final bool isDashed;
  final bool canReplace;
  final IconData doneIcon;
  final bool softBorder;

  const ActionField({
    super.key,
    required this.label,
    required this.emptyIcon,
    required this.emptyText,
    required this.onTap,
    this.doneText,
    this.onClear,
    this.isOptional = true,
    this.isDashed = false,
    this.canReplace = false,
    this.doneIcon = Icons.check,
    this.softBorder = false,
  });

  bool get _isDone => doneText != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label, isOptional: isOptional),
        const SizedBox(height: AppDimensions.spaceSmall),
        InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.radiusField),
          onTap: _isDone && !canReplace ? null : onTap,
          child: _isDone ? _doneBox() : _emptyBox(),
        ),
      ],
    );
  }

  Widget _emptyBox() {
    final content = Container(
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(AppDimensions.radiusField),
      ),
      child: Row(
        children: [
          Icon(emptyIcon, size: 20, color: AppColors.textGrey),
          const SizedBox(width: 10),
          Text(
            emptyText,
            style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
          ),
        ],
      ),
    );
    if (!isDashed) return content;
    return DashedBorder(child: content);
  }

  Widget _doneBox() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusField),
        border: Border.all(
          color: softBorder
              ? AppColors.primary.withValues(alpha: 0.35)
              : AppColors.primary,
          width: softBorder ? 1 : 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(doneIcon, size: 20, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              doneText!,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (onClear != null)
            GestureDetector(
              onTap: onClear,
              child: const Icon(
                Icons.close,
                size: 20,
                color: AppColors.textGrey,
              ),
            ),
        ],
      ),
    );
  }
}
