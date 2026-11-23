import 'package:easy_shop_admin/core/networking/api_error_handler.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _getCategories;
  final GetProductsUseCase _getProducts;

  CategoriesCubit(this._getCategories, this._getProducts)
    : super(CategoriesLoading());

  Future<void> load() async {
    emit(CategoriesLoading());
    try {
      final (categories, products) = await (
        _getCategories(),
        _getProducts(),
      ).wait;

      final counts = <int, int>{};
      for (final product in products) {
        counts[product.categoryId] = (counts[product.categoryId] ?? 0) + 1;
      }
      emit(CategoriesSuccess(categories, productsCountByCategory: counts));
    } catch (error) {
      emit(CategoriesFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}
