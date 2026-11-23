class ProfileEntity {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String businessName;
  final String businessAddress;
  final double? latitude;
  final double? longitude;
  final String pictureUrl;
  final String? commercialRegisterUrl;
  final String? taxCardUrl;

  const ProfileEntity({
    required this.name,
    required this.businessName,
    required this.pictureUrl,
    this.email = '',
    this.phone = '',
    this.nationalId = '',
    this.businessAddress = '',
    this.latitude,
    this.longitude,
    this.commercialRegisterUrl,
    this.taxCardUrl,
  });

  bool get hasLocation => latitude != null && longitude != null;
  bool get hasCommercialRegister => commercialRegisterUrl != null;
  bool get hasTaxCard => taxCardUrl != null;
}
