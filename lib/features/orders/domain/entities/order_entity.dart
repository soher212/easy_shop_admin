enum OrderStatus { pending, processing, completed, cancelled }

enum PaymentMethod { card, cash }

class OrderItemEntity {
  final String productName;
  final String categoryName;
  final String imagePath;
  final double unitPrice;
  final int quantity;

  const OrderItemEntity({
    required this.productName,
    required this.categoryName,
    required this.imagePath,
    required this.unitPrice,
    required this.quantity,
  });

  double get lineTotal => unitPrice * quantity;
}

class OrderEntity {
  final String code;
  final String customerName;
  final OrderStatus status;
  final double total;
  final String customerEmail;
  final String customerPhone;
  final String address;
  final double? latitude;
  final double? longitude;
  final List<OrderItemEntity> items;
  final PaymentMethod paymentMethod;
  final DateTime? createdAt;

  const OrderEntity({
    required this.code,
    required this.customerName,
    required this.status,
    required this.total,
    this.customerEmail = '',
    this.customerPhone = '',
    this.address = '',
    this.latitude,
    this.longitude,
    this.items = const [],
    this.paymentMethod = PaymentMethod.cash,
    this.createdAt,
  });

  bool get hasLocation => latitude != null && longitude != null;
}
