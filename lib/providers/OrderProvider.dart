import 'package:day59/models/order/OrderModel.dart';
import 'package:day59/repositories/OrderRepository.dart';
import 'package:get/get.dart';

class OrderProvider extends GetxController {
  final OrderRepository _orderRepository;

  // Reactive states
  var submitting = false.obs;
  var orderList = <OrderModel>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;

  // Pagination variables
  static const int _pageSize = 10;
  String? _lastFetchedOrderId;

  OrderProvider(this._orderRepository);

  // Fetch order history with pagination
  Future<List<OrderModel>> fetchOrderHistory(String phoneNumber) async {
    resetOrderHistory();
    print("isLoading: ${isLoading.value}, hasMore: ${hasMore.value}");
    if (isLoading.value || !hasMore.value) return [];

    try {
      isLoading.value = true;
      final result = await _orderRepository.getOrderHistory(
        phoneNumber,
        // lastFetchedOrderId: _lastFetchedOrderId,
      );

      if (result.length == _pageSize) {
        hasMore.value = true;
        _lastFetchedOrderId =
            result.last.id; // Use the last order's ID for pagination
      } else {
        hasMore.value = false;
      }

      orderList.addAll(result);
      return orderList;
    } catch (e) {
      print("Error fetching order history: $e");
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  // Reset pagination and data
  void resetOrderHistory() {
    orderList.clear();
    _lastFetchedOrderId = null;
    hasMore.value = true;
  }
}
