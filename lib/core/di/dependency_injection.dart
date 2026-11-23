import 'package:dio/dio.dart';
import 'package:easy_shop_admin/core/networking/api_service.dart';
import 'package:easy_shop_admin/features/auth/data/auth_repo_impl.dart';
import 'package:easy_shop_admin/features/auth/domain/repositories/auth_repo.dart';
import 'package:easy_shop_admin/features/auth/domain/usecases/login_usecase.dart';
import 'package:easy_shop_admin/features/auth/domain/usecases/logout_usecase.dart';
import 'package:easy_shop_admin/features/auth/domain/usecases/register_usecase.dart';
import 'package:easy_shop_admin/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:easy_shop_admin/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:easy_shop_admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_shop_admin/features/categories/data/mock_categories_repo.dart';
import 'package:easy_shop_admin/features/categories/domain/repositories/categories_repo.dart';
import 'package:easy_shop_admin/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:easy_shop_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_shop_admin/features/orders/data/mock_orders_repo.dart';
import 'package:easy_shop_admin/features/orders/domain/repositories/orders_repo.dart';
import 'package:easy_shop_admin/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:easy_shop_admin/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:easy_shop_admin/features/products/data/mock_products_repo.dart';
import 'package:easy_shop_admin/features/products/domain/repositories/products_repo.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/add_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/category_form_cubit.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/add_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/get_products_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/update_product_usecase.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/product_form_cubit.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/products_cubit.dart';
import 'package:easy_shop_admin/features/profile/data/mock_profile_repo.dart';
import 'package:easy_shop_admin/features/profile/domain/repositories/profile_repo.dart';
import 'package:easy_shop_admin/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:easy_shop_admin/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_form_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt()));

  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(getIt()),
  );
  getIt.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(getIt()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(getIt()));
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  // Mock repositories until the server is back: swap these four lines
  // for the real implementations and nothing else changes.
  getIt.registerLazySingleton<ProfileRepo>(() => MockProfileRepo());
  getIt.registerLazySingleton<ProductsRepo>(() => MockProductsRepo(getIt()));
  getIt.registerLazySingleton<OrdersRepo>(() => MockOrdersRepo());
  getIt.registerLazySingleton<CategoriesRepo>(() => MockCategoriesRepo());
  getIt.registerLazySingleton<GetHomeDashboardUseCase>(
    () => GetHomeDashboardUseCase(getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  getIt.registerLazySingleton<GetOrdersUseCase>(
    () => GetOrdersUseCase(getIt()),
  );
  getIt.registerFactory<OrdersCubit>(() => OrdersCubit(getIt()));

  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt()),
  );
  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(getIt()),
  );
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
  getIt.registerFactory<ProfileFormCubit>(() => ProfileFormCubit(getIt()));

  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt()),
  );
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));

  getIt.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt()),
  );
  getIt.registerLazySingleton<UpdateProductUseCase>(
    () => UpdateProductUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteProductUseCase>(
    () => DeleteProductUseCase(getIt()),
  );
  getIt.registerFactory<ProductFormCubit>(
    () => ProductFormCubit(getIt(), getIt(), getIt(), getIt()),
  );

  getIt.registerLazySingleton<AddCategoryUseCase>(
    () => AddCategoryUseCase(getIt()),
  );
  getIt.registerLazySingleton<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(getIt()),
  );
  getIt.registerLazySingleton<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(getIt()),
  );
  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(getIt(), getIt()),
  );
  getIt.registerFactory<CategoryFormCubit>(
    () => CategoryFormCubit(getIt(), getIt(), getIt()),
  );
}
