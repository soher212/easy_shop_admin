import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';

class HomeDashboard {
  final ProfileEntity profile;
  final List<ProductEntity> products;
  final List<OrderEntity> orders;
  final int categoriesCount;

  const HomeDashboard({
    required this.profile,
    required this.products,
    required this.orders,
    required this.categoriesCount,
  });

  int get totalProducts => products.length;
  int get totalOrders => orders.length;
  int get pendingOrders =>
      orders.where((order) => order.status == OrderStatus.pending).length;
}
