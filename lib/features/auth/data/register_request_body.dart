import 'package:dio/dio.dart';
import 'package:easy_shop_admin/features/auth/domain/entities/register_data.dart';
import 'package:image_picker/image_picker.dart';

// The domain entity can't know about Dio, so the data layer adds the
// multipart body the register endpoint expects.
extension RegisterRequestBody on RegisterData {
  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': password,
      'national_id': nationalId,
      'business_name': businessName,
      if (businessAddress.isNotEmpty) 'address': businessAddress,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (commercialRegister != null)
        'commercial_register': await _file(commercialRegister!),
      if (taxCard != null) 'tax_card': await _file(taxCard!),
      if (picture != null) 'picture': await _file(picture!),
    });
  }

  Future<MultipartFile> _file(XFile file) {
    return MultipartFile.fromFile(file.path, filename: file.name);
  }
}
