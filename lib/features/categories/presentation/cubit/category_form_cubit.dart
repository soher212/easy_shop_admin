import 'package:easy_shop_admin/core/networking/api_error_handler.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/add_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/delete_category_usecase.dart';
import 'package:easy_shop_admin/features/categories/domain/usecases/update_category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_form_state.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final AddCategoryUseCase _addCategory;
  final UpdateCategoryUseCase _updateCategory;
  final DeleteCategoryUseCase _deleteCategory;

  CategoryFormCubit(
    this._addCategory,
    this._updateCategory,
    this._deleteCategory,
  ) : super(const CategoryFormState());

  Future<void> add({required String name, required String description}) {
    return _run(() => _addCategory(name: name, description: description));
  }

  Future<void> update({
    required int id,
    required String name,
    required String description,
  }) {
    return _run(
      () => _updateCategory(id: id, name: name, description: description),
    );
  }

  Future<void> delete(int id) => _run(() => _deleteCategory(id));

  Future<void> _run(Future<void> Function() action) async {
    emit(const CategoryFormState(status: CategoryFormStatus.submitting));
    try {
      await action();
      emit(const CategoryFormState(status: CategoryFormStatus.done));
    } catch (error) {
      emit(
        CategoryFormState(
          status: CategoryFormStatus.failure,
          message: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }
}
