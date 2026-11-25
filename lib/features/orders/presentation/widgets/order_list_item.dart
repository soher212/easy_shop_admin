import 'package:easy_shop_admin/core/helpers/format.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/presentation/widgets/order_status_badge.dart';
import 'package:easy_shop_admin/features/orders/presentation/widgets/payment_method_label.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback? onTap;

  const OrderListItem({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final itemsText = order.items.length == 1
        ? '1 item'
        : '${order.items.length} items';
    return Material(
      color: context.appColors.surface,
      borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('#${order.code}', style: AppTextStyles.subtitle),
                  OrderStatusBadge(order.status),
                ],
              ),
              Text(order.customerName, style: AppTextStyles.caption),
              const SizedBox(height: 6),
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  if (order.createdAt != null)
                    _Meta(
                      Icons.calendar_today_outlined,
                      formatDateTime(order.createdAt!),
                    ),
                  _Meta(Icons.shopping_bag_outlined, itemsText),
                  PaymentMethodLabel(order.paymentMethod, small: true),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatPrice(order.total),
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: context.appColors.textMuted,
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

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: context.appColors.textMuted),
        const SizedBox(width: 4),
        Text(text, style: AppTextStyles.caption),
      ],
    );
  }
}
