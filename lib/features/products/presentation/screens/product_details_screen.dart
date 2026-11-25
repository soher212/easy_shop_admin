import 'package:easy_shop_admin/core/helpers/format.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_image.dart';
import 'package:easy_shop_admin/core/widgets/status_badge.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  Future<void> _edit(BuildContext context) async {
    final changed = await Navigator.pushNamed<bool>(
      context,
      Routes.productForm,
      arguments: product,
    );
    if (changed == true && context.mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.productDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _edit(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppImage(
                path: product.imagePath,
                size: 230,
                width: double.infinity,
                borderRadius: BorderRadius.zero,
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.title.copyWith(fontSize: 24),
                    ),
                    Text(product.categoryName, style: AppTextStyles.caption),
                    const SizedBox(height: AppDimensions.spaceMedium),
                    _StatsCard(product: product),
                    if (product.description.isNotEmpty) ...[
                      const SizedBox(height: AppDimensions.spaceMedium),
                      _InfoCard(
                        title: context.l10n.description,
                        child: Text(
                          product.description,
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppDimensions.spaceMedium),
                    _InfoCard(
                      title: context.l10n.productDetails,
                      child: Column(
                        children: [
                          _DetailRow(
                            context.l10n.category,
                            product.categoryName,
                          ),
                          if (product.createdAt != null)
                            _DetailRow(
                              context.l10n.added,
                              formatDate(
                                product.createdAt!,
                                locale: Localizations.localeOf(
                                  context,
                                ).languageCode,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceLarge),
                    AppButton(
                      label: context.l10n.editProduct,
                      onPressed: () => _edit(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final ProductEntity product;

  const _StatsCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _Stat(
              label: context.l10n.price,
              child: Text(
                formatPrice(product.price),
                style: AppTextStyles.title.copyWith(color: AppColors.primary),
              ),
            ),
            const VerticalDivider(width: 1, color: AppColors.border),
            _Stat(
              label: context.l10n.inStock,
              child: Text('${product.quantity}', style: AppTextStyles.title),
            ),
            const VerticalDivider(width: 1, color: AppColors.border),
            _Stat(
              label: context.l10n.visibility,
              child: product.isVisible
                  ? StatusBadge(
                      label: context.l10n.visible,
                      color: AppColors.success,
                      background: AppColors.successLight,
                    )
                  : StatusBadge(
                      label: context.l10n.hidden,
                      color: AppColors.textGrey,
                      background: AppColors.hiddenLight,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final Widget child;

  const _Stat({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSmall),
          child,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.caption.copyWith(fontSize: 14)),
          Text(
            value,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
