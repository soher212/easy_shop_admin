import 'package:easy_shop_admin/core/cache/cache_const.dart';
import 'package:easy_shop_admin/core/cache/cache_helper.dart';
import 'package:easy_shop_admin/core/di/dependency_injection.dart';
import 'package:easy_shop_admin/core/localization/locale_cubit.dart';
import 'package:easy_shop_admin/core/routes/app_router.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_shop_admin/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  setupGetIt();
  final localeCubit = LocaleCubit();
  await localeCubit.load();
  final token = await CacheHelper.getSecureData(key: CacheConstants.userToken);
  runApp(
    MerchantApp(
      initialRoute: _startRoute(hasToken: token != null),
      localeCubit: localeCubit,
    ),
  );
}

// A saved token means the merchant is already signed in.
String _startRoute({required bool hasToken}) {
  return hasToken ? Routes.home : Routes.splash;
}

class MerchantApp extends StatelessWidget {
  final String initialRoute;
  final LocaleCubit? localeCubit;

  MerchantApp({super.key, required this.initialRoute, this.localeCubit});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (_) => localeCubit ?? LocaleCubit(),
      child: BlocBuilder<LocaleCubit, Locale?>(
        builder: (context, locale) => MaterialApp(
          title: 'Easy Shop Merchant',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: initialRoute,
          // Only the requested screen: Flutter otherwise stacks the "/"
          // route below "/home" and may return to it when navigating back.
          onGenerateInitialRoutes: (name) => [
            _router.generateRoute(RouteSettings(name: name))!,
          ],
          onGenerateRoute: _router.generateRoute,
          onUnknownRoute: (_) => MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context).pageNotFound),
              ),
              body: Center(
                child: Text(AppLocalizations.of(context).unknownRouteMessage),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
