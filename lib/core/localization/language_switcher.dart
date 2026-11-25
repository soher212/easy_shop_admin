import 'package:easy_shop_admin/core/localization/app_localizations_context.dart';
import 'package:easy_shop_admin/core/localization/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale?>(
      builder: (context, selectedLocale) {
        final code =
            selectedLocale?.languageCode ??
            Localizations.localeOf(context).languageCode;
        return PopupMenuButton<String>(
          tooltip: context.l10n.changeLanguage,
          onSelected: (value) =>
              context.read<LocaleCubit>().setLanguage(Locale(value)),
          itemBuilder: (context) => [
            PopupMenuItem(value: 'en', child: Text(context.l10n.english)),
            PopupMenuItem(value: 'ar', child: Text(context.l10n.arabic)),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 6),
                Text(code == 'ar' ? 'ع' : 'EN'),
              ],
            ),
          ),
        );
      },
    );
  }
}
