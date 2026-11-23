import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_form_data.dart';

abstract class ProfileRepo {
  Future<ProfileEntity> getProfile();

  Future<void> updateProfile(ProfileFormData data);
}
