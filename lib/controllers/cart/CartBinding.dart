import 'package:day59/controllers/order/OrderController.dart';
import 'package:get/get.dart';
import 'package:day59/controllers/cart/CartController.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<OrderController>(() => OrderController());
  }
}
