import 'package:easy_shop_admin/core/constants/app_assets.dart';
import 'package:easy_shop_admin/core/helpers/validators.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/core/widgets/theme_mode_button.dart';
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: ThemeModeButton(),
                  ),
                  const SizedBox(height: AppDimensions.spaceSmall),
                  const _Header(),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  AppTextField(
                    label: 'Email',
                    hint: 'your@business.com',
                    controller: _emailController,
                    validator: Validators.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  AppTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    validator: Validators.password,
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                  ),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  AppButton(
                    label: 'Sign In',
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
            color: context.appColors.primarySoft,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
        ),
        const SizedBox(height: AppDimensions.spaceMedium),
        const Text('Welcome back', style: AppTextStyles.title),
        const SizedBox(height: AppDimensions.spaceSmall / 2),
        const Text(
          'Sign in to manage your store',
          style: AppTextStyles.caption,
        ),
        const SizedBox(height: AppDimensions.spaceSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: context.appColors.primarySoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'FOR BUSINESS',
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
        const Text('New merchant? ', style: AppTextStyles.caption),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Create merchant account',
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
