import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/widgets/status_badge.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      OrderStatus.pending => const StatusBadge(
        label: 'Pending',
        color: AppColors.warning,
        background: AppColors.warningLight,
      ),
      OrderStatus.processing => const StatusBadge(
        label: 'Processing',
        color: AppColors.info,
        background: AppColors.infoLight,
      ),
      OrderStatus.completed => const StatusBadge(
        label: 'Completed',
        color: AppColors.success,
        background: AppColors.successLight,
      ),
      OrderStatus.cancelled => const StatusBadge(
        label: 'Cancelled',
        color: AppColors.error,
        background: AppColors.hiddenLight,
      ),
    };
  }
}
