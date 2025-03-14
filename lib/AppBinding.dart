import 'package:day59/controllers/auth/AuthController.dart';
import 'package:day59/controllers/cart/CartController.dart';
import 'package:day59/controllers/language/LanguageController.dart';
import 'package:day59/controllers/order/OrderController.dart';
import 'package:day59/controllers/theme/ThemesController.dart';
import 'package:day59/providers/CategoryProvider.dart';
import 'package:day59/providers/OfferProvider.dart';
import 'package:day59/providers/OrderProvider.dart';
import 'package:day59/providers/ProductProvider.dart';
import 'package:day59/repositories/CategoryRepository.dart';
import 'package:day59/repositories/OfferRepository.dart';
import 'package:day59/repositories/OrderRepository.dart';
import 'package:day59/repositories/ProductRepository.dart';
import 'package:day59/services/networking/ApiService.dart';
import 'package:day59/services/networking/BaseProvider.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
