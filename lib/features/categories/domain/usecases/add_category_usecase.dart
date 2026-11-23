import 'package:easy_shop_admin/features/categories/domain/repositories/categories_repo.dart';

class AddCategoryUseCase {
  final CategoriesRepo _categoriesRepo;

  AddCategoryUseCase(this._categoriesRepo);

  Future<void> call({required String name, required String description}) {
    return _categoriesRepo.addCategory(name: name, description: description);
  }
}
