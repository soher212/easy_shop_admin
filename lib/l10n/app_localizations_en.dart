// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Easy Shop Merchant';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get changeLanguage => 'Language';

  @override
  String get home => 'Home';

  @override
  String get products => 'Products';

  @override
  String get orders => 'Orders';

  @override
  String get profile => 'Profile';

  @override
  String get categories => 'Categories';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get addProduct => 'Add Product';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get addCategory => 'Add Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get createCategory => 'Create Category';

  @override
  String get createAccount => 'Create Account';

  @override
  String get continueLabel => 'Continue';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get welcome => 'Welcome';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get fullName => 'Full Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get nationalId => 'National ID';

  @override
  String get businessName => 'Business Name';

  @override
  String get businessAddress => 'Business Address';

  @override
  String get storeLocation => 'Store Location';

  @override
  String get commercialRegister => 'Commercial Register';

  @override
  String get taxCard => 'Tax Card';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get businessInformation => 'Business Information';

  @override
  String get security => 'Security';

  @override
  String get description => 'Description';

  @override
  String get categoryName => 'Category Name';

  @override
  String get productName => 'Product Name';

  @override
  String get price => 'Price';

  @override
  String get quantity => 'Quantity';

  @override
  String get visible => 'Visible';

  @override
  String get hidden => 'Hidden';

  @override
  String get pending => 'Pending';

  @override
  String get processing => 'Processing';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get card => 'Card';

  @override
  String get cash => 'Cash';

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String get noProductsYet => 'No products yet';

  @override
  String get noCategoriesYet => 'No categories yet';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get recentOrders => 'Recent Orders';

  @override
  String get productsOverview => 'Products Overview';

  @override
  String get totalProducts => 'Total Products';

  @override
  String get totalOrders => 'Total Orders';

  @override
  String get pendingOrders => 'Pending Orders';

  @override
  String get addProductAction => 'Add Product';

  @override
  String get selectLocation => 'Select Location';

  @override
  String get confirmLocation => 'Confirm Location';

  @override
  String get deliveryLocation => 'Delivery Location';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get productDetails => 'Product Details';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get save => 'Save';

  @override
  String get deleteProductQuestion => 'Delete product?';

  @override
  String get deleteCategoryQuestion => 'Delete category?';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get permissionNeeded => 'Permission needed';

  @override
  String get locationBlocked => 'Location is blocked';

  @override
  String get notNow => 'Not now';

  @override
  String get openSettings => 'Open settings';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get unknownRouteMessage => 'We couldn\'t find that page.';

  @override
  String get verifyEmail => 'Verify Email';

  @override
  String get checkYourEmail => 'Check your email';

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get validEmail => 'Enter a valid email';

  @override
  String get fullNameRequired => 'Full name is required';

  @override
  String get enterFullName => 'Enter your full name (first and last name)';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneFormat => 'Phone must start with +20 followed by 10 digits';

  @override
  String get nationalIdRequired => 'National ID is required';

  @override
  String get nationalIdFormat =>
      'National ID must be 14 digits starting with 2 or 3';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordLength => 'Password must be at least 6 characters';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get validPrice => 'Enter a valid price';

  @override
  String get positivePrice => 'Price must be greater than 0';

  @override
  String get wholeNumber => 'Enter a whole number';

  @override
  String get nonNegativeQuantity => 'Quantity cannot be negative';

  @override
  String get businessDocuments => 'Business Documents';

  @override
  String get delivery => 'Delivery';

  @override
  String get customer => 'Customer';

  @override
  String get orderItems => 'Order Items';

  @override
  String get payment => 'Payment';

  @override
  String get summary => 'Summary';

  @override
  String get total => 'Total';

  @override
  String get visibility => 'Visibility';

  @override
  String get inStock => 'In Stock';

  @override
  String get edit => 'Edit';

  @override
  String deleteCategoryWarning(String count) {
    return 'This category contains $count product(s). Deleting it will also affect these products.';
  }

  @override
  String get searchProducts => 'Search products...';

  @override
  String get searchOrders => 'Search orders...';

  @override
  String get welcomeMerchant => 'Welcome to Easy Shop';

  @override
  String get createStoreAccount => 'Create your store account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get newMerchant => 'New merchant?';

  @override
  String get createOne => 'Create one';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get selectCategory => 'Select category';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String get deleteProduct => 'Delete Product';

  @override
  String get requestFailed => 'Something went wrong. Please try again.';

  @override
  String get addressUnavailable => 'Address unavailable';

  @override
  String get stepPersonal => 'Personal Information';

  @override
  String get stepBusiness => 'Business Information';

  @override
  String get stepSecurity => 'Security';

  @override
  String get confirmDelete => 'Are you sure you want to delete this item?';

  @override
  String get noData => 'No data available';

  @override
  String get optional => 'Optional';

  @override
  String requiredField(String field) {
    return '$field is required';
  }

  @override
  String get noProductsMatchSearch => 'No products match your search';

  @override
  String get selectCategoryError => 'Select a category';

  @override
  String get businessNameRequired => 'Business name is required';

  @override
  String get locationSet => 'Location set';

  @override
  String get tapToSetLocation => 'Tap to set store location';

  @override
  String get uploadCommercialRegister => 'Upload Commercial Register';

  @override
  String get commercialRegisterUploaded => 'Commercial Register uploaded';

  @override
  String get uploadTaxCard => 'Upload Tax Card';

  @override
  String get taxCardUploaded => 'Tax Card uploaded';

  @override
  String deleteProductMessage(String name) {
    return '$name will be removed from your store. This cannot be undone.';
  }

  @override
  String categoryDeleteWithProducts(String name, String count) {
    return '$name has $count product(s). Deleting this category may also affect them. This cannot be undone.';
  }

  @override
  String categoryDeleteEmpty(String name) {
    return '$name will be removed. This cannot be undone.';
  }

  @override
  String get profilePicture => 'Profile Picture';

  @override
  String get signInDescription => 'Sign in to manage your store';

  @override
  String get forBusiness => 'FOR BUSINESS';

  @override
  String get signInLink => 'Sign in';

  @override
  String get tapToChooseLocation => 'Tap to set store location';

  @override
  String get category => 'Category';

  @override
  String get merchantLabel => 'Merchant';

  @override
  String get goodMorning => 'Good morning,';

  @override
  String get goodAfternoon => 'Good afternoon,';

  @override
  String get goodEvening => 'Good evening,';

  @override
  String qtyValue(String quantity) {
    return 'Qty $quantity';
  }

  @override
  String get seeAll => 'See all';

  @override
  String get removeImage => 'Remove image';

  @override
  String get uploadProductImage => 'Upload product image';

  @override
  String get editProductImage => 'Edit product image';

  @override
  String get selectImage => 'Select image';

  @override
  String get location => 'Location';

  @override
  String get locationPermissionMessage =>
      'Allow location access in settings to choose a location.';

  @override
  String get product => 'Product';

  @override
  String get stock => 'Stock';

  @override
  String orderCode(String code) {
    return 'Order #$code';
  }

  @override
  String get visibleToCustomers => 'Visible to customers';

  @override
  String get showProductInStore => 'Show this product in your store';

  @override
  String get addProductImageOptional => 'Add product image (optional)';

  @override
  String itemCount(String count) {
    return '$count items';
  }

  @override
  String get oneItem => '1 item';

  @override
  String get noAddressProvided => 'No address provided';

  @override
  String get viewOnMap => 'View on Map';

  @override
  String get tapMapToChoose => 'Tap the map to choose the location';

  @override
  String get findingPlaceName => 'Finding the place name...';

  @override
  String get atTime => ' at ';

  @override
  String get merchantPortal => 'Merchant Portal';

  @override
  String get profileLoadFailed => 'Could not load your profile.';

  @override
  String get imageUploadFailed => 'Could not upload image.';

  @override
  String get added => 'Added';

  @override
  String verificationCodeSent(String email) {
    return 'We sent a 6-digit verification code to\n$email';
  }

  @override
  String get uploaded => 'Uploaded';

  @override
  String get notUploaded => 'Not uploaded';

  @override
  String stepProgress(String current, String total, String name) {
    return 'Step $current of $total — $name';
  }

  @override
  String get locationUnavailable => 'Location is unavailable.';

  @override
  String get codeExpired => 'Code expired';

  @override
  String get codeExpiresIn => 'Code expires in ';

  @override
  String get manageCategories => 'Manage Categories';

  @override
  String get briefDescription => 'Brief description...';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get strongPasswordHint => 'Create a strong password';

  @override
  String get repeatPasswordHint => 'Repeat your password';

  @override
  String get optionalProductDescription => 'Optional product description...';

  @override
  String get locationUpdated => 'Tap to update';

  @override
  String get uploadPhoto => 'Upload photo';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get couldNotSaveProfile => 'Could not save your profile';

  @override
  String get locationServicesOff =>
      'Turn on location services to use your current location';

  @override
  String get locationPermissionNeeded =>
      'Location permission is needed to get your location';

  @override
  String get locationPermissionBlocked =>
      'Location permission is blocked. Allow it in app settings.';

  @override
  String get locationRequestFailed =>
      'Could not get your location. Please try again.';

  @override
  String get cameraPermissionBlocked =>
      'Camera access is blocked. Allow it in app settings.';

  @override
  String get photosPermissionBlocked =>
      'Photos access is blocked. Allow it in app settings.';

  @override
  String get cameraRestricted => 'Camera access is restricted on this device';

  @override
  String get noCameraAvailable => 'No camera is available on this device';

  @override
  String get imagePickFailed => 'Could not pick the picture. Please try again.';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get connectionTimedOut => 'Connection timed out. Please try again.';

  @override
  String get serverUnavailable =>
      'Could not reach the server. Check your internet connection.';
}
