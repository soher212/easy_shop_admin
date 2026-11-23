import 'package:easy_shop_admin/core/networking/api_error_handler.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/add_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/update_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_form_state.dart';

class ProductFormCubit extends Cubit<ProductFormState> {
  final GetCategoriesUseCase _getCategories;
  final AddProductUseCase _addProduct;
  final UpdateProductUseCase _updateProduct;
  final DeleteProductUseCase _deleteProduct;

  ProductFormCubit(
    this._getCategories,
    this._addProduct,
    this._updateProduct,
    this._deleteProduct,
  ) : super(const ProductFormState());

  Future<void> loadCategories() async {
    emit(state.copyWith(status: ProductFormStatus.loading));
    try {
      final categories = await _getCategories();
      emit(
        state.copyWith(status: ProductFormStatus.ready, categories: categories),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ProductFormStatus.failure,
          message: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }

  Future<void> add(ProductFormData data) => _run(() => _addProduct(data));

  Future<void> update(int id, ProductFormData data) {
    return _run(() => _updateProduct(id, data));
  }

  Future<void> delete(int id) => _run(() => _deleteProduct(id));

  Future<void> _run(Future<void> Function() action) async {
    emit(state.copyWith(status: ProductFormStatus.submitting));
    try {
      await action();
      emit(state.copyWith(status: ProductFormStatus.saved));
    } catch (error) {
      emit(
        state.copyWith(
          status: ProductFormStatus.failure,
          message: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }
}
