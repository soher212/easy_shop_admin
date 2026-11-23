import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';

abstract class CategoriesRepo {
  Future<List<CategoryEntity>> getCategories();

  Future<void> addCategory({required String name, required String description});

  Future<void> updateCategory({
    required int id,
    required String name,
    required String description,
  });

  Future<void> deleteCategory(int id);
}
