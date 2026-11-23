import 'package:easy_shop_admin/features/products/domain/repositories/products_repo.dart';

class DeleteProductUseCase {
  final ProductsRepo _productsRepo;

  DeleteProductUseCase(this._productsRepo);

  Future<void> call(int id) => _productsRepo.deleteProduct(id);
}
