# Oasis Delivery E-Commerce App

A comprehensive mobile e-commerce solution built with Flutter, offering a seamless shopping experience with robust features.

## Features

### Authentication
- User registration and login
- Social media authentication options
- Profile management

### Product Display
- Browse products by categories
- Featured and trending products on home page
- Search functionality with filters
- Product details view with images, descriptions.

### Shopping Cart
- Add/remove items
- Adjust quantities
- Submit orders

### Bookmarks
- Save favorite products

### Order Management
- Complete order history
- Detailed invoice generation for each order

### Push Notifications
- Order confirmation alerts
- Special promotions and discounts

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Firebase account (for authentication and push notifications)

### Installation
1. Clone the repository
```bash
git clone https://github.com/HassenGHR/Flutter-ecommerce-app-with-getx.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
   - Create a new Firebase project
   - Add Android & iOS apps in Firebase console
   - Download and place the configuration files
   - Enable Authentication and Cloud Messaging

4. Run the app
```bash
flutter run
```

## Configuration

## Architecture
This app follows a clean architecture pattern with:
- UI layer (screens, widgets)
- Business logic layer (providers/BLoC)
- Data layer (repositories, services)
- Domain layer (models)

