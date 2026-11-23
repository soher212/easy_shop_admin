import 'package:easy_shop_admin/features/categories/domain/repositories/categories_repo.dart';

class DeleteCategoryUseCase {
  final CategoriesRepo _categoriesRepo;

  DeleteCategoryUseCase(this._categoriesRepo);

  Future<void> call(int id) => _categoriesRepo.deleteCategory(id);
}
