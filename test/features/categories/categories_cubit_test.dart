import 'package:bloc_test/bloc_test.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/add_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/category_form_cubit.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGet extends Mock implements GetCategoriesUseCase {}

class _MockGetProducts extends Mock implements GetProductsUseCase {}

class _MockAdd extends Mock implements AddCategoryUseCase {}

class _MockUpdate extends Mock implements UpdateCategoryUseCase {}

class _MockDelete extends Mock implements DeleteCategoryUseCase {}

void main() {
  late _MockGet get;
  late _MockGetProducts getProducts;
  late _MockAdd add;
  late _MockUpdate update;
  late _MockDelete delete;

  ProductEntity product(int id, int categoryId) => ProductEntity(
    id: id,
    name: 'P$id',
    categoryId: categoryId,
    categoryName: 'C$categoryId',
    price: 1,
    quantity: 1,
    imagePath: '',
    isVisible: true,
  );

  setUp(() {
    get = _MockGet();
    getProducts = _MockGetProducts();
    add = _MockAdd();
    update = _MockUpdate();
    delete = _MockDelete();
    when(() => getProducts()).thenAnswer((_) async => []);
  });

  blocTest<CategoriesCubit, CategoriesState>(
    'load emits loading then the categories',
    build: () {
      when(() => get()).thenAnswer(
        (_) async => const [
          CategoryEntity(id: 1, name: 'Clothing', description: ''),
        ],
      );
      return CategoriesCubit(get, getProducts);
    },
    act: (cubit) => cubit.load(),
    expect: () => [isA<CategoriesLoading>(), isA<CategoriesSuccess>()],
  );

  blocTest<CategoriesCubit, CategoriesState>(
    'load counts the products of each category',
    build: () {
      when(() => get()).thenAnswer(
        (_) async => const [
          CategoryEntity(id: 1, name: 'A', description: ''),
          CategoryEntity(id: 2, name: 'B', description: ''),
          CategoryEntity(id: 3, name: 'C', description: ''),
        ],
      );
      when(
        () => getProducts(),
      ).thenAnswer((_) async => [product(1, 1), product(2, 1), product(3, 2)]);
      return CategoriesCubit(get, getProducts);
    },
    act: (cubit) => cubit.load(),
    verify: (cubit) {
      final state = cubit.state as CategoriesSuccess;
      expect(state.productsCountOf(1), 2);
      expect(state.productsCountOf(2), 1);
      expect(state.productsCountOf(3), 0);
    },
  );

  blocTest<CategoriesCubit, CategoriesState>(
    'load emits failure when the request throws',
    build: () {
      when(() => get()).thenThrow(Exception('boom'));
      return CategoriesCubit(get, getProducts);
    },
    act: (cubit) => cubit.load(),
    expect: () => [isA<CategoriesLoading>(), isA<CategoriesFailure>()],
  );

  blocTest<CategoryFormCubit, CategoryFormState>(
    'add finishes with done',
    build: () {
      when(
        () => add(
          name: any(named: 'name'),
          description: any(named: 'description'),
        ),
      ).thenAnswer((_) async {});
      return CategoryFormCubit(add, update, delete);
    },
    act: (cubit) => cubit.add(name: 'Toys', description: ''),
    verify: (cubit) => expect(cubit.state.status, CategoryFormStatus.done),
  );

  blocTest<CategoryFormCubit, CategoryFormState>(
    'update passes the id and finishes with done',
    build: () {
      when(
        () => update(
          id: any(named: 'id'),
          name: any(named: 'name'),
          description: any(named: 'description'),
        ),
      ).thenAnswer((_) async {});
      return CategoryFormCubit(add, update, delete);
    },
    act: (cubit) => cubit.update(id: 7, name: 'Toys', description: 'Fun'),
    verify: (cubit) {
      expect(cubit.state.status, CategoryFormStatus.done);
      verify(() => update(id: 7, name: 'Toys', description: 'Fun')).called(1);
    },
  );

  blocTest<CategoryFormCubit, CategoryFormState>(
    'delete failure reports failure with a message',
    build: () {
      when(() => delete(any())).thenThrow(Exception('boom'));
      return CategoryFormCubit(add, update, delete);
    },
    act: (cubit) => cubit.delete(3),
    verify: (cubit) {
      expect(cubit.state.status, CategoryFormStatus.failure);
      expect(cubit.state.message, isNotNull);
    },
  );
}
