import 'package:easy_shop_admin/core/constants/app_assets.dart';
import 'package:easy_shop_admin/core/theme/app_theme.dart';
import 'package:easy_shop_admin/features/home/domain/entities/home_dashboard.dart';
import 'package:easy_shop_admin/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:easy_shop_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_shop_admin/features/home/presentation/screens/home_tab.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetHomeDashboard extends Mock implements GetHomeDashboardUseCase {}

void main() {
  testWidgets('home tab shows the profile, counters and lists', (tester) async {
    final useCase = _MockGetHomeDashboard();
    when(() => useCase()).thenAnswer(
      (_) async => const HomeDashboard(
        profile: ProfileEntity(
          name: 'Ahmed Khalil',
          businessName: 'Khalil Digital Store',
          pictureUrl: AppAssets.person,
        ),
        products: [
          ProductEntity(
            id: 1,
            name: 'Wireless Headphones',
            categoryId: 1,
            categoryName: 'Electronics',
            price: 299,
            quantity: 45,
            imagePath: AppAssets.headphones,
            isVisible: true,
          ),
        ],
        orders: [
          OrderEntity(
            code: '567ITDSD',
            customerName: 'Sarah Mitchell',
            status: OrderStatus.pending,
            total: 687,
          ),
        ],
        categoriesCount: 3,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider(
          create: (_) => HomeCubit(useCase)..load(),
          child: Scaffold(
            body: HomeTab(
              onSeeAllOrders: () {},
              onSeeAllProducts: () {},
              onAddProduct: () {},
              onCategories: () {},
              onOpenProduct: (_) {},
              onOpenOrder: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ahmed Khalil'), findsOneWidget);
    expect(find.text('Khalil Digital Store'), findsOneWidget);
    expect(find.text('Total Products'), findsOneWidget);
    expect(find.text('#567ITDSD'), findsOneWidget);
    expect(find.text('Wireless Headphones'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
