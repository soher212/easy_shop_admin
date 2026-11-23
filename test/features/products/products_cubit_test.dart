import 'package:bloc_test/bloc_test.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/domain/usecases/get_products_usecase.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/products_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetProducts extends Mock implements GetProductsUseCase {}

void main() {
  late _MockGetProducts useCase;

  const products = [
    ProductEntity(
      id: 1,
      name: 'Wireless Headphones',
      categoryId: 1,
      categoryName: 'Electronics',
      price: 299,
      quantity: 45,
      imagePath: '',
      isVisible: true,
    ),
    ProductEntity(
      id: 2,
      name: 'Cotton T-Shirt',
      categoryId: 1,
      categoryName: 'Clothing',
      price: 89,
      quantity: 120,
      imagePath: '',
      isVisible: true,
    ),
  ];

  setUp(() {
    useCase = _MockGetProducts();
    when(() => useCase()).thenAnswer((_) async => products);
  });

  test('search matches the name or the category, ignoring case', () {
    expect(ProductsSuccess(products, query: 'HEAD').filtered.map((p) => p.id), [
      1,
    ]);
    expect(
      ProductsSuccess(products, query: 'clothing').filtered.map((p) => p.id),
      [2],
    );
    expect(ProductsSuccess(products, query: 'xyz').filtered, isEmpty);
    expect(ProductsSuccess(products, query: '  ').filtered, products);
  });

  blocTest<ProductsCubit, ProductsState>(
    'load then search keeps all products and applies the query',
    build: () => ProductsCubit(useCase),
    act: (cubit) async {
      await cubit.load();
      cubit.search('cotton');
    },
    verify: (cubit) {
      final state = cubit.state as ProductsSuccess;
      expect(state.products.length, 2);
      expect(state.filtered.single.name, 'Cotton T-Shirt');
    },
  );
}
