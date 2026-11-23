import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';
import 'package:easy_shop_admin/features/products/domain/repositories/products_repo.dart';

class UpdateProductUseCase {
  final ProductsRepo _productsRepo;

  UpdateProductUseCase(this._productsRepo);

  Future<void> call(int id, ProductFormData data) {
    return _productsRepo.updateProduct(id, data);
  }
}
