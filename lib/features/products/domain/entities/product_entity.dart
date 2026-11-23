class ProductEntity {
  final int id;
  final String name;
  final int categoryId;
  final String categoryName;
  final double price;
  final int quantity;
  final String imagePath;
  final bool isVisible;
  final String description;
  final DateTime? createdAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.isVisible,
    this.description = '',
    this.createdAt,
  });
}
