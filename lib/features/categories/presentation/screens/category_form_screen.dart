import 'package:easy_shop_admin/core/helpers/validators.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/features/categories/domain/entities/category_entity.dart';
import 'package:easy_shop_admin/features/categories/presentation/cubit/category_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFormScreen extends StatefulWidget {
  final CategoryEntity? category;
  final int productsCount;

  const CategoryFormScreen({super.key, this.category, this.productsCount = 0});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(
    text: widget.category?.name,
  );
  late final _descriptionController = TextEditingController(
    text: widget.category?.description,
  );

  late bool _canSubmit = _nameController.text.trim().isNotEmpty;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      final canSubmit = _nameController.text.trim().isNotEmpty;
      if (canSubmit != _canSubmit) setState(() => _canSubmit = canSubmit);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<CategoryFormCubit>();
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    if (_isEditing) {
      cubit.update(
        id: widget.category!.id,
        name: name,
        description: description,
      );
    } else {
      cubit.add(name: name, description: description);
    }
  }

  String get _deleteMessage {
    final name = widget.category!.name;
    final count = widget.productsCount;
    if (count == 0) return '"$name" will be removed. This cannot be undone.';
    final products = count == 1 ? '1 product' : '$count products';
    return '"$name" has $products. Deleting this category may also '
        'affect them. This cannot be undone.';
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete category?'),
        content: Text(_deleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      context.read<CategoryFormCubit>().delete(widget.category!.id);
    }
  }

  void _onState(BuildContext context, CategoryFormState state) {
    if (state.status == CategoryFormStatus.done) {
      Navigator.pop(context, true);
    } else if (state.status == CategoryFormStatus.failure) {
      showAppSnackBar(
        context,
        state.message ?? 'Something went wrong',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Category' : 'Add Category'),
      ),
      body: SafeArea(
        child: BlocConsumer<CategoryFormCubit, CategoryFormState>(
          listener: _onState,
          builder: (context, state) {
            final isBusy = state.status == CategoryFormStatus.submitting;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.screenPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      label: 'Category Name',
                      hint: 'e.g. Electronics',
                      controller: _nameController,
                      validator: (value) =>
                          Validators.required(value, 'Category name'),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppDimensions.spaceMedium),
                    AppTextField(
                      label: 'Description',
                      hint: 'Brief description...',
                      controller: _descriptionController,
                      isOptional: true,
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppDimensions.spaceLarge),
                    AppButton(
                      label: _isEditing ? 'Save Changes' : 'Create Category',
                      isLoading: isBusy,
                      onPressed: _canSubmit ? _submit : null,
                    ),
                    if (_isEditing) ...[
                      const SizedBox(height: AppDimensions.spaceMedium),
                      TextButton.icon(
                        onPressed: isBusy ? null : _confirmDelete,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Delete Category'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
