import 'package:easy_shop_admin/core/constants/app_assets.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/domain/repositories/categories_repo.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';
import 'package:easy_shop_admin/features/products/domain/repositories/products_repo.dart';

// Temporary: replaced by the real API repository when the server is back.
// Changes live in memory only, so they disappear on a full restart.
class MockProductsRepo implements ProductsRepo {
  final CategoriesRepo _categoriesRepo;

  MockProductsRepo(this._categoriesRepo);

  final List<ProductEntity> _products = [
    ProductEntity(
      id: 1,
      name: 'Wireless Headphones',
      categoryId: 1,
      categoryName: 'Electronics',
      price: 299,
      quantity: 45,
      imagePath: AppAssets.headphones,
      isVisible: true,
      description:
          'Premium wireless headphones with active noise cancellation '
          'and 30-hour battery life.',
      createdAt: DateTime(2024, 1, 10),
    ),
    ProductEntity(
      id: 2,
      name: 'Cotton T-Shirt',
      categoryId: 2,
      categoryName: 'Clothing',
      price: 89,
      quantity: 120,
      imagePath: AppAssets.tShirt,
      isVisible: true,
      description: 'Soft everyday cotton t-shirt.',
      createdAt: DateTime(2024, 1, 12),
    ),
    ProductEntity(
      id: 3,
      name: 'Organic Coffee',
      categoryId: 3,
      categoryName: 'Food & Beverages',
      price: 45,
      quantity: 200,
      imagePath: AppAssets.holder,
      isVisible: false,
      description: 'Freshly roasted organic coffee beans.',
      createdAt: DateTime(2024, 1, 15),
    ),
    ProductEntity(
      id: 4,
      name: 'Smart Watch',
      categoryId: 1,
      categoryName: 'Electronics',
      price: 599,
      quantity: 18,
      imagePath: AppAssets.wristwatch,
      isVisible: true,
      description: 'Fitness and notifications on your wrist.',
      createdAt: DateTime(2024, 1, 18),
    ),
  ];

  @override
  Future<List<ProductEntity>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_products);
  }

  @override
  Future<void> addProduct(ProductFormData data) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final category = await _categoryOf(data.categoryId);
    final nextId = _products.fold<int>(
      0,
      (max, product) => product.id > max ? product.id : max,
    );
    _products.insert(
      0,
      ProductEntity(
        id: nextId + 1,
        name: data.name,
        categoryId: category.id,
        categoryName: category.name,
        price: data.price,
        quantity: data.quantity,
        imagePath: data.image?.path ?? AppAssets.logo,
        isVisible: data.isVisible,
        description: data.description,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> updateProduct(int id, ProductFormData data) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final index = _products.indexWhere((product) => product.id == id);
    if (index == -1) return;
    final old = _products[index];
    final category = await _categoryOf(data.categoryId);
    _products[index] = ProductEntity(
      id: id,
      name: data.name,
      categoryId: category.id,
      categoryName: category.name,
      price: data.price,
      quantity: data.quantity,
      imagePath: data.image?.path ?? old.imagePath,
      isVisible: data.isVisible,
      description: data.description,
      createdAt: old.createdAt,
    );
  }

  @override
  Future<void> deleteProduct(int id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _products.removeWhere((product) => product.id == id);
  }

  Future<CategoryEntity> _categoryOf(int categoryId) async {
    final categories = await _categoriesRepo.getCategories();
    return categories.firstWhere((category) => category.id == categoryId);
  }
}
