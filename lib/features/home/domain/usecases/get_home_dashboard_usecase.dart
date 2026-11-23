import 'package:easy_shop_admin/features/categories/domain/repositories/categories_repo.dart';
import 'package:easy_shop_admin/features/home/domain/entities/home_dashboard.dart';
import 'package:easy_shop_admin/features/orders/domain/repositories/orders_repo.dart';
import 'package:easy_shop_admin/features/products/domain/repositories/products_repo.dart';
import 'package:easy_shop_admin/features/profile/domain/repositories/profile_repo.dart';

class GetHomeDashboardUseCase {
  final ProfileRepo _profileRepo;
  final ProductsRepo _productsRepo;
  final OrdersRepo _ordersRepo;
  final CategoriesRepo _categoriesRepo;

  GetHomeDashboardUseCase(
    this._profileRepo,
    this._productsRepo,
    this._ordersRepo,
    this._categoriesRepo,
  );

  Future<HomeDashboard> call() async {
    final (profile, products, orders, categories) = await (
      _profileRepo.getProfile(),
      _productsRepo.getProducts(),
      _ordersRepo.getOrders(),
      _categoriesRepo.getCategories(),
    ).wait;

    return HomeDashboard(
      profile: profile,
      products: products,
      orders: orders,
      categoriesCount: categories.length,
    );
  }
}
