import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/core/widgets/pick_image_sheet.dart';
import 'package:easy_shop_admin/features/auth/domain/entities/register_data.dart';
import 'package:easy_shop_admin/features/auth/presentation/widgets/action_field.dart';
import 'package:easy_shop_admin/features/auth/presentation/widgets/step_progress_bar.dart';
import 'package:easy_shop_admin/features/maps/presentation/pick_location_on_map.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBusinessScreen extends StatefulWidget {
  final RegisterData data;

  const RegisterBusinessScreen({super.key, required this.data});

  @override
  State<RegisterBusinessScreen> createState() => _RegisterBusinessScreenState();
}

class _RegisterBusinessScreenState extends State<RegisterBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  double? _latitude;
  double? _longitude;
  String? _locationLabel;
  XFile? _commercialRegister;
  XFile? _taxCard;
  bool _canContinue = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateCanContinue);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _updateCanContinue() {
    final hasName = _nameController.text.trim().isNotEmpty;
    if (hasName != _canContinue) setState(() => _canContinue = hasName);
  }

  Future<void> _setLocation() async {
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
    if (file != null) setState(() => _commercialRegister = file);
  }

  Future<void> _pickTaxCard() async {
    final file = await pickGalleryImage(context);
    if (file != null) setState(() => _taxCard = file);
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final updated = widget.data.copyWith(
      businessName: _nameController.text.trim(),
      businessAddress: _addressController.text.trim(),
      latitude: _latitude,
      longitude: _longitude,
      commercialRegister: _commercialRegister,
      taxCard: _taxCard,
    );
    Navigator.pushNamed(context, Routes.registerSecurity, arguments: updated);
  }

  String? get _locationText {
    if (_latitude == null || _longitude == null) return null;
    return '${_locationLabel ?? context.l10n.storeLocation} — ${context.l10n.locationSet}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.createAccount)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StepProgressBar(
                  currentStep: 2,
                  stepName: context.l10n.stepBusiness,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                Text(
                  context.l10n.businessInformation,
                  style: AppTextStyles.title,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.businessName,
                  hint: context.l10n.businessName,
                  controller: _nameController,
                  validator: (value) => (value?.trim().isEmpty ?? true)
                      ? context.l10n.businessNameRequired
                      : null,
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
                  doneText: _locationText,
                  doneIcon: Icons.location_on_outlined,
                  softBorder: true,
                  canReplace: true,
                  onTap: _setLocation,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                ActionField(
                  label: context.l10n.commercialRegister,
                  emptyIcon: Icons.upload_outlined,
                  emptyText: context.l10n.uploadCommercialRegister,
                  doneText: _commercialRegister == null
                      ? null
                      : context.l10n.commercialRegisterUploaded,
                  isDashed: true,
                  onTap: _pickCommercialRegister,
                  onClear: () => setState(() => _commercialRegister = null),
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                ActionField(
                  label: context.l10n.taxCard,
                  emptyIcon: Icons.upload_outlined,
                  emptyText: context.l10n.uploadTaxCard,
                  doneText: _taxCard == null
                      ? null
                      : context.l10n.taxCardUploaded,
                  isDashed: true,
                  onTap: _pickTaxCard,
                  onClear: () => setState(() => _taxCard = null),
                ),
                const SizedBox(height: AppDimensions.spaceLarge),
                AppButton(
                  label: context.l10n.continueLabel,
                  onPressed: _canContinue ? _continue : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
