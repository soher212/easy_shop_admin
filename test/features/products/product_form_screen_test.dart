import 'package:easy_shop_admin/core/theme/app_theme.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/add_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/update_product_usecase.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/product_form_cubit.dart';
import 'package:easy_shop_admin/features/products/presentation/screens/product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCategories extends Mock implements GetCategoriesUseCase {}

class _MockAdd extends Mock implements AddProductUseCase {}

class _MockUpdate extends Mock implements UpdateProductUseCase {}

class _MockDelete extends Mock implements DeleteProductUseCase {}

class _FakeFormData extends Fake implements ProductFormData {}

void main() {
  late _MockGetCategories getCategories;
  late _MockAdd add;
  late _MockUpdate update;
  late _MockDelete delete;
  bool? popped;

  setUpAll(() => registerFallbackValue(_FakeFormData()));

  setUp(() {
    getCategories = _MockGetCategories();
    add = _MockAdd();
    update = _MockUpdate();
    delete = _MockDelete();
    popped = null;
    when(() => getCategories()).thenAnswer(
      (_) async => const [
        CategoryEntity(id: 1, name: 'Electronics', description: ''),
        CategoryEntity(id: 2, name: 'Clothing', description: ''),
      ],
    );
    when(() => add(any())).thenAnswer((_) async {});
    when(() => update(any(), any())).thenAnswer((_) async {});
    when(() => delete(any())).thenAnswer((_) async {});
  });

  Future<void> openForm(WidgetTester tester, {ProductEntity? product}) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  popped = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            ProductFormCubit(getCategories, add, update, delete)
                              ..loadCategories(),
                        child: ProductFormScreen(product: product),
                      ),
                    ),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('adding enables the button once filled and saves', (
    tester,
  ) async {
    await openForm(tester);

    final button = find.widgetWithText(ElevatedButton, 'Add Product');
    expect(tester.widget<ElevatedButton>(button).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).at(0), 'Phone');
    await tester.enterText(find.byType(TextFormField).at(1), '100');
    await tester.enterText(find.byType(TextFormField).at(2), '5');
    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Electronics').last);
    await tester.pumpAndSettle();
    expect(tester.widget<ElevatedButton>(button).onPressed, isNotNull);

    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    verify(() => add(any())).called(1);
    expect(popped, isTrue);
  });

  testWidgets('editing prefills the form and saves with the product id', (
    tester,
  ) async {
    const product = ProductEntity(
      id: 7,
      name: 'Old Name',
      categoryId: 2,
      categoryName: 'Clothing',
      price: 50,
      quantity: 3,
      imagePath: 'assets/images/logo.png',
      isVisible: true,
      description: 'Old description',
    );
    await openForm(tester, product: product);

    expect(find.text('Edit Product'), findsOneWidget);
    expect(find.text('Old Name'), findsOneWidget);
    expect(find.text('Old description'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'New Name');
    final save = find.widgetWithText(ElevatedButton, 'Save Changes');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    verify(() => update(7, any())).called(1);
    expect(popped, isTrue);
  });

  testWidgets('deleting asks for confirmation first', (tester) async {
    const product = ProductEntity(
      id: 7,
      name: 'Old Name',
      categoryId: 2,
      categoryName: 'Clothing',
      price: 50,
      quantity: 3,
      imagePath: 'assets/images/logo.png',
      isVisible: true,
    );
    await openForm(tester, product: product);

    final deleteButton = find.text('Delete Product');
    await tester.ensureVisible(deleteButton);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
    expect(find.text('Delete product?'), findsOneWidget);
    verifyNever(() => delete(any()));

    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();
    verify(() => delete(7)).called(1);
    expect(popped, isTrue);
  });
}
