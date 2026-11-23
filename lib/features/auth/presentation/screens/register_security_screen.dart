import 'package:easy_shop_admin/core/helpers/validators.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/core/widgets/field_label.dart';
import 'package:easy_shop_admin/core/widgets/profile_picture_picker.dart';
import 'package:easy_shop_admin/features/auth/domain/entities/register_data.dart';
import 'package:easy_shop_admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_shop_admin/features/auth/presentation/widgets/step_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterSecurityScreen extends StatefulWidget {
  final RegisterData data;

  const RegisterSecurityScreen({super.key, required this.data});

  @override
  State<RegisterSecurityScreen> createState() => _RegisterSecurityScreenState();
}

class _RegisterSecurityScreenState extends State<RegisterSecurityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  XFile? _picture;
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateCanSubmit);
    _confirmController.addListener(_updateCanSubmit);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _updateCanSubmit() {
    final filled =
        _passwordController.text.isNotEmpty &&
        _confirmController.text.isNotEmpty;
    if (filled != _canSubmit) setState(() => _canSubmit = filled);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final data = widget.data.copyWith(
      picture: _picture,
      password: _passwordController.text,
    );
    context.read<AuthCubit>().register(data);
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
      appBar: AppBar(title: const Text('Create Account')),
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
                  const StepProgressBar(currentStep: 3, stepName: 'Security'),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  const Text('Security', style: AppTextStyles.title),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  const FieldLabel('Profile Picture', isOptional: true),
                  const SizedBox(height: AppDimensions.spaceSmall),
                  ProfilePicturePicker(
                    picture: _picture,
                    onPicked: (file) => setState(() => _picture = file),
                  ),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  AppTextField(
                    label: 'Password',
                    hint: 'Create a strong password',
                    controller: _passwordController,
                    validator: Validators.password,
                    textInputAction: TextInputAction.next,
                    isPassword: true,
                  ),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  AppTextField(
                    label: 'Confirm Password',
                    hint: 'Repeat your password',
                    controller: _confirmController,
                    validator: Validators.confirmPassword(
                      () => _passwordController.text,
                    ),
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                  ),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  AppButton(
                    label: 'Create Account',
                    isLoading: state is AuthLoading,
                    onPressed: _canSubmit ? _submit : null,
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
