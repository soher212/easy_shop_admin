import 'package:easy_shop_admin/core/helpers/validators.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/features/auth/domain/entities/register_data.dart';
import 'package:easy_shop_admin/features/auth/presentation/widgets/step_progress_bar.dart';
import 'package:flutter/material.dart';

class RegisterPersonalScreen extends StatefulWidget {
  const RegisterPersonalScreen({super.key});

  @override
  State<RegisterPersonalScreen> createState() => _RegisterPersonalScreenState();
}

class _RegisterPersonalScreenState extends State<RegisterPersonalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalIdController = TextEditingController();

  bool _canContinue = false;

  List<TextEditingController> get _controllers => [
    _nameController,
    _emailController,
    _phoneController,
    _nationalIdController,
  ];

  @override
  void initState() {
    super.initState();
    for (final controller in _controllers) {
      controller.addListener(_updateCanContinue);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateCanContinue() {
    final allFilled = _controllers.every((c) => c.text.trim().isNotEmpty);
    if (allFilled != _canContinue) setState(() => _canContinue = allFilled);
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final data = RegisterData(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: Validators.normalizePhone(_phoneController.text),
      nationalId: _nationalIdController.text.trim(),
    );
    Navigator.pushNamed(context, Routes.registerBusiness, arguments: data);
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
                  currentStep: 1,
                  stepName: context.l10n.stepPersonal,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                Text(
                  context.l10n.personalInformation,
                  style: AppTextStyles.title,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                AppTextField(
                  label: context.l10n.fullName,
                  hint: context.l10n.fullName,
                  controller: _nameController,
                  validator: (value) =>
                      Validators.fullName(value, context.l10n),
                  keyboardType: TextInputType.name,
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
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: AppDimensions.spaceLarge),
                AppButton(
                  label: context.l10n.continueLabel,
                  onPressed: _canContinue ? _continue : null,
                ),
                const SizedBox(height: AppDimensions.spaceMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${context.l10n.alreadyHaveAccount} ',
                      style: AppTextStyles.caption,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, Routes.login),
                      child: Text(
                        context.l10n.signIn,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
