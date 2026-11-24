# Easy Shop Merchant

Easy Shop Merchant is the store-management application in the Easy Shop system. It covers the merchant journey from account registration and OTP verification to managing the store, catalog, orders, and profile.

## Overview

Easy Shop consists of two separate Flutter applications: this merchant app and Easy Shop Client. The intended system shares categories and products between both apps through one API. The merchant interface and core workflows are implemented. The server is currently unavailable, so authentication is configured for the API while store-management data is supplied by temporary mock repositories.

## Merchant Journey and Implemented Features

### Account Registration and Verification

- An entry screen routes merchants to sign in or create an account.
- A multi-step registration flow collects personal information, business information, and security details.
- Form validation checks a full name with at least two words, a valid email address, an Egyptian phone number in `+20` plus ten digits format, a 14-digit national ID beginning with 2 or 3, and a password of at least six characters.
- Business name, address, store location, commercial registration, and tax card are optional fields in the business step.
- OTP entry and resend screens complete the verification flow, followed by a registration success screen.
- Sign-in and sign-out flows use secure storage for the session token.

### Store Dashboard

- The home screen presents store metrics, including product, category, and order counts and order status summaries.
- Dashboard values are calculated from the repositories currently registered in the app and update after catalog changes.
- A bottom navigation bar connects the main application sections.

### Categories and Products

- Create, edit, and delete product categories.
- Before deleting a category that contains products, a confirmation warns the merchant and displays the number of affected products.
- Browse products and add, edit, or delete them.
- Product data includes name, description, price, quantity, category, image, and visibility status.
- Product and document images can be selected from the device; form fields validate values such as price and quantity.

### Orders and Merchant Profile

- Browse orders with their status and payment method.
- Open order details and view the order location on a dedicated map screen when coordinates are available.
- View and edit merchant profile and store information.
- Select a store location on a map; store location is optional in registration.

## Technology Stack

| Area | Technologies |
| --- | --- |
| Application | Flutter, Dart |
| State management | `flutter_bloc` / Cubit |
| Dependency injection | GetIt |
| Networking | Dio, `pretty_dio_logger` |
| Session storage | `flutter_secure_storage` |
| Images | `image_picker` |
| Location and maps | `geolocator`, `flutter_map`, `latlong2` |
| Configuration | `flutter_dotenv` |

## Project Structure

```text
lib/
├── core/                 # Networking, secure storage, DI, routing, theme, shared helpers
└── features/
    ├── auth/             # Registration, sign-in, OTP, and session handling
    ├── home/             # Merchant dashboard and metrics
    ├── categories/       # Category management
    ├── products/         # Product catalog and product forms
    ├── orders/           # Order list, details, and location
    ├── profile/          # Merchant and store profile
    ├── maps/             # Location selection
    └── splash/           # Application entry screen
test/                     # Cubit, widget, and map tests
assets/                   # Logo, product images, and icons
```

Features are separated into presentation, domain, and data responsibilities. Screens communicate through Cubits; use cases express application operations; repositories isolate the data source from the rest of the app. GetIt provides dependency registration.

## API Integration and Data Status

The application reads `API_BASE_URL` and `API_KEY` from the local `.env` file. Dio sends the `x-api-key` header and adds the saved session token as a Bearer token when available. The configured authentication endpoints are:

- `admin/register`
- `admin/login`
- `admin/otp/verify`
- `admin/otp/resend`
- `admin/logout`

Registration, sign-in, and OTP verification depend on the server and cannot currently be verified while it is unavailable. Categories, products, orders, profile data, and dashboard metrics use in-memory mock repositories. Changes made to this temporary data are not sent to the server, are lost after a full application restart, and are not shared with the client app.

## Tests

The test suite covers Cubit behavior and UI flows for the dashboard, categories, products, orders, profile, and map selection.

```bash
flutter pub get
flutter test
dart analyze
```

## Running the Application

The project uses Flutter with Dart SDK constraint `^3.12.2`. Without a saved session, the app starts on the splash and authentication flow; with a saved session, it opens the home screen.

```bash
flutter run
```

Local API configuration belongs in `.env`, which is excluded from Git. This README contains no API keys or credentials.
