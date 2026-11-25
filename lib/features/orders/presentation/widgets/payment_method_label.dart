import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class PaymentMethodLabel extends StatelessWidget {
  final PaymentMethod method;
  final bool small;

  const PaymentMethodLabel(this.method, {super.key, this.small = false});

  @override
  Widget build(BuildContext context) {
    final isCard = method == PaymentMethod.card;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isCard ? Icons.credit_card_outlined : Icons.payments_outlined,
          size: small ? 14 : 20,
          color: context.appColors.textMuted,
        ),
        SizedBox(width: small ? 4 : 8),
        Text(
          isCard ? 'Card' : 'Cash',
          style: small
              ? AppTextStyles.caption
              : AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
