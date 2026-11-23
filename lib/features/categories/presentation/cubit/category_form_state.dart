part of 'category_form_cubit.dart';

enum CategoryFormStatus { idle, submitting, done, failure }

class CategoryFormState {
  final CategoryFormStatus status;
  final String? message;

  const CategoryFormState({
    this.status = CategoryFormStatus.idle,
    this.message,
  });
}
