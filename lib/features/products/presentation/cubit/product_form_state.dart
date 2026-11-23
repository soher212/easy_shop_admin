part of 'product_form_cubit.dart';

enum ProductFormStatus { loading, ready, submitting, saved, failure }

class ProductFormState {
  final ProductFormStatus status;
  final List<CategoryEntity> categories;
  final String? message;

  const ProductFormState({
    this.status = ProductFormStatus.loading,
    this.categories = const [],
    this.message,
  });

  ProductFormState copyWith({
    ProductFormStatus? status,
    List<CategoryEntity>? categories,
    String? message,
  }) {
    return ProductFormState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      message: message,
    );
  }
}
