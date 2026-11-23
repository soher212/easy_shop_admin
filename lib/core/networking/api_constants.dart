import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String get baseUrl => dotenv.get('API_BASE_URL');
  static String get apiKey => dotenv.get('API_KEY');

  static const String login = 'admin/login';
  static const String register = 'admin/register';
  static const String verifyOtp = 'admin/otp/verify';
  static const String resendOtp = 'admin/otp/resend';
  static const String logout = 'admin/logout';
}
