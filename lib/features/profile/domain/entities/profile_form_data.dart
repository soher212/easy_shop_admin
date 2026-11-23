import 'package:image_picker/image_picker.dart';

class ProfileFormData {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String businessName;
  final String businessAddress;
  final double? latitude;
  final double? longitude;
  final XFile? picture;
  final XFile? commercialRegister;
  final XFile? taxCard;
  final bool removeCommercialRegister;
  final bool removeTaxCard;

  const ProfileFormData({
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.businessName,
    required this.businessAddress,
    this.latitude,
    this.longitude,
    this.picture,
    this.commercialRegister,
    this.taxCard,
    this.removeCommercialRegister = false,
    this.removeTaxCard = false,
  });
}
