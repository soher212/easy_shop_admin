import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/error_view.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/products_cubit.dart';
import 'package:easy_shop_admin/features/products/presentation/widgets/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  final VoidCallback onAddProduct;
  final VoidCallback onManageCategories;
  final ValueChanged<ProductEntity> onOpenProduct;

  const ProductsScreen({
    super.key,
    required this.onAddProduct,
    required this.onManageCategories,
    required this.onOpenProduct,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _Header(onAdd: onAddProduct, onManageCategories: onManageCategories),
          const Divider(height: 1, color: AppColors.border),
          Expanded(child: _ProductsList(onOpenProduct: onOpenProduct)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onManageCategories;

  const _Header({required this.onAdd, required this.onManageCategories});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.screenPadding,
        AppDimensions.spaceMedium,
        AppDimensions.screenPadding,
        AppDimensions.spaceMedium,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Products', style: AppTextStyles.title),
              Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onAdd,
                  child: const SizedBox(
                    width: 38,
                    height: 38,
                    child: Icon(Icons.add, color: AppColors.onPrimary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMedium),
          TextField(
            onChanged: context.read<ProductsCubit>().search,
            decoration: const InputDecoration(
              hintText: 'Search products...',
              prefixIcon: Icon(Icons.search, color: AppColors.textGrey),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSmall + 2),
          GestureDetector(
            onTap: onManageCategories,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.sell_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Manage Categories',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  final ValueChanged<ProductEntity> onOpenProduct;

  const _ProductsList({required this.onOpenProduct});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) => switch (state) {
        ProductsLoading() => const Center(child: CircularProgressIndicator()),
        ProductsFailure(:final message) => ErrorView(
          message: message,
          onRetry: () => context.read<ProductsCubit>().load(),
        ),
        ProductsSuccess() => _buildList(context, state),
      },
    );
  }

  Widget _buildList(BuildContext context, ProductsSuccess state) {
    final products = state.filtered;
    if (products.isEmpty) {
      return Center(
        child: Text(
          state.products.isEmpty
              ? 'No products yet'
              : 'No products match your search',
          style: AppTextStyles.caption,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => context.read<ProductsCubit>().load(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        itemCount: products.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppDimensions.spaceSmall + 4),
        itemBuilder: (context, index) => ProductListItem(
          product: products[index],
          onTap: () => onOpenProduct(products[index]),
        ),
      ),
    );
  }
}
