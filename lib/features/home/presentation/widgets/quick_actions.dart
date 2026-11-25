import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onAddProduct;
  final VoidCallback onCategories;

  const QuickActions({
    super.key,
    required this.onAddProduct,
    required this.onCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: 'Add Product',
            icon: Icons.add,
            isPrimary: true,
            onTap: onAddProduct,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceSmall + 4),
        Expanded(
          child: _ActionButton(
            label: 'Categories',
            icon: Icons.sell_outlined,
            isPrimary: false,
            onTap: onCategories,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foreground = isPrimary ? AppColors.onPrimary : AppColors.primary;
    return Material(
      color: isPrimary ? AppColors.primary : context.appColors.primarySoft,
      borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        onTap: onTap,
        child: Container(
          height: 46,
          decoration: isPrimary
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: foreground, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.body.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
