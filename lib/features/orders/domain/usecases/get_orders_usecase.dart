import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/domain/repositories/orders_repo.dart';

class GetOrdersUseCase {
  final OrdersRepo _ordersRepo;

  GetOrdersUseCase(this._ordersRepo);

  Future<List<OrderEntity>> call() => _ordersRepo.getOrders();
}
