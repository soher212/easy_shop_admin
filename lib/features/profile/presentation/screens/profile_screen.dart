import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/localization/language_switcher.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_image.dart';
import 'package:easy_shop_admin/core/widgets/error_view.dart';
import 'package:easy_shop_admin/core/widgets/info_card.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_shop_admin/features/profile/presentation/widgets/store_location_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final ValueChanged<ProfileEntity> onEdit;

  const ProfileScreen({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => switch (state) {
        ProfileLoading() => const Center(child: CircularProgressIndicator()),
        ProfileFailure(:final message) => ErrorView(
          message: message,
          onRetry: () => context.read<ProfileCubit>().load(),
        ),
        ProfileSuccess(:final profile) => RefreshIndicator(
          onRefresh: () => context.read<ProfileCubit>().load(),
          child: _Content(profile: profile, onEdit: onEdit),
        ),
      },
    );
  }
}

class _Content extends StatelessWidget {
  final ProfileEntity profile;
  final ValueChanged<ProfileEntity> onEdit;

  const _Content({required this.profile, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppDimensions.spaceSmall + 4);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 16, top: 12),
              child: LanguageSwitcher(),
            ),
          ),
          _Header(profile: profile),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InfoCard(
                  title: context.l10n.personalInformation,
                  child: Column(
                    children: [
                      InfoRow(
                        icon: Icons.person_outline,
                        label: context.l10n.fullName,
                        value: InfoValue(profile.name),
                      ),
                      InfoRow(
                        icon: Icons.mail_outline,
                        label: context.l10n.email,
                        value: InfoValue(profile.email),
                      ),
                      InfoRow(
                        icon: Icons.phone_outlined,
                        label: context.l10n.phoneNumber,
                        value: InfoValue(profile.phone),
                      ),
                      InfoRow(
                        icon: Icons.tag,
                        label: context.l10n.nationalId,
                        value: InfoValue(profile.nationalId),
                      ),
                    ],
                  ),
                ),
                gap,
                InfoCard(
                  title: context.l10n.businessInformation,
                  child: Column(
                    children: [
                      InfoRow(
                        label: context.l10n.businessName,
                        value: InfoValue(profile.businessName),
                      ),
                      InfoRow(
                        label: context.l10n.businessAddress,
                        value: InfoValue(profile.businessAddress),
                      ),
                      InfoRow(
                        label: context.l10n.storeLocation,
                        value: StoreLocationText(
                          latitude: profile.latitude,
                          longitude: profile.longitude,
                        ),
                      ),
                    ],
                  ),
                ),
                gap,
                InfoCard(
                  title: context.l10n.businessDocuments,
                  child: Column(
                    children: [
                      _DocumentRow(
                        context.l10n.commercialRegister,
                        isUploaded: profile.hasCommercialRegister,
                      ),
                      _DocumentRow(
                        context.l10n.taxCard,
                        isUploaded: profile.hasTaxCard,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceLarge),
                AppButton(
                  label: context.l10n.editProfile,
                  onPressed: () => onEdit(profile),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ProfileEntity profile;

  const _Header({required this.profile});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final white70 = AppColors.onPrimary.withValues(alpha: 0.85);
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(
        AppDimensions.screenPadding,
        topInset + AppDimensions.spaceLarge,
        AppDimensions.screenPadding,
        AppDimensions.spaceLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.onPrimary,
                  shape: BoxShape.circle,
                ),
                child: AppImage(
                  path: profile.pictureUrl,
                  size: 64,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                    Text(
                      profile.businessName,
                      style: AppTextStyles.body.copyWith(
                        color: white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      profile.email,
                      style: AppTextStyles.caption.copyWith(color: white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceSmall + 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.onPrimary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              context.l10n.merchantLabel,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  final String label;
  final bool isUploaded;

  const _DocumentRow(this.label, {required this.isUploaded});

  @override
  Widget build(BuildContext context) {
    final color = isUploaded ? AppColors.success : AppColors.textGrey;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body),
          Row(
            children: [
              Icon(
                isUploaded ? Icons.check : Icons.close,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                isUploaded ? context.l10n.uploaded : context.l10n.notUploaded,
                style: AppTextStyles.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
