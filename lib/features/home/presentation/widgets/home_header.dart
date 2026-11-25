import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/localization/language_switcher.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_image.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final ProfileEntity profile;

  const HomeHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final white70 = AppColors.onPrimary.withValues(alpha: 0.8);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: AppColors.onPrimary,
            shape: BoxShape.circle,
          ),
          child: AppImage(
            path: profile.pictureUrl,
            size: 48,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        const SizedBox(width: AppDimensions.spaceMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greetingFor(DateTime.now(), context),
                style: AppTextStyles.caption.copyWith(color: white70),
              ),
              Text(
                profile.name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                profile.businessName,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(color: white70),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const LanguageSwitcher(),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.onPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.onPrimary,
          ),
        ),
      ],
    );
  }
}

String _greetingFor(DateTime now, BuildContext context) {
  if (now.hour < 12) return context.l10n.goodMorning;
  if (now.hour < 17) return context.l10n.goodAfternoon;
  return context.l10n.goodEvening;
}
