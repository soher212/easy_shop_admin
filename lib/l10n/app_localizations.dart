import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Easy Shop Merchant'**
  String get appTitle;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get changeLanguage;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @createCategory.
  ///
  /// In en, this message translates to:
  /// **'Create Category'**
  String get createCategory;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @businessAddress.
  ///
  /// In en, this message translates to:
  /// **'Business Address'**
  String get businessAddress;

  /// No description provided for @storeLocation.
  ///
  /// In en, this message translates to:
  /// **'Store Location'**
  String get storeLocation;

  /// No description provided for @commercialRegister.
  ///
  /// In en, this message translates to:
  /// **'Commercial Register'**
  String get commercialRegister;

  /// No description provided for @taxCard.
  ///
  /// In en, this message translates to:
  /// **'Tax Card'**
  String get taxCard;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @businessInformation.
  ///
  /// In en, this message translates to:
  /// **'Business Information'**
  String get businessInformation;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @visible.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get visible;

  /// No description provided for @hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hidden;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrdersYet;

  /// No description provided for @noProductsYet.
  ///
  /// In en, this message translates to:
  /// **'No products yet'**
  String get noProductsYet;

  /// No description provided for @noCategoriesYet.
  ///
  /// In en, this message translates to:
  /// **'No categories yet'**
  String get noCategoriesYet;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @recentOrders.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get recentOrders;

  /// No description provided for @productsOverview.
  ///
  /// In en, this message translates to:
  /// **'Products Overview'**
  String get productsOverview;

  /// No description provided for @totalProducts.
  ///
  /// In en, this message translates to:
  /// **'Total Products'**
  String get totalProducts;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// No description provided for @pendingOrders.
  ///
  /// In en, this message translates to:
  /// **'Pending Orders'**
  String get pendingOrders;

  /// No description provided for @addProductAction.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProductAction;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @deliveryLocation.
  ///
  /// In en, this message translates to:
  /// **'Delivery Location'**
  String get deliveryLocation;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @deleteProductQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete product?'**
  String get deleteProductQuestion;

  /// No description provided for @deleteCategoryQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete category?'**
  String get deleteCategoryQuestion;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @permissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Permission needed'**
  String get permissionNeeded;

  /// No description provided for @locationBlocked.
  ///
  /// In en, this message translates to:
  /// **'Location is blocked'**
  String get locationBlocked;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @unknownRouteMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find that page.'**
  String get unknownRouteMessage;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validEmail;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name (first and last name)'**
  String get enterFullName;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @phoneFormat.
  ///
  /// In en, this message translates to:
  /// **'Phone must start with +20 followed by 10 digits'**
  String get phoneFormat;

  /// No description provided for @nationalIdRequired.
  ///
  /// In en, this message translates to:
  /// **'National ID is required'**
  String get nationalIdRequired;

  /// No description provided for @nationalIdFormat.
  ///
  /// In en, this message translates to:
  /// **'National ID must be 14 digits starting with 2 or 3'**
  String get nationalIdFormat;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordLength;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @validPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid price'**
  String get validPrice;

  /// No description provided for @positivePrice.
  ///
  /// In en, this message translates to:
  /// **'Price must be greater than 0'**
  String get positivePrice;

  /// No description provided for @wholeNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number'**
  String get wholeNumber;

  /// No description provided for @nonNegativeQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity cannot be negative'**
  String get nonNegativeQuantity;

  /// No description provided for @businessDocuments.
  ///
  /// In en, this message translates to:
  /// **'Business Documents'**
  String get businessDocuments;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItems;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get inStock;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @deleteCategoryWarning.
  ///
  /// In en, this message translates to:
  /// **'This category contains {count} product(s). Deleting it will also affect these products.'**
  String deleteCategoryWarning(String count);

  /// No description provided for @searchProducts.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProducts;

  /// No description provided for @searchOrders.
  ///
  /// In en, this message translates to:
  /// **'Search orders...'**
  String get searchOrders;

  /// No description provided for @welcomeMerchant.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Easy Shop'**
  String get welcomeMerchant;

  /// No description provided for @createStoreAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your store account'**
  String get createStoreAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @newMerchant.
  ///
  /// In en, this message translates to:
  /// **'New merchant?'**
  String get newMerchant;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get createOne;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get requestFailed;

  /// No description provided for @addressUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Address unavailable'**
  String get addressUnavailable;

  /// No description provided for @stepPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get stepPersonal;

  /// No description provided for @stepBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business Information'**
  String get stepBusiness;

  /// No description provided for @stepSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get stepSecurity;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get confirmDelete;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'{field} is required'**
  String requiredField(String field);

  /// No description provided for @noProductsMatchSearch.
  ///
  /// In en, this message translates to:
  /// **'No products match your search'**
  String get noProductsMatchSearch;

  /// No description provided for @selectCategoryError.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectCategoryError;

  /// No description provided for @businessNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Business name is required'**
  String get businessNameRequired;

  /// No description provided for @locationSet.
  ///
  /// In en, this message translates to:
  /// **'Location set'**
  String get locationSet;

  /// No description provided for @tapToSetLocation.
  ///
  /// In en, this message translates to:
  /// **'Tap to set store location'**
  String get tapToSetLocation;

  /// No description provided for @uploadCommercialRegister.
  ///
  /// In en, this message translates to:
  /// **'Upload Commercial Register'**
  String get uploadCommercialRegister;

  /// No description provided for @commercialRegisterUploaded.
  ///
  /// In en, this message translates to:
  /// **'Commercial Register uploaded'**
  String get commercialRegisterUploaded;

  /// No description provided for @uploadTaxCard.
  ///
  /// In en, this message translates to:
  /// **'Upload Tax Card'**
  String get uploadTaxCard;

  /// No description provided for @taxCardUploaded.
  ///
  /// In en, this message translates to:
  /// **'Tax Card uploaded'**
  String get taxCardUploaded;

  /// No description provided for @deleteProductMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} will be removed from your store. This cannot be undone.'**
  String deleteProductMessage(String name);

  /// No description provided for @categoryDeleteWithProducts.
  ///
  /// In en, this message translates to:
  /// **'{name} has {count} product(s). Deleting this category may also affect them. This cannot be undone.'**
  String categoryDeleteWithProducts(String name, String count);

  /// No description provided for @categoryDeleteEmpty.
  ///
  /// In en, this message translates to:
  /// **'{name} will be removed. This cannot be undone.'**
  String categoryDeleteEmpty(String name);

  /// No description provided for @profilePicture.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profilePicture;

  /// No description provided for @signInDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your store'**
  String get signInDescription;

  /// No description provided for @forBusiness.
  ///
  /// In en, this message translates to:
  /// **'FOR BUSINESS'**
  String get forBusiness;

  /// No description provided for @signInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInLink;

  /// No description provided for @tapToChooseLocation.
  ///
  /// In en, this message translates to:
  /// **'Tap to set store location'**
  String get tapToChooseLocation;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @merchantLabel.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get merchantLabel;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon,'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening,'**
  String get goodEvening;

  /// No description provided for @qtyValue.
  ///
  /// In en, this message translates to:
  /// **'Qty {quantity}'**
  String qtyValue(String quantity);

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @removeImage.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get removeImage;

  /// No description provided for @uploadProductImage.
  ///
  /// In en, this message translates to:
  /// **'Upload product image'**
  String get uploadProductImage;

  /// No description provided for @editProductImage.
  ///
  /// In en, this message translates to:
  /// **'Edit product image'**
  String get editProductImage;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get selectImage;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @locationPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'Allow location access in settings to choose a location.'**
  String get locationPermissionMessage;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @orderCode.
  ///
  /// In en, this message translates to:
  /// **'Order #{code}'**
  String orderCode(String code);

  /// No description provided for @visibleToCustomers.
  ///
  /// In en, this message translates to:
  /// **'Visible to customers'**
  String get visibleToCustomers;

  /// No description provided for @showProductInStore.
  ///
  /// In en, this message translates to:
  /// **'Show this product in your store'**
  String get showProductInStore;

  /// No description provided for @addProductImageOptional.
  ///
  /// In en, this message translates to:
  /// **'Add product image (optional)'**
  String get addProductImageOptional;

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemCount(String count);

  /// No description provided for @oneItem.
  ///
  /// In en, this message translates to:
  /// **'1 item'**
  String get oneItem;

  /// No description provided for @noAddressProvided.
  ///
  /// In en, this message translates to:
  /// **'No address provided'**
  String get noAddressProvided;

  /// No description provided for @viewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on Map'**
  String get viewOnMap;

  /// No description provided for @tapMapToChoose.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to choose the location'**
  String get tapMapToChoose;

  /// No description provided for @findingPlaceName.
  ///
  /// In en, this message translates to:
  /// **'Finding the place name...'**
  String get findingPlaceName;

  /// No description provided for @atTime.
  ///
  /// In en, this message translates to:
  /// **' at '**
  String get atTime;

  /// No description provided for @merchantPortal.
  ///
  /// In en, this message translates to:
  /// **'Merchant Portal'**
  String get merchantPortal;

  /// No description provided for @profileLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load your profile.'**
  String get profileLoadFailed;

  /// No description provided for @imageUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not upload image.'**
  String get imageUploadFailed;

  /// No description provided for @added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get added;

  /// No description provided for @verificationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit verification code to\n{email}'**
  String verificationCodeSent(String email);

  /// No description provided for @uploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get uploaded;

  /// No description provided for @notUploaded.
  ///
  /// In en, this message translates to:
  /// **'Not uploaded'**
  String get notUploaded;

  /// No description provided for @stepProgress.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total} — {name}'**
  String stepProgress(String current, String total, String name);

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location is unavailable.'**
  String get locationUnavailable;

  /// No description provided for @codeExpired.
  ///
  /// In en, this message translates to:
  /// **'Code expired'**
  String get codeExpired;

  /// No description provided for @codeExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Code expires in '**
  String get codeExpiresIn;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Manage Categories'**
  String get manageCategories;

  /// No description provided for @briefDescription.
  ///
  /// In en, this message translates to:
  /// **'Brief description...'**
  String get briefDescription;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @strongPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Create a strong password'**
  String get strongPasswordHint;

  /// No description provided for @repeatPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat your password'**
  String get repeatPasswordHint;

  /// No description provided for @optionalProductDescription.
  ///
  /// In en, this message translates to:
  /// **'Optional product description...'**
  String get optionalProductDescription;

  /// No description provided for @locationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Tap to update'**
  String get locationUpdated;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload photo'**
  String get uploadPhoto;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @couldNotSaveProfile.
  ///
  /// In en, this message translates to:
  /// **'Could not save your profile'**
  String get couldNotSaveProfile;

  /// No description provided for @locationServicesOff.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services to use your current location'**
  String get locationServicesOff;

  /// No description provided for @locationPermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Location permission is needed to get your location'**
  String get locationPermissionNeeded;

  /// No description provided for @locationPermissionBlocked.
  ///
  /// In en, this message translates to:
  /// **'Location permission is blocked. Allow it in app settings.'**
  String get locationPermissionBlocked;

  /// No description provided for @locationRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not get your location. Please try again.'**
  String get locationRequestFailed;

  /// No description provided for @cameraPermissionBlocked.
  ///
  /// In en, this message translates to:
  /// **'Camera access is blocked. Allow it in app settings.'**
  String get cameraPermissionBlocked;

  /// No description provided for @photosPermissionBlocked.
  ///
  /// In en, this message translates to:
  /// **'Photos access is blocked. Allow it in app settings.'**
  String get photosPermissionBlocked;

  /// No description provided for @cameraRestricted.
  ///
  /// In en, this message translates to:
  /// **'Camera access is restricted on this device'**
  String get cameraRestricted;

  /// No description provided for @noCameraAvailable.
  ///
  /// In en, this message translates to:
  /// **'No camera is available on this device'**
  String get noCameraAvailable;

  /// No description provided for @imagePickFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not pick the picture. Please try again.'**
  String get imagePickFailed;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @connectionTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again.'**
  String get connectionTimedOut;

  /// No description provided for @serverUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your internet connection.'**
  String get serverUnavailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
