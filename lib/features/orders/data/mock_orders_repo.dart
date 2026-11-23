import 'package:easy_shop_admin/core/constants/app_assets.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/domain/repositories/orders_repo.dart';

// Temporary: replaced by the real API repository when the server is back.
class MockOrdersRepo implements OrdersRepo {
  @override
  Future<List<OrderEntity>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      OrderEntity(
        code: '567ITDSD',
        customerName: 'Sarah Mitchell',
        status: OrderStatus.pending,
        total: 687,
        customerEmail: 'sarah.mitchell@email.com',
        customerPhone: '+20 100 234 5678',
        address: '12 Nile Corniche, Giza, Egypt',
        latitude: 30.0131,
        longitude: 31.2089,
        paymentMethod: PaymentMethod.card,
        createdAt: DateTime(2024, 1, 15, 14, 32),
        items: const [
          OrderItemEntity(
            productName: 'Wireless Headphones',
            categoryName: 'Electronics',
            imagePath: AppAssets.headphones,
            unitPrice: 299,
            quantity: 2,
          ),
          OrderItemEntity(
            productName: 'Cotton T-Shirt',
            categoryName: 'Clothing',
            imagePath: AppAssets.tShirt,
            unitPrice: 89,
            quantity: 1,
          ),
        ],
      ),
      OrderEntity(
        code: '891KLFPR',
        customerName: 'Omar Hassan',
        status: OrderStatus.pending,
        total: 599,
        customerEmail: 'omar.hassan@email.com',
        customerPhone: '+20 101 876 5432',
        address: '45 El Tahrir Square, Cairo, Egypt',
        latitude: 30.0444,
        longitude: 31.2357,
        paymentMethod: PaymentMethod.cash,
        createdAt: DateTime(2024, 1, 14, 9, 15),
        items: const [
          OrderItemEntity(
            productName: 'Smart Watch',
            categoryName: 'Electronics',
            imagePath: AppAssets.wristwatch,
            unitPrice: 599,
            quantity: 1,
          ),
        ],
      ),
    ];
  }
}
