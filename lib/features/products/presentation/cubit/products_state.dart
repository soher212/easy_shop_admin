part of 'products_cubit.dart';

sealed class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductEntity> products;
  final String query;

  ProductsSuccess(this.products, {this.query = ''});

  List<ProductEntity> get filtered {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return products;
    return products
        .where(
          (product) =>
              product.name.toLowerCase().contains(text) ||
              product.categoryName.toLowerCase().contains(text),
        )
        .toList();
  }
}

class ProductsFailure extends ProductsState {
  final String message;

  ProductsFailure(this.message);
}
