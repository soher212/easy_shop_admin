import 'package:easy_shop_admin/core/constants/app_assets.dart';
import 'package:easy_shop_admin/core/helpers/validators.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/localization/language_switcher.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateCanSubmit);
    _passwordController.addListener(_updateCanSubmit);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateCanSubmit() {
    final filled =
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty;
    if (filled != _canSubmit) setState(() => _canSubmit = filled);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _onState(BuildContext context, AuthState state) {
    if (state is AuthOtpSent) {
      Navigator.pushNamed(context, Routes.otp, arguments: state.email);
    } else if (state is AuthFailure) {
      showAppSnackBar(context, state.message, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _onState,
          builder: (context, state) => SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.screenPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: LanguageSwitcher(),
                  ),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  const _Header(),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  AppTextField(
                    label: context.l10n.email,
                    hint: 'your@business.com',
                    controller: _emailController,
                    validator: (value) => Validators.email(value, context.l10n),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  AppTextField(
                    label: context.l10n.password,
                    hint: context.l10n.enterPassword,
                    controller: _passwordController,
                    validator: (value) =>
                        Validators.password(value, context.l10n),
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                  ),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  AppButton(
                    label: context.l10n.signIn,
                    isLoading: state is AuthLoading,
                    onPressed: _canSubmit ? _submit : null,
                  ),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  _RegisterPrompt(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      Routes.register,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(AppDimensions.spaceSmall),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
        ),
        const SizedBox(height: AppDimensions.spaceMedium),
        Text(context.l10n.welcomeBack, style: AppTextStyles.title),
        const SizedBox(height: AppDimensions.spaceSmall / 2),
        Text(context.l10n.signInDescription, style: AppTextStyles.caption),
        const SizedBox(height: AppDimensions.spaceSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            context.l10n.forBusiness,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _RegisterPrompt extends StatelessWidget {
  final VoidCallback onTap;

  const _RegisterPrompt({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${context.l10n.newMerchant} ', style: AppTextStyles.caption),
        GestureDetector(
          onTap: onTap,
          child: Text(
            context.l10n.createAccount,
            style: AppTextStyles.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
