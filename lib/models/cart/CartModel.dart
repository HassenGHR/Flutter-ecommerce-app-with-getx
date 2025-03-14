import 'package:day59/models/products/ProductModel.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CartModel {
  final ProductModel item; // Holds product details
  RxInt quantity; // Quantity of this product in the cart

  CartModel({
    required this.item,
    int quantity = 1, // Default quantity is 1
  }) : quantity = quantity.obs;

  // Method to increase quantity
  void increaseQuantity() {
    quantity++;
  }

  // Setter for explicitly setting the quantity
  void setQuantity(int newQuantity) {
    if (newQuantity >= 0) {
      quantity = newQuantity.obs;
    }
  }

  // Method to decrease quantity
  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  // Convert to JSON (optional, for storage or API handling)
  Map<String, dynamic> toJson() {
    return {
      'item': item.toMap(), // Assuming ProductModel has a `toJson` method
      'quantity': quantity.value,
    };
  }

  // Create a CartModel from JSON (optional)
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      item: ProductModel.fromMap(json['item']),
      quantity: json['quantity'] ?? 1,
    );
  }
}
