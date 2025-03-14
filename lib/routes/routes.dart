import 'package:day59/controllers/home/HomeBinding.dart';
import 'package:day59/controllers/products/ProductBinding.dart';
import 'package:day59/controllers/splash/SplashBinding.dart';
import 'package:day59/views/authentication/LoginPage.dart';
import 'package:day59/views/authentication/RegisterPage.dart';
import 'package:day59/views/bookmark/BookmarkPage.dart';
import 'package:day59/views/home/HomePage.dart';
import 'package:day59/views/order/OrdersPage.dart';
import 'package:day59/views/product/ProductPage.dart';
import 'package:day59/views/cart/CartPage.dart'; // Add CartPage
import 'package:day59/views/profile/ProfilePage.dart';
import 'package:day59/views/splash/SplashPage.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const initial = '/splash'; // Set initial route to Splash

  static const splash = '/splash';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const product = '/product/:id';
  static const cart = '/cart';
  static const profile = '/profile';
  static const orders = '/orders';
  static const bookmark = '/bookmark';

  static final routes = [
    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: register,
      page: () => RegistrationPage(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: product,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: cart,
      page: () => CartPage(),
      // middlewares: [AuthMiddleware()], // Protect cart route
    ),
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      binding: SplashBinding(), // Add if SplashScreen has logic
    ),
    GetPage(
      name: profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: orders,
      page: () => OrdersPage(),
    ),
    GetPage(
      name: bookmark,
      page: () => BookmarksPage(),
    ),
  ];
}
