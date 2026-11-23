import 'package:easy_shop_admin/core/helpers/format.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_image.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/presentation/widgets/order_status_badge.dart';
import 'package:easy_shop_admin/features/orders/presentation/widgets/payment_method_label.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppDimensions.spaceSmall + 4);
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.screenPadding),
          children: [
            _Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${order.code}',
                        style: AppTextStyles.title.copyWith(fontSize: 20),
                      ),
                      if (order.createdAt != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 14,
                              color: AppColors.textGrey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              formatDateTime(
                                order.createdAt!,
                              ).replaceFirst(' · ', ' at '),
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                    ],
                  ),
                  OrderStatusBadge(order.status),
                ],
              ),
            ),
            gap,
            _Card(
              title: 'CUSTOMER',
              child: _CustomerInfo(order: order),
            ),
            gap,
            _Card(
              title: 'DELIVERY',
              child: _DeliveryInfo(order: order),
            ),
            gap,
            _Card(
              title: 'ORDER ITEMS',
              child: Column(
                children: [
                  for (final item in order.items) _ItemRow(item: item),
                ],
              ),
            ),
            gap,
            _Card(
              title: 'PAYMENT',
              child: PaymentMethodLabel(order.paymentMethod),
            ),
            gap,
            _Card(
              title: 'SUMMARY',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: AppTextStyles.caption),
                  Text(
                    formatPrice(order.total),
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.primary,
                    ),
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

class _Card extends StatelessWidget {
  final String? title;
  final Widget child;

  const _Card({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: AppDimensions.spaceSmall + 2),
          ],
          child,
        ],
      ),
    );
  }
}

class _CustomerInfo extends StatelessWidget {
  final OrderEntity order;

  const _CustomerInfo({required this.order});

  String get _initials {
    final words = order.customerName.trim().split(RegExp(r'\s+'));
    return words.take(2).map((w) => w.isEmpty ? '' : w[0]).join().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary,
              child: Text(
                _initials,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMedium),
            Text(order.customerName, style: AppTextStyles.subtitle),
          ],
        ),
        if (order.customerEmail.isNotEmpty)
          _IconLine(Icons.mail_outline, order.customerEmail),
        if (order.customerPhone.isNotEmpty)
          _IconLine(Icons.phone_outlined, order.customerPhone),
      ],
    );
  }
}

class _DeliveryInfo extends StatelessWidget {
  final OrderEntity order;

  const _DeliveryInfo({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
              color: AppColors.textGrey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                order.address.isEmpty ? 'No address provided' : order.address,
                style: AppTextStyles.body,
              ),
            ),
          ],
        ),
        if (order.hasLocation) ...[
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.orderLocation,
              arguments: order,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  'View on Map',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _IconLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconLine(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textGrey),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.caption.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  final OrderItemEntity item;

  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          AppImage(
            path: item.imagePath,
            size: 52,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: AppDimensions.spaceMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName, style: AppTextStyles.subtitle),
                Text(item.categoryName, style: AppTextStyles.caption),
                Text(
                  '${formatPrice(item.unitPrice)} × ${item.quantity}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Text(formatPrice(item.lineTotal), style: AppTextStyles.subtitle),
        ],
      ),
    );
  }
}
