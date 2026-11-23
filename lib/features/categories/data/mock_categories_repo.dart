import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/domain/repositories/categories_repo.dart';

// Temporary: replaced by the real API repository when the server is back.
// Changes live in memory only, so they disappear on a full restart.
class MockCategoriesRepo implements CategoriesRepo {
  final List<CategoryEntity> _categories = [
    const CategoryEntity(
      id: 1,
      name: 'Electronics',
      description: 'Gadgets and tech devices',
    ),
    const CategoryEntity(
      id: 2,
      name: 'Clothing',
      description: 'Fashion and apparel',
    ),
    const CategoryEntity(
      id: 3,
      name: 'Food & Beverages',
      description: 'Edibles and drinks',
    ),
  ];

  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 400));

  @override
  Future<List<CategoryEntity>> getCategories() async {
    await _delay();
    return List.unmodifiable(_categories);
  }

  @override
  Future<void> addCategory({
    required String name,
    required String description,
  }) async {
    await _delay();
    final nextId = _categories.fold<int>(
      0,
      (max, category) => category.id > max ? category.id : max,
    );
    _categories.add(
      CategoryEntity(id: nextId + 1, name: name, description: description),
    );
  }

  @override
  Future<void> updateCategory({
    required int id,
    required String name,
    required String description,
  }) async {
    await _delay();
    final index = _categories.indexWhere((category) => category.id == id);
    if (index == -1) return;
    _categories[index] = CategoryEntity(
      id: id,
      name: name,
      description: description,
    );
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _delay();
    _categories.removeWhere((category) => category.id == id);
  }
}
