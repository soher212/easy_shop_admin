import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/features/home/domain/entities/home_dashboard.dart';
import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final HomeDashboard dashboard;

  const StatsCard({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceSmall + 4),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.appColors.shadow,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _StatTile(
                value: dashboard.totalProducts,
                label: 'Total Products',
                icon: Icons.inventory_2_outlined,
                color: AppColors.primary,
                background: context.appColors.primarySoft,
              ),
              const SizedBox(width: AppDimensions.spaceSmall + 4),
              _StatTile(
                value: dashboard.totalOrders,
                label: 'Total Orders',
                icon: Icons.shopping_bag_outlined,
                color: AppColors.info,
                background: context.appColors.infoSoft,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceSmall + 4),
          Row(
            children: [
              _StatTile(
                value: dashboard.pendingOrders,
                label: 'Pending Orders',
                icon: Icons.schedule,
                color: AppColors.warning,
                background: context.appColors.warningSoft,
              ),
              const SizedBox(width: AppDimensions.spaceSmall + 4),
              _StatTile(
                value: dashboard.categoriesCount,
                label: 'Categories',
                icon: Icons.sell_outlined,
                color: AppColors.success,
                background: context.appColors.successSoft,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final int value;
  final String label;
  final IconData icon;
  final Color color;
  final Color background;

  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spaceMedium),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: AppDimensions.spaceSmall + 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$value',
                    style: AppTextStyles.title.copyWith(fontSize: 22),
                  ),
                  Text(
                    label,
                    style: AppTextStyles.caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
