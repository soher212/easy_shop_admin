import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A null locale means that Flutter should follow the device language.
class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null);

  static const _languageKey = 'merchant_language_code';

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final code = preferences.getString(_languageKey);
    if (code == 'ar' || code == 'en') emit(Locale(code!));
  }

  Future<void> setLanguage(Locale locale) async {
    final code = locale.languageCode;
    if (code != 'ar' && code != 'en') return;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, code);
    emit(Locale(code));
  }
}
