import 'package:easy_shop_admin/core/helpers/format.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_image.dart';
import 'package:easy_shop_admin/core/widgets/status_badge.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductListItem({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appColors.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceSmall + 4),
          child: Row(
            children: [
              AppImage(
                path: product.imagePath,
                size: 64,
                borderRadius: BorderRadius.circular(14),
              ),
              const SizedBox(width: AppDimensions.spaceMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.subtitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.categoryName,
                      style: AppTextStyles.caption.copyWith(fontSize: 13.5),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          formatPrice(product.price),
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Qty ${product.quantity}',
                          style: AppTextStyles.caption.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  product.isVisible
                      ? StatusBadge(
                          label: 'Visible',
                          color: AppColors.success,
                          background: context.appColors.successSoft,
                        )
                      : StatusBadge(
                          label: 'Hidden',
                          color: context.appColors.textMuted,
                          background: context.appColors.neutralSoft,
                        ),
                  const SizedBox(height: 10),
                  Icon(
                    Icons.chevron_right,
                    color: context.appColors.textMuted,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
