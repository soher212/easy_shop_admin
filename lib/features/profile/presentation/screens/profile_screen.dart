import 'package:easy_shop_admin/core/theme/app_colors.dart';
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
          _Header(profile: profile),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InfoCard(
                  title: 'PERSONAL INFORMATION',
                  child: Column(
                    children: [
                      InfoRow(
                        icon: Icons.person_outline,
                        label: 'Full Name',
                        value: InfoValue(profile.name),
                      ),
                      InfoRow(
                        icon: Icons.mail_outline,
                        label: 'Email',
                        value: InfoValue(profile.email),
                      ),
                      InfoRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: InfoValue(profile.phone),
                      ),
                      InfoRow(
                        icon: Icons.tag,
                        label: 'National ID',
                        value: InfoValue(profile.nationalId),
                      ),
                    ],
                  ),
                ),
                gap,
                InfoCard(
                  title: 'BUSINESS INFORMATION',
                  child: Column(
                    children: [
                      InfoRow(
                        label: 'Business Name',
                        value: InfoValue(profile.businessName),
                      ),
                      InfoRow(
                        label: 'Business Address',
                        value: InfoValue(profile.businessAddress),
                      ),
                      InfoRow(
                        label: 'Store Location',
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
                  title: 'BUSINESS DOCUMENTS',
                  child: Column(
                    children: [
                      _DocumentRow(
                        'Commercial Register',
                        isUploaded: profile.hasCommercialRegister,
                      ),
                      _DocumentRow('Tax Card', isUploaded: profile.hasTaxCard),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceLarge),
                AppButton(
                  label: 'Edit Profile',
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
              'MERCHANT',
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
                isUploaded ? 'Uploaded' : 'Not uploaded',
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
