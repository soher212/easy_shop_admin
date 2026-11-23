import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/error_view.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/presentation/category_form_args.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:easy_shop_admin/features/categories/presentation/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _changed = false;

  Future<void> _openForm([
    CategoryEntity? category,
    int productsCount = 0,
  ]) async {
    final saved = await Navigator.pushNamed<bool>(
      context,
      Routes.categoryForm,
      arguments: CategoryFormArgs(
        category: category,
        productsCount: productsCount,
      ),
    );
    if (saved == true && mounted) {
      _changed = true;
      context.read<CategoriesCubit>().load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.pop(context, _changed);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: AppDimensions.screenPadding - 4,
              ),
              child: Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => _openForm(),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(Icons.add, color: AppColors.onPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) => switch (state) {
            CategoriesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CategoriesFailure(:final message) => ErrorView(
              message: message,
              onRetry: () => context.read<CategoriesCubit>().load(),
            ),
            CategoriesSuccess() => _list(context, state),
          },
        ),
      ),
    );
  }

  Widget _list(BuildContext context, CategoriesSuccess state) {
    final categories = state.categories;
    if (categories.isEmpty) {
      return const Center(
        child: Text('No categories yet', style: AppTextStyles.caption),
      );
    }
    return RefreshIndicator(
      onRefresh: () => context.read<CategoriesCubit>().load(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        itemCount: categories.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppDimensions.spaceSmall + 4),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryTile(
            category: category,
            onTap: () =>
                _openForm(category, state.productsCountOf(category.id)),
          );
        },
      ),
    );
  }
}
