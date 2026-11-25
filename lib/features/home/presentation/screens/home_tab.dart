import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/error_view.dart';
import 'package:easy_shop_admin/features/home/domain/entities/home_dashboard.dart';
import 'package:easy_shop_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_shop_admin/features/home/presentation/widgets/home_header.dart';
import 'package:easy_shop_admin/features/home/presentation/widgets/quick_actions.dart';
import 'package:easy_shop_admin/features/home/presentation/widgets/section_header.dart';
import 'package:easy_shop_admin/features/home/presentation/widgets/stats_card.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/presentation/widgets/order_tile.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/presentation/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onSeeAllOrders;
  final VoidCallback onSeeAllProducts;
  final VoidCallback onAddProduct;
  final VoidCallback onCategories;
  final ValueChanged<ProductEntity> onOpenProduct;
  final ValueChanged<OrderEntity> onOpenOrder;

  const HomeTab({
    super.key,
    required this.onSeeAllOrders,
    required this.onSeeAllProducts,
    required this.onAddProduct,
    required this.onCategories,
    required this.onOpenProduct,
    required this.onOpenOrder,
  });

  static const _recentOrdersCount = 3;
  static const _overviewProductsCount = 4;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => switch (state) {
        HomeLoading() => const Center(child: CircularProgressIndicator()),
        HomeFailure(:final message) => ErrorView(
          message: message,
          onRetry: () => context.read<HomeCubit>().load(),
        ),
        HomeSuccess(:final dashboard) => RefreshIndicator(
          onRefresh: () => context.read<HomeCubit>().load(),
          child: _Content(
            dashboard: dashboard,
            onSeeAllOrders: onSeeAllOrders,
            onSeeAllProducts: onSeeAllProducts,
            onAddProduct: onAddProduct,
            onCategories: onCategories,
            onOpenProduct: onOpenProduct,
            onOpenOrder: onOpenOrder,
          ),
        ),
      },
    );
  }
}

class _Content extends StatelessWidget {
  final HomeDashboard dashboard;
  final VoidCallback onSeeAllOrders;
  final VoidCallback onSeeAllProducts;
  final VoidCallback onAddProduct;
  final VoidCallback onCategories;
  final ValueChanged<ProductEntity> onOpenProduct;
  final ValueChanged<OrderEntity> onOpenOrder;

  const _Content({
    required this.dashboard,
    required this.onSeeAllOrders,
    required this.onSeeAllProducts,
    required this.onAddProduct,
    required this.onCategories,
    required this.onOpenProduct,
    required this.onOpenOrder,
  });

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    const gap = SizedBox(height: AppDimensions.spaceSmall + 4);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: topInset + 130,
                width: double.infinity,
                color: AppColors.primary,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.screenPadding,
                  topInset + AppDimensions.spaceMedium,
                  AppDimensions.screenPadding,
                  0,
                ),
                child: Column(
                  children: [
                    HomeHeader(profile: dashboard.profile),
                    const SizedBox(height: AppDimensions.spaceMedium),
                    StatsCard(dashboard: dashboard),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(title: context.l10n.quickActions),
                gap,
                QuickActions(
                  onAddProduct: onAddProduct,
                  onCategories: onCategories,
                ),
                const SizedBox(height: AppDimensions.spaceLarge),
                SectionHeader(
                  title: context.l10n.recentOrders,
                  onSeeAll: onSeeAllOrders,
                ),
                gap,
                if (dashboard.orders.isEmpty)
                  _EmptyText(context.l10n.noOrdersYet)
                else
                  for (final order in dashboard.orders.take(
                    HomeTab._recentOrdersCount,
                  )) ...[
                    OrderTile(order: order, onTap: () => onOpenOrder(order)),
                    gap,
                  ],
                const SizedBox(height: AppDimensions.spaceSmall),
                SectionHeader(
                  title: context.l10n.productsOverview,
                  onSeeAll: onSeeAllProducts,
                ),
                gap,
                if (dashboard.products.isEmpty)
                  _EmptyText(context.l10n.noProductsYet)
                else
                  for (final product in dashboard.products.take(
                    HomeTab._overviewProductsCount,
                  )) ...[
                    ProductTile(
                      product: product,
                      onTap: () => onOpenProduct(product),
                    ),
                    gap,
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyText extends StatelessWidget {
  final String text;

  const _EmptyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceMedium),
      child: Center(child: Text(text, style: AppTextStyles.caption)),
    );
  }
}
