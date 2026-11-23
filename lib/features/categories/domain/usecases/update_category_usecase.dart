import 'package:easy_shop_admin/features/categories/domain/repositories/categories_repo.dart';

class UpdateCategoryUseCase {
  final CategoriesRepo _categoriesRepo;

  UpdateCategoryUseCase(this._categoriesRepo);

  Future<void> call({
    required int id,
    required String name,
    required String description,
  }) {
    return _categoriesRepo.updateCategory(
      id: id,
      name: name,
      description: description,
    );
  }
}
