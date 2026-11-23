import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:easy_shop_admin/features/home/domain/entities/home_dashboard.dart';
import 'package:easy_shop_admin/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:easy_shop_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetHomeDashboard extends Mock implements GetHomeDashboardUseCase {}

void main() {
  late _MockGetHomeDashboard useCase;

  const dashboard = HomeDashboard(
    profile: ProfileEntity(name: 'Ahmed', businessName: 'Shop', pictureUrl: ''),
    products: [
      ProductEntity(
        id: 1,
        name: 'Phone',
        categoryId: 1,
        categoryName: 'Electronics',
        price: 100,
        quantity: 5,
        imagePath: '',
        isVisible: true,
      ),
    ],
    orders: [
      OrderEntity(
        code: 'A1',
        customerName: 'Sara',
        status: OrderStatus.pending,
        total: 100,
      ),
      OrderEntity(
        code: 'A2',
        customerName: 'Omar',
        status: OrderStatus.completed,
        total: 50,
      ),
    ],
    categoriesCount: 3,
  );

  setUp(() => useCase = _MockGetHomeDashboard());

  test('dashboard counts total and pending orders', () {
    expect(dashboard.totalProducts, 1);
    expect(dashboard.totalOrders, 2);
    expect(dashboard.pendingOrders, 1);
  });

  blocTest<HomeCubit, HomeState>(
    'load emits loading then success',
    build: () {
      when(() => useCase()).thenAnswer((_) async => dashboard);
      return HomeCubit(useCase);
    },
    act: (cubit) => cubit.load(),
    expect: () => [isA<HomeLoading>(), isA<HomeSuccess>()],
  );

  blocTest<HomeCubit, HomeState>(
    'load emits failure when the request fails',
    build: () {
      when(() => useCase()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      return HomeCubit(useCase);
    },
    act: (cubit) => cubit.load(),
    expect: () => [isA<HomeLoading>(), isA<HomeFailure>()],
  );
}
