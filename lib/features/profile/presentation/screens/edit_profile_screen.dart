import 'dart:io';

import 'package:easy_shop_admin/core/helpers/validators.dart';
import 'package:easy_shop_admin/core/services/reverse_geocoder.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_image.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/core/widgets/pick_image_sheet.dart';
import 'package:easy_shop_admin/features/auth/presentation/widgets/action_field.dart';
import 'package:easy_shop_admin/features/maps/presentation/pick_location_on_map.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_form_data.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// Shown inside the Profile tab, so the bottom bar stays visible.
// [onClose] is called with true after a successful save, false on back.
class EditProfileScreen extends StatefulWidget {
  final ProfileEntity profile;
  final ValueChanged<bool> onClose;

  const EditProfileScreen({
    super.key,
    required this.profile,
    required this.onClose,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.profile.name);
  late final _emailController = TextEditingController(
    text: widget.profile.email,
  );
  late final _phoneController = TextEditingController(
    text: widget.profile.phone,
  );
  late final _nationalIdController = TextEditingController(
    text: widget.profile.nationalId,
  );
  late final _businessController = TextEditingController(
    text: widget.profile.businessName,
  );
  late final _addressController = TextEditingController(
    text: widget.profile.businessAddress,
  );

  late double? _latitude = widget.profile.latitude;
  late double? _longitude = widget.profile.longitude;
  XFile? _picture;
  XFile? _commercialRegister;
  XFile? _taxCard;
  late bool _hasCommercialRegister = widget.profile.hasCommercialRegister;
  late bool _hasTaxCard = widget.profile.hasTaxCard;
  String? _locationLabel;

  @override
  void initState() {
    super.initState();
    if (widget.profile.hasLocation) _loadLocationLabel();
  }

  Future<void> _loadLocationLabel() async {
    final label = await ReverseGeocoder.labelFor(
      widget.profile.latitude!,
      widget.profile.longitude!,
      languageCode: Localizations.localeOf(context).languageCode,
    );
    if (mounted && _locationLabel == null) {
      setState(() => _locationLabel = label);
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _nameController,
      _emailController,
      _phoneController,
      _nationalIdController,
      _businessController,
      _addressController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _changePhoto() async {
    final file = await pickImageFromSheet(context);
    if (file != null) setState(() => _picture = file);
  }

  Future<void> _updateLocation() async {
    final picked = await pickLocationOnMap(
      context,
      latitude: _latitude,
      longitude: _longitude,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _latitude = picked.latitude;
      _longitude = picked.longitude;
      _locationLabel = picked.label;
    });
  }

  Future<void> _pickCommercialRegister() async {
    final file = await pickGalleryImage(context);
    if (file != null) {
      setState(() {
        _commercialRegister = file;
        _hasCommercialRegister = true;
      });
    }
  }

  Future<void> _pickTaxCard() async {
    final file = await pickGalleryImage(context);
    if (file != null) {
      setState(() {
        _taxCard = file;
        _hasTaxCard = true;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<ProfileFormCubit>().submit(
      ProfileFormData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: Validators.normalizePhone(_phoneController.text),
        nationalId: _nationalIdController.text.trim(),
        businessName: _businessController.text.trim(),
        businessAddress: _addressController.text.trim(),
        latitude: _latitude,
        longitude: _longitude,
        picture: _picture,
        commercialRegister: _commercialRegister,
        taxCard: _taxCard,
        removeCommercialRegister:
            !_hasCommercialRegister && widget.profile.hasCommercialRegister,
        removeTaxCard: !_hasTaxCard && widget.profile.hasTaxCard,
      ),
    );
  }

  void _onState(BuildContext context, ProfileFormState state) {
    if (state.status == ProfileFormStatus.saved) {
      widget.onClose(true);
    } else if (state.status == ProfileFormStatus.failure) {
      showAppSnackBar(
        context,
        state.message ?? context.l10n.couldNotSaveProfile,
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.editProfile),
        leading: BackButton(onPressed: () => widget.onClose(false)),
      ),
      body: BlocConsumer<ProfileFormCubit, ProfileFormState>(
        listener: _onState,
        builder: (context, state) => SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AvatarEditor(
                  picture: _picture,
                  existingPath: widget.profile.pictureUrl,
                  onChange: _changePhoto,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.fullName,
                  hint: context.l10n.fullName,
                  controller: _nameController,
                  validator: (value) =>
                      Validators.fullName(value, context.l10n),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.email,
                  hint: 'ahmed@business.com',
                  controller: _emailController,
                  validator: (value) => Validators.email(value, context.l10n),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.phoneNumber,
                  hint: '+20 100 000 0000',
                  controller: _phoneController,
                  validator: (value) => Validators.phone(value, context.l10n),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.nationalId,
                  hint: context.l10n.nationalId,
                  controller: _nationalIdController,
                  validator: (value) =>
                      Validators.nationalId(value, context.l10n),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.businessName,
                  hint: context.l10n.businessName,
                  controller: _businessController,
                  validator: (value) => Validators.required(
                    value,
                    context.l10n.businessName,
                    context.l10n,
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.businessAddress,
                  hint: context.l10n.optional,
                  controller: _addressController,
                  isOptional: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                ActionField(
                  label: context.l10n.storeLocation,
                  emptyIcon: Icons.location_on_outlined,
                  emptyText: context.l10n.tapToSetLocation,
                  doneText: _latitude == null || _longitude == null
                      ? null
                      : '${_locationLabel ?? context.l10n.locationSet} · ${context.l10n.locationUpdated}',
                  doneIcon: Icons.location_on_outlined,
                  softBorder: true,
                  canReplace: true,
                  onTap: _updateLocation,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                ActionField(
                  label: context.l10n.commercialRegister,
                  emptyIcon: Icons.upload_outlined,
                  emptyText: context.l10n.uploadCommercialRegister,
                  doneText: _hasCommercialRegister
                      ? context.l10n.commercialRegisterUploaded
                      : null,
                  isDashed: true,
                  onTap: _pickCommercialRegister,
                  onClear: () => setState(() {
                    _commercialRegister = null;
                    _hasCommercialRegister = false;
                  }),
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                ActionField(
                  label: context.l10n.taxCard,
                  emptyIcon: Icons.upload_outlined,
                  emptyText: context.l10n.uploadTaxCard,
                  doneText: _hasTaxCard ? context.l10n.taxCardUploaded : null,
                  isDashed: true,
                  onTap: _pickTaxCard,
                  onClear: () => setState(() {
                    _taxCard = null;
                    _hasTaxCard = false;
                  }),
                ),
                const SizedBox(height: AppDimensions.spaceLarge),
                AppButton(
                  label: context.l10n.saveChanges,
                  isLoading: state.status == ProfileFormStatus.submitting,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarEditor extends StatelessWidget {
  final XFile? picture;
  final String existingPath;
  final VoidCallback onChange;

  const _AvatarEditor({
    required this.picture,
    required this.existingPath,
    required this.onChange,
  });

  static const _size = 96.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onChange,
          child: picture == null
              ? AppImage(
                  path: existingPath,
                  size: _size,
                  borderRadius: BorderRadius.circular(_size / 2),
                )
              : CircleAvatar(
                  radius: _size / 2,
                  backgroundImage: FileImage(File(picture!.path)),
                ),
        ),
        const SizedBox(height: AppDimensions.spaceSmall),
        GestureDetector(
          onTap: onChange,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.photo_camera_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                context.l10n.changePhoto,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
