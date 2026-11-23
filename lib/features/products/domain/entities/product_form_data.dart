import 'package:image_picker/image_picker.dart';

class ProductFormData {
  final String name;
  final int categoryId;
  final double price;
  final int quantity;
  final String description;
  final bool isVisible;
  final XFile? image;

  const ProductFormData({
    required this.name,
    required this.categoryId,
    required this.price,
    required this.quantity,
    required this.description,
    required this.isVisible,
    this.image,
  });
}
