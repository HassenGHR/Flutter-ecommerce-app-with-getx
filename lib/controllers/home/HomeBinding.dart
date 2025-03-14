import 'package:day59/controllers/bookmark/BookMarkController.dart';
import 'package:day59/controllers/cart/CartController.dart';
import 'package:day59/controllers/home/HomeController.dart';
import 'package:day59/controllers/order/OrderController.dart';
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
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(ApiService(Get.find()), permanent: true);

    // Repositories - Initialize second
    Get.put(OrderRepository(), permanent: true);

    Get.put(OfferRepository(Get.find()), permanent: true);
    Get.put(CategoryRepository(Get.find()), permanent: true);
    Get.put(ProductRepository(Get.find()), permanent: true);

    // Providers - Initialize third
    Get.put(OrderProvider(Get.find()), permanent: true);

    Get.put(OfferProvider(Get.find()), permanent: true);
    Get.put(CategoryProvider(Get.find()), permanent: true);
    Get.put(ProductProvider(Get.find()), permanent: true);
    // Controllers - Initialize last
    Get.put(CartController(), permanent: true);
    Get.put(OrderController(), permanent: true);
    Get.put(BookmarkController(), permanent: true);

    Get.put(HomeController(Get.find(), Get.find()), permanent: true);
  }
}
