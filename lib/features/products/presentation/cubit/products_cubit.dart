import 'package:easy_shop_admin/core/networking/api_error_handler.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase _getProducts;

  ProductsCubit(this._getProducts) : super(ProductsLoading());

  Future<void> load() async {
    emit(ProductsLoading());
    try {
      emit(ProductsSuccess(await _getProducts()));
    } catch (error) {
      emit(ProductsFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  void search(String query) {
    final current = state;
    if (current is ProductsSuccess) {
      emit(ProductsSuccess(current.products, query: query));
    }
  }
}
