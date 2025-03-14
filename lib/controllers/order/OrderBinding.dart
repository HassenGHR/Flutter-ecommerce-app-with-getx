import 'package:day59/controllers/order/OrderController.dart';
import 'package:day59/providers/OrderProvider.dart';
import 'package:day59/repositories/OrderRepository.dart';
import 'package:get/get.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(() => OrderRepository());
    Get.lazyPut<OrderProvider>(() => OrderProvider(Get.find()));

    Get.lazyPut<OrderController>(() => OrderController());
  }
}
