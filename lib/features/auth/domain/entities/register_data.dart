import 'package:image_picker/image_picker.dart';

class RegisterData {
  final String fullName;
  final String email;
  final String phone;
  final String nationalId;
  final String businessName;
  final String businessAddress;
  final double? latitude;
  final double? longitude;
  final XFile? commercialRegister;
  final XFile? taxCard;
  final XFile? picture;
  final String password;

  const RegisterData({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.nationalId = '',
    this.businessName = '',
    this.businessAddress = '',
    this.latitude,
    this.longitude,
    this.commercialRegister,
    this.taxCard,
    this.picture,
    this.password = '',
  });

  RegisterData copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? nationalId,
    String? businessName,
    String? businessAddress,
    double? latitude,
    double? longitude,
    XFile? commercialRegister,
    XFile? taxCard,
    XFile? picture,
    String? password,
  }) {
    return RegisterData(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationalId: nationalId ?? this.nationalId,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      commercialRegister: commercialRegister ?? this.commercialRegister,
      taxCard: taxCard ?? this.taxCard,
      picture: picture ?? this.picture,
      password: password ?? this.password,
    );
  }
}
