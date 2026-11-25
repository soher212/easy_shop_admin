import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/theme/app_text_styles.dart';
import 'package:easy_shop_admin/core/widgets/error_view.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:easy_shop_admin/features/orders/presentation/widgets/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  final ValueChanged<OrderEntity> onOpenOrder;

  const OrdersScreen({super.key, required this.onOpenOrder});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: context.appColors.surface,
            padding: const EdgeInsets.all(AppDimensions.screenPadding),
            child: const Text('Orders', style: AppTextStyles.title),
          ),
          Divider(height: 1, color: context.appColors.border),
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) => switch (state) {
                OrdersLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                OrdersFailure(:final message) => ErrorView(
                  message: message,
                  onRetry: () => context.read<OrdersCubit>().load(),
                ),
                OrdersSuccess(:final orders) => _list(context, orders),
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context, List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text('No orders yet', style: AppTextStyles.caption),
      );
    }
    return RefreshIndicator(
      onRefresh: () => context.read<OrdersCubit>().load(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimensions.screenPadding),
        itemCount: orders.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppDimensions.spaceSmall + 4),
        itemBuilder: (context, index) => OrderListItem(
          order: orders[index],
          onTap: () => onOpenOrder(orders[index]),
        ),
      ),
    );
  }
}
