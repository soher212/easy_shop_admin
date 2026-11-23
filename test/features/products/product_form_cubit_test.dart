import 'package:bloc_test/bloc_test.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/add_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/update_product_usecase.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/product_form_cubit.dart';
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

  const categories = [
    CategoryEntity(id: 1, name: 'Electronics', description: ''),
  ];
  const data = ProductFormData(
    name: 'Phone',
    categoryId: 1,
    price: 100,
    quantity: 5,
    description: '',
    isVisible: true,
  );

  setUpAll(() => registerFallbackValue(_FakeFormData()));

  setUp(() {
    getCategories = _MockGetCategories();
    add = _MockAdd();
    update = _MockUpdate();
    delete = _MockDelete();
    when(() => getCategories()).thenAnswer((_) async => categories);
  });

  ProductFormCubit build() =>
      ProductFormCubit(getCategories, add, update, delete);

  blocTest<ProductFormCubit, ProductFormState>(
    'loadCategories ends ready with the categories',
    build: build,
    act: (cubit) => cubit.loadCategories(),
    verify: (cubit) {
      expect(cubit.state.status, ProductFormStatus.ready);
      expect(cubit.state.categories, categories);
    },
  );

  blocTest<ProductFormCubit, ProductFormState>(
    'add succeeds and reports saved',
    build: () {
      when(() => add(any())).thenAnswer((_) async {});
      return build();
    },
    act: (cubit) async {
      await cubit.loadCategories();
      await cubit.add(data);
    },
    verify: (cubit) {
      expect(cubit.state.status, ProductFormStatus.saved);
      verify(() => add(any())).called(1);
    },
  );

  blocTest<ProductFormCubit, ProductFormState>(
    'update passes the product id and reports saved',
    build: () {
      when(() => update(any(), any())).thenAnswer((_) async {});
      return build();
    },
    act: (cubit) => cubit.update(9, data),
    verify: (cubit) {
      expect(cubit.state.status, ProductFormStatus.saved);
      verify(() => update(9, any())).called(1);
    },
  );

  blocTest<ProductFormCubit, ProductFormState>(
    'delete succeeds and reports saved',
    build: () {
      when(() => delete(any())).thenAnswer((_) async {});
      return build();
    },
    act: (cubit) => cubit.delete(4),
    verify: (cubit) {
      expect(cubit.state.status, ProductFormStatus.saved);
      verify(() => delete(4)).called(1);
    },
  );

  blocTest<ProductFormCubit, ProductFormState>(
    'a failing action keeps the categories and reports failure',
    build: () {
      when(() => add(any())).thenThrow(Exception('boom'));
      return build();
    },
    act: (cubit) async {
      await cubit.loadCategories();
      await cubit.add(data);
    },
    verify: (cubit) {
      expect(cubit.state.status, ProductFormStatus.failure);
      expect(cubit.state.categories, categories);
    },
  );
}
