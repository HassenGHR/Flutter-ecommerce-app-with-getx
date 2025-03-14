import 'package:day59/models/order/OrderModel.dart';
import 'package:day59/models/user/UserModel.dart';
import 'package:day59/models/cart/CartModel.dart';
import 'package:day59/models/products/ProductModel.dart';

class OrderRepository {
  Future<List<OrderModel>> getOrderHistory(String phoneNumber) async {
    try {
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay

      List<OrderModel> dummyOrders = [
        OrderModel(
          id: '1',
          date: '2025-03-14',
          totalPrice: 150.0,
          user: UserModel(
            id: 'user1',
            name: 'John Doe',
            phone: phoneNumber,
            address: '123 Main St',
            imageUrl: '',
            token: 'token123',
            email: 'john@example.com',
          ),
          items: [
            CartModel(
              item: ProductModel(
                id: "p001",
                title: "Premium Leather Jacket",
                description:
                    "Handcrafted genuine leather jacket with quilted lining and brass zippers. Perfect for all seasons.",
                category: "Clothing",
                price: 249.99,
                isAvailable: true,
                priceDescription: "Limited time offer",
                imageUrls: [
                  {"image1": "https://picsum.photos/800/1200?random=1"},
                  {"cover_image": "https://picsum.photos/800/1200?random=2"},
                ],
              ),
              quantity: 2,
            ),
            CartModel(
              item: ProductModel(
                id: "p002",
                title: "Smart LED TV 55\"",
                description:
                    "Ultra HD 4K resolution with HDR support. Smart features include voice control and streaming apps.",
                category: "Electronics",
                price: 699.99,
                isAvailable: true,
                priceDescription: "Free shipping included",
                imageUrls: [
                  {"image1": "https://picsum.photos/800/1200?random=3"},
                  {"cover_image": "https://picsum.photos/800/1200?random=4"},
                ],
              ),
              quantity: 2,
            ),
          ],
        ),
      ];

      return dummyOrders
          .where((order) => order.user!.phone == phoneNumber)
          .toList();
    } catch (error) {
      print('Error getting order history: $error');
      throw error;
    }
  }
}
