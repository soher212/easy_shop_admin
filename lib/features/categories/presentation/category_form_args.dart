import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';

class CategoryFormArgs {
  final CategoryEntity? category;
  final int productsCount;

  const CategoryFormArgs({this.category, this.productsCount = 0});
}
