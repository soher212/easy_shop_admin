import 'package:easy_shop_admin/core/constants/app_assets.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/localization/language_switcher.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback? onTap;

  const SplashScreen({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _LogoTile(),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  Text(
                    'Easy Shop',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.onPrimary,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceSmall / 2),
                  Text(
                    context.l10n.merchantPortal,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 56),
                  const _LoadingDots(),
                ],
              ),
            ),
          ),
          const SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: LanguageSwitcher(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoTile extends StatelessWidget {
  const _LogoTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      padding: const EdgeInsets.all(AppDimensions.spaceMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
    );
  }
}

class _LoadingDots extends StatelessWidget {
  const _LoadingDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (_) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.onPrimary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
