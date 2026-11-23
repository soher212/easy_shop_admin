part of 'categories_cubit.dart';

sealed class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> categories;
  final Map<int, int> productsCountByCategory;

  CategoriesSuccess(this.categories, {this.productsCountByCategory = const {}});

  int productsCountOf(int categoryId) =>
      productsCountByCategory[categoryId] ?? 0;
}

class CategoriesFailure extends CategoriesState {
  final String message;

  CategoriesFailure(this.message);
}
