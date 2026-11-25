import 'package:easy_shop_admin/l10n/app_localizations.dart';

class Validators {
  Validators._();

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? value, [AppLocalizations? l10n]) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n?.emailRequired ?? 'Email is required';
    if (!_emailPattern.hasMatch(text)) {
      return l10n?.validEmail ?? 'Enter a valid email';
    }
    return null;
  }

  static String? fullName(String? value, [AppLocalizations? l10n]) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return l10n?.fullNameRequired ?? 'Full name is required';
    final words = text.split(RegExp(r'\s+'));
    if (words.length < 2) {
      return l10n?.enterFullName ??
          'Enter your full name (first and last name)';
    }
    return null;
  }

  static String normalizePhone(String value) {
    return value.replaceAll(RegExp(r'[\s\-]'), '');
  }

  static String? phone(String? value, [AppLocalizations? l10n]) {
    final text = normalizePhone(value ?? '');
    if (text.isEmpty) return l10n?.phoneRequired ?? 'Phone number is required';
    if (!RegExp(r'^\+20\d{10}$').hasMatch(text)) {
      return l10n?.phoneFormat ??
          'Phone must start with +20 followed by 10 digits';
    }
    return null;
  }

  static String? nationalId(String? value, [AppLocalizations? l10n]) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return l10n?.nationalIdRequired ?? 'National ID is required';
    }
    if (!RegExp(r'^[23]\d{13}$').hasMatch(text)) {
      return l10n?.nationalIdFormat ??
          'National ID must be 14 digits starting with 2 or 3';
    }
    return null;
  }

  static String? Function(String?) confirmPassword(
    String Function() original, [
    AppLocalizations? l10n,
  ]) {
    return (value) {
      if ((value ?? '').isEmpty) {
        return l10n?.confirmPasswordRequired ?? 'Please confirm your password';
      }
      if (value != original()) {
        return l10n?.passwordMismatch ?? 'Passwords do not match';
      }
      return null;
    };
  }

  static String? required(
    String? value,
    String fieldName, [
    AppLocalizations? l10n,
  ]) {
    if ((value?.trim() ?? '').isEmpty) {
      return l10n?.requiredField(fieldName) ?? '$fieldName is required';
    }
    return null;
  }

  static String? price(String? value, [AppLocalizations? l10n]) {
    final number = double.tryParse((value ?? '').trim());
    if (number == null) return l10n?.validPrice ?? 'Enter a valid price';
    if (number <= 0) {
      return l10n?.positivePrice ?? 'Price must be greater than 0';
    }
    return null;
  }

  static String? quantity(String? value, [AppLocalizations? l10n]) {
    final number = int.tryParse((value ?? '').trim());
    if (number == null) return l10n?.wholeNumber ?? 'Enter a whole number';
    if (number < 0) {
      return l10n?.nonNegativeQuantity ?? 'Quantity cannot be negative';
    }
    return null;
  }

  static String? password(String? value, [AppLocalizations? l10n]) {
    final text = value ?? '';
    if (text.isEmpty) return l10n?.passwordRequired ?? 'Password is required';
    if (text.length < 6) {
      return l10n?.passwordLength ?? 'Password must be at least 6 characters';
    }
    return null;
  }
}
