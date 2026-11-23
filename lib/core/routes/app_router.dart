import 'package:easy_shop_admin/core/di/dependency_injection.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/features/auth/domain/entities/register_data.dart';
import 'package:easy_shop_admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_shop_admin/features/auth/presentation/screens/login_screen.dart';
import 'package:easy_shop_admin/features/auth/presentation/screens/otp_screen.dart';
import 'package:easy_shop_admin/features/auth/presentation/screens/register_business_screen.dart';
import 'package:easy_shop_admin/features/auth/presentation/screens/register_personal_screen.dart';
import 'package:easy_shop_admin/features/auth/presentation/screens/register_security_screen.dart';
import 'package:easy_shop_admin/features/categories/presentation/category_form_args.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/category_form_cubit.dart';
import 'package:easy_shop_admin/features/categories/presentation/screens/categories_screen.dart';
import 'package:easy_shop_admin/features/categories/presentation/screens/category_form_screen.dart';
import 'package:easy_shop_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_shop_admin/features/home/presentation/screens/home_shell.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:easy_shop_admin/features/orders/presentation/screens/order_details_screen.dart';
import 'package:easy_shop_admin/features/orders/presentation/screens/order_location_screen.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/product_form_cubit.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/products_cubit.dart';
import 'package:easy_shop_admin/features/products/presentation/screens/product_details_screen.dart';
import 'package:easy_shop_admin/features/products/presentation/screens/product_form_screen.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_shop_admin/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            onTap: () => Navigator.pushNamed(context, Routes.register),
          ),
        );
      case Routes.login:
        return _withAuthCubit(const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPersonalScreen(),
        );
      case Routes.registerBusiness:
        final data = settings.arguments as RegisterData;
        return MaterialPageRoute(
          builder: (_) => RegisterBusinessScreen(data: data),
        );
      case Routes.registerSecurity:
        final data = settings.arguments as RegisterData;
        return _withAuthCubit(RegisterSecurityScreen(data: data));
      case Routes.otp:
        final email = settings.arguments as String;
        return _withAuthCubit(OtpScreen(email: email));
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<HomeCubit>()..load()),
              BlocProvider(create: (_) => getIt<ProductsCubit>()..load()),
              BlocProvider(create: (_) => getIt<OrdersCubit>()..load()),
              BlocProvider(create: (_) => getIt<ProfileCubit>()..load()),
            ],
            child: const HomeShell(),
          ),
        );
      case Routes.productForm:
        final product = settings.arguments as ProductEntity?;
        return MaterialPageRoute<bool>(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ProductFormCubit>()..loadCategories(),
            child: ProductFormScreen(product: product),
          ),
        );
      case Routes.productDetails:
        final product = settings.arguments as ProductEntity;
        return MaterialPageRoute<bool>(
          builder: (_) => ProductDetailsScreen(product: product),
        );
      case Routes.orderDetails:
        final order = settings.arguments as OrderEntity;
        return MaterialPageRoute(
          builder: (_) => OrderDetailsScreen(order: order),
        );
      case Routes.orderLocation:
        final order = settings.arguments as OrderEntity;
        return MaterialPageRoute(
          builder: (_) => OrderLocationScreen(
            latitude: order.latitude!,
            longitude: order.longitude!,
            address: order.address,
          ),
        );
      case Routes.categories:
        return MaterialPageRoute<bool>(
          builder: (_) => BlocProvider(
            create: (_) => getIt<CategoriesCubit>()..load(),
            child: const CategoriesScreen(),
          ),
        );
      case Routes.categoryForm:
        final args =
            settings.arguments as CategoryFormArgs? ?? const CategoryFormArgs();
        return MaterialPageRoute<bool>(
          builder: (_) => BlocProvider(
            create: (_) => getIt<CategoryFormCubit>(),
            child: CategoryFormScreen(
              category: args.category,
              productsCount: args.productsCount,
            ),
          ),
        );
      default:
        return null;
    }
  }

  MaterialPageRoute<dynamic> _withAuthCubit(Widget screen) {
    return MaterialPageRoute(
      builder: (_) =>
          BlocProvider(create: (_) => getIt<AuthCubit>(), child: screen),
    );
  }
}
