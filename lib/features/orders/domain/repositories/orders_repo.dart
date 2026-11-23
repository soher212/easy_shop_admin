import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';

abstract class OrdersRepo {
  Future<List<OrderEntity>> getOrders();
}
