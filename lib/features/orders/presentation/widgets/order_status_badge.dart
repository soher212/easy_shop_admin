import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/widgets/status_badge.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      OrderStatus.pending => StatusBadge(
        label: context.l10n.pending,
        color: AppColors.warning,
        background: AppColors.warningLight,
      ),
      OrderStatus.processing => StatusBadge(
        label: context.l10n.processing,
        color: AppColors.info,
        background: AppColors.infoLight,
      ),
      OrderStatus.completed => StatusBadge(
        label: context.l10n.completed,
        color: AppColors.success,
        background: AppColors.successLight,
      ),
      OrderStatus.cancelled => StatusBadge(
        label: context.l10n.cancelled,
        color: AppColors.error,
        background: AppColors.hiddenLight,
      ),
    };
  }
}
