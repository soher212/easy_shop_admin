import 'dart:async';

import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_shop_admin/features/auth/presentation/widgets/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const _otpLength = 6;
  static const _validitySeconds = 10 * 60;

  final _otpController = TextEditingController();
  Timer? _timer;
  int _secondsLeft = _validitySeconds;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(() => setState(() {}));
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _validitySeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String get _timeText {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _onState(BuildContext context, AuthState state) {
    if (state is AuthVerified) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
    } else if (state is AuthOtpSent) {
      _otpController.clear();
      _startTimer();
      showAppSnackBar(context, state.message);
    } else if (state is AuthFailure) {
      showAppSnackBar(context, state.message, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: _onState,
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            final isComplete = _otpController.text.length == _otpLength;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.screenPadding),
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.spaceLarge),
                  const _MailIcon(),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  const Text('Check your email', style: AppTextStyles.title),
                  const SizedBox(height: AppDimensions.spaceSmall),
                  Text(
                    'We sent a 6-digit verification code to\n${widget.email}',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  OtpInput(controller: _otpController, length: _otpLength),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  _ExpiryRow(timeText: _timeText, isExpired: _secondsLeft == 0),
                  const SizedBox(height: AppDimensions.spaceLarge),
                  AppButton(
                    label: 'Verify',
                    isLoading: isLoading,
                    onPressed: isComplete && _secondsLeft > 0
                        ? () => context.read<AuthCubit>().verifyOtp(
                            email: widget.email,
                            otpCode: _otpController.text,
                          )
                        : null,
                  ),
                  const SizedBox(height: AppDimensions.spaceMedium),
                  TextButton.icon(
                    onPressed: isLoading
                        ? null
                        : () => context.read<AuthCubit>().resendOtp(
                            email: widget.email,
                          ),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Resend Code'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MailIcon extends StatelessWidget {
  const _MailIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: context.appColors.primarySoft,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.mail_outline, color: AppColors.primary, size: 30),
    );
  }
}

class _ExpiryRow extends StatelessWidget {
  final String timeText;
  final bool isExpired;

  const _ExpiryRow({required this.timeText, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.schedule, size: 16, color: context.appColors.textMuted),
        const SizedBox(width: 6),
        Text(
          isExpired ? 'Code expired' : 'Code expires in ',
          style: AppTextStyles.caption,
        ),
        if (!isExpired)
          Text(
            timeText,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
          ),
      ],
    );
  }
}
