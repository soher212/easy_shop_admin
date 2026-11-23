import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';
import 'package:easy_shop_admin/features/products/domain/repositories/products_repo.dart';

class AddProductUseCase {
  final ProductsRepo _productsRepo;

  AddProductUseCase(this._productsRepo);

  Future<void> call(ProductFormData data) => _productsRepo.addProduct(data);
}
