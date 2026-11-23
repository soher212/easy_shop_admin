import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';

abstract class ProductsRepo {
  Future<List<ProductEntity>> getProducts();

  Future<void> addProduct(ProductFormData data);

  Future<void> updateProduct(int id, ProductFormData data);

  Future<void> deleteProduct(int id);
}
