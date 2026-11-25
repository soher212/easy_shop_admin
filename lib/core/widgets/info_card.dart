import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceMedium),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSmall + 2),
          child,
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Widget value;

  const InfoRow({
    super.key,
    this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: context.appColors.textMuted),
            const SizedBox(width: 8),
          ],
          Text(label, style: AppTextStyles.caption.copyWith(fontSize: 13)),
          const SizedBox(width: AppDimensions.spaceMedium),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: value),
          ),
        ],
      ),
    );
  }
}

class InfoValue extends StatelessWidget {
  final String text;

  const InfoValue(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.isEmpty ? '—' : text,
      textAlign: TextAlign.right,
      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
