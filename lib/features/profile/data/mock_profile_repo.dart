import 'package:easy_shop_admin/core/constants/app_assets.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_form_data.dart';
import 'package:easy_shop_admin/features/profile/domain/repositories/profile_repo.dart';

// Temporary: replaced by the real API repository when the server is back.
// Changes live in memory only, so they disappear on a full restart.
class MockProfileRepo implements ProfileRepo {
  ProfileEntity _profile = const ProfileEntity(
    name: 'Ahmed Khalil',
    email: 'ahmed@khalilstore.com',
    phone: '+201001234567',
    nationalId: '29801234567890',
    businessName: 'Khalil Digital Store',
    businessAddress: '18 El Nasr Road, Nasr City, Cairo',
    latitude: 30.0561,
    longitude: 31.33,
    pictureUrl: AppAssets.person,
    commercialRegisterUrl: AppAssets.logo,
  );

  @override
  Future<ProfileEntity> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _profile;
  }

  @override
  Future<void> updateProfile(ProfileFormData data) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final old = _profile;
    _profile = ProfileEntity(
      name: data.name,
      email: data.email,
      phone: data.phone,
      nationalId: data.nationalId,
      businessName: data.businessName,
      businessAddress: data.businessAddress,
      latitude: data.latitude ?? old.latitude,
      longitude: data.longitude ?? old.longitude,
      pictureUrl: data.picture?.path ?? old.pictureUrl,
      commercialRegisterUrl: data.removeCommercialRegister
          ? null
          : data.commercialRegister?.path ?? old.commercialRegisterUrl,
      taxCardUrl: data.removeTaxCard
          ? null
          : data.taxCard?.path ?? old.taxCardUrl,
    );
  }
}
