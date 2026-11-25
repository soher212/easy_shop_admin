import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepName;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    required this.stepName,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            final isDone = index < currentStep;
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 6),
                decoration: BoxDecoration(
                  color: isDone ? AppColors.primary : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppDimensions.spaceSmall),
        Text(
          context.l10n.stepProgress('$currentStep', '$totalSteps', stepName),
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
