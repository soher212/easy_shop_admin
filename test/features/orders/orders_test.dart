import 'package:bloc_test/bloc_test.dart';
import 'package:easy_shop_admin/core/helpers/format.dart';
import 'package:easy_shop_admin/core/theme/app_theme.dart';
import 'package:easy_shop_admin/features/orders/data/mock_orders_repo.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:easy_shop_admin/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:easy_shop_admin/features/orders/presentation/screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetOrders extends Mock implements GetOrdersUseCase {}

void main() {
  test('formatDateTime uses a 12 hour clock', () {
    expect(
      formatDateTime(DateTime(2024, 1, 15, 14, 32)),
      'Jan 15, 2024 · 02:32 PM',
    );
    expect(
      formatDateTime(DateTime(2024, 1, 14, 9, 15)),
      'Jan 14, 2024 · 09:15 AM',
    );
    expect(
      formatDateTime(DateTime(2024, 1, 14, 0, 5)),
      'Jan 14, 2024 · 12:05 AM',
    );
  });

  test('line totals add up to the order total in the mock data', () async {
    final orders = await MockOrdersRepo().getOrders();
    for (final order in orders) {
      final sum = order.items.fold<double>(0, (s, item) => s + item.lineTotal);
      expect(sum, order.total, reason: 'order ${order.code}');
    }
  });

  blocTest<OrdersCubit, OrdersState>(
    'load emits loading then the orders',
    build: () {
      final useCase = _MockGetOrders();
      when(() => useCase()).thenAnswer(
        (_) async => const [
          OrderEntity(
            code: 'A1',
            customerName: 'Sara',
            status: OrderStatus.pending,
            total: 10,
          ),
        ],
      );
      return OrdersCubit(useCase);
    },
    act: (cubit) => cubit.load(),
    expect: () => [isA<OrdersLoading>(), isA<OrdersSuccess>()],
  );

  blocTest<OrdersCubit, OrdersState>(
    'load emits failure when the request throws',
    build: () {
      final useCase = _MockGetOrders();
      when(() => useCase()).thenThrow(Exception('boom'));
      return OrdersCubit(useCase);
    },
    act: (cubit) => cubit.load(),
    expect: () => [isA<OrdersLoading>(), isA<OrdersFailure>()],
  );

  testWidgets('order details show the customer, items and total', (
    tester,
  ) async {
    // The mock repo waits on a real timer, which a widget test must run
    // outside its fake clock.
    final orders = await tester.runAsync(() => MockOrdersRepo().getOrders());
    final order = orders!.first;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: OrderDetailsScreen(order: order),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('#567ITDSD'), findsOneWidget);
    expect(find.text('Sarah Mitchell'), findsOneWidget);
    expect(find.text('SM'), findsOneWidget);
    expect(find.text('Wireless Headphones'), findsOneWidget);
    expect(find.text('View on Map'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Card'), 200);
    expect(find.text('Card'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
