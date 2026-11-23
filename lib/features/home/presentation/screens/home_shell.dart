import 'package:easy_shop_admin/core/di/dependency_injection.dart';
import 'package:easy_shop_admin/core/routes/routes.dart';
import 'package:easy_shop_admin/core/widgets/app_bottom_nav.dart';
import 'package:easy_shop_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_shop_admin/features/home/presentation/screens/home_tab.dart';
import 'package:easy_shop_admin/features/orders/domain/entities/order_entity.dart';
import 'package:easy_shop_admin/features/orders/presentation/screens/orders_screen.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/products_cubit.dart';
import 'package:easy_shop_admin/features/products/presentation/screens/products_screen.dart';
import 'package:easy_shop_admin/features/profile/domain/entities/profile_entity.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_shop_admin/features/profile/presentation/cubit/profile_form_cubit.dart';
import 'package:easy_shop_admin/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:easy_shop_admin/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  static const _homeIndex = 0;
  static const _productsIndex = 1;
  static const _ordersIndex = 2;

  static const _items = [
    BottomNavItem(icon: Icons.home_outlined, label: 'Home'),
    BottomNavItem(icon: Icons.inventory_2_outlined, label: 'Products'),
    BottomNavItem(icon: Icons.shopping_bag_outlined, label: 'Orders'),
    BottomNavItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  int _index = _homeIndex;
  ProfileEntity? _editingProfile;

  void _select(int index) => setState(() => _index = index);

  void _reloadProducts() {
    context.read<ProductsCubit>().load();
    context.read<HomeCubit>().load();
  }

  Future<void> _openCategories() async {
    final changed = await Navigator.pushNamed<bool>(context, Routes.categories);
    if (changed == true && mounted) _reloadProducts();
  }

  void _openOrder(OrderEntity order) {
    Navigator.pushNamed(context, Routes.orderDetails, arguments: order);
  }

  Future<void> _addProduct() async {
    final added = await Navigator.pushNamed<bool>(context, Routes.productForm);
    if (added == true && mounted) _reloadProducts();
  }

  Future<void> _openProduct(ProductEntity product) async {
    final changed = await Navigator.pushNamed<bool>(
      context,
      Routes.productDetails,
      arguments: product,
    );
    if (changed == true && mounted) _reloadProducts();
  }

  void _closeEditProfile(bool saved) {
    setState(() => _editingProfile = null);
    if (saved) {
      context.read<ProfileCubit>().load();
      context.read<HomeCubit>().load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = _editingProfile;
    return PopScope(
      canPop: editing == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _closeEditProfile(false);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: [
            HomeTab(
              onSeeAllOrders: () => _select(_ordersIndex),
              onSeeAllProducts: () => _select(_productsIndex),
              onAddProduct: _addProduct,
              onCategories: _openCategories,
              onOpenProduct: _openProduct,
              onOpenOrder: _openOrder,
            ),
            ProductsScreen(
              onAddProduct: _addProduct,
              onManageCategories: _openCategories,
              onOpenProduct: _openProduct,
            ),
            OrdersScreen(onOpenOrder: _openOrder),
            // Editing happens inside the tab so the bottom bar stays visible.
            if (editing == null)
              ProfileScreen(
                onEdit: (profile) => setState(() => _editingProfile = profile),
              )
            else
              BlocProvider(
                key: ObjectKey(editing),
                create: (_) => getIt<ProfileFormCubit>(),
                child: EditProfileScreen(
                  profile: editing,
                  onClose: _closeEditProfile,
                ),
              ),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          items: _items,
          currentIndex: _index,
          onTap: _select,
        ),
      ),
    );
  }
}
