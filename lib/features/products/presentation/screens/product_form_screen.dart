import 'package:easy_shop_admin/core/helpers/format.dart';
import 'package:easy_shop_admin/core/helpers/validators.dart';
import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:easy_shop_admin/core/theme/app_dimensions.dart';
import 'package:easy_shop_admin/core/widgets/app_button.dart';
import 'package:easy_shop_admin/core/widgets/app_snack_bar.dart';
import 'package:easy_shop_admin/core/widgets/app_text_field.dart';
import 'package:easy_shop_admin/core/widgets/error_view.dart';
import 'package:easy_shop_admin/core/widgets/field_label.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_entity.dart';
import 'package:easy_shop_admin/features/products/domain/entities/product_form_data.dart';
import 'package:easy_shop_admin/features/products/presentation/cubit/product_form_cubit.dart';
import 'package:easy_shop_admin/features/products/presentation/widgets/product_image_picker.dart';
import 'package:easy_shop_admin/features/products/presentation/widgets/visibility_switch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// One form for both adding a product and editing an existing one.
class ProductFormScreen extends StatefulWidget {
  final ProductEntity? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(
    text: widget.product?.name,
  );
  late final _priceController = TextEditingController(
    text: widget.product == null ? null : formatPrice(widget.product!.price),
  );
  late final _quantityController = TextEditingController(
    text: widget.product?.quantity.toString(),
  );
  late final _descriptionController = TextEditingController(
    text: widget.product?.description,
  );

  XFile? _image;
  late int? _categoryId = widget.product?.categoryId;
  late bool _isVisible = widget.product?.isVisible ?? true;
  late bool _canSubmit = _computeCanSubmit();

  bool get _isEditing => widget.product != null;

  List<TextEditingController> get _requiredControllers => [
    _nameController,
    _priceController,
    _quantityController,
  ];

  bool _computeCanSubmit() =>
      _requiredControllers.every((c) => c.text.trim().isNotEmpty) &&
      _categoryId != null;

  @override
  void initState() {
    super.initState();
    for (final controller in _requiredControllers) {
      controller.addListener(_updateCanSubmit);
    }
  }

  @override
  void dispose() {
    for (final controller in [
      ..._requiredControllers,
      _descriptionController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateCanSubmit() {
    final canSubmit = _computeCanSubmit();
    if (canSubmit != _canSubmit) setState(() => _canSubmit = canSubmit);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final data = ProductFormData(
      name: _nameController.text.trim(),
      categoryId: _categoryId!,
      price: double.parse(_priceController.text.trim()),
      quantity: int.parse(_quantityController.text.trim()),
      description: _descriptionController.text.trim(),
      isVisible: _isVisible,
      image: _image,
    );
    final cubit = context.read<ProductFormCubit>();
    if (_isEditing) {
      cubit.update(widget.product!.id, data);
    } else {
      cubit.add(data);
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete product?'),
        content: Text(
          '"${widget.product!.name}" will be removed from your store. '
          'This cannot be undone.',
        ),
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
      context.read<ProductFormCubit>().delete(widget.product!.id);
    }
  }

  void _onState(BuildContext context, ProductFormState state) {
    if (state.status == ProductFormStatus.saved) {
      Navigator.pop(context, true);
    } else if (state.status == ProductFormStatus.failure &&
        state.categories.isNotEmpty) {
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
      appBar: AppBar(title: Text(_isEditing ? 'Edit Product' : 'Add Product')),
      body: SafeArea(
        child: BlocConsumer<ProductFormCubit, ProductFormState>(
          listener: _onState,
          builder: (context, state) {
            if (state.status == ProductFormStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ProductFormStatus.failure &&
                state.categories.isEmpty) {
              return ErrorView(
                message: state.message ?? 'Could not load categories',
                onRetry: () =>
                    context.read<ProductFormCubit>().loadCategories(),
              );
            }
            return _form(state);
          },
        ),
      ),
    );
  }

  Widget _form(ProductFormState state) {
    final isBusy = state.status == ProductFormStatus.submitting;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.screenPadding),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductImagePicker(
              image: _image,
              existingImagePath: widget.product?.imagePath,
              onPicked: (file) => setState(() => _image = file),
            ),
            const SizedBox(height: AppDimensions.spaceMedium),
            AppTextField(
              label: 'Product Name',
              hint: 'e.g. Wireless Headphones',
              controller: _nameController,
              validator: (value) => Validators.required(value, 'Product name'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppDimensions.spaceMedium),
            _categoryField(state),
            const SizedBox(height: AppDimensions.spaceMedium),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Price',
                    hint: '0.00',
                    controller: _priceController,
                    validator: Validators.price,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMedium),
                Expanded(
                  child: AppTextField(
                    label: 'Quantity',
                    hint: '0',
                    controller: _quantityController,
                    validator: Validators.quantity,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceMedium),
            AppTextField(
              label: 'Description',
              hint: 'Optional product description...',
              controller: _descriptionController,
              isOptional: true,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: AppDimensions.spaceMedium),
            VisibilitySwitchCard(
              value: _isVisible,
              onChanged: (value) => setState(() => _isVisible = value),
            ),
            const SizedBox(height: AppDimensions.spaceLarge),
            AppButton(
              label: _isEditing ? 'Save Changes' : 'Add Product',
              isLoading: isBusy,
              onPressed: _canSubmit ? _submit : null,
            ),
            if (_isEditing) ...[
              const SizedBox(height: AppDimensions.spaceMedium),
              TextButton.icon(
                onPressed: isBusy ? null : _confirmDelete,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete Product'),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _categoryField(ProductFormState state) {
    // The product's category may have been deleted since it was saved.
    final selected = state.categories.any((c) => c.id == _categoryId)
        ? _categoryId
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel('Category'),
        const SizedBox(height: AppDimensions.spaceSmall),
        DropdownButtonFormField<int>(
          initialValue: selected,
          isExpanded: true,
          hint: const Text('Select category'),
          decoration: const InputDecoration(),
          items: [
            for (final category in state.categories)
              DropdownMenuItem(value: category.id, child: Text(category.name)),
          ],
          validator: (value) => value == null ? 'Select a category' : null,
          onChanged: (value) {
            setState(() => _categoryId = value);
            _updateCanSubmit();
          },
        ),
      ],
    );
  }
}
