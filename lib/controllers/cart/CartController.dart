import 'package:day59/models/products/ProductModel.dart';
import 'package:day59/models/cart/CartModel.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get to => Get.find(); // Singleton access

  // RxList to hold cart items as CartModel
  var cartList = <CartModel>[].obs;

  // Rx variable for total price of the entire cart
  var totalPrice = 0.0.obs;

  var totalItemPrice = 0.0.obs;

  // For managing product images
  RxString mainImage = ''.obs;
  RxSet<String> thumbnails = <String>{}.obs;

  // Method to add an item to the cart
  CartModel addItem(ProductModel product) {
    // Check if the product already exists in the cart
    var existingItem =
        cartList.firstWhereOrNull((item) => item.item.id == product.id);

    if (existingItem != null) {
      existingItem
          .increaseQuantity(); // Increase quantity if the product exists
      updateCart(); // Recalculate the total price
      return existingItem; // Return the updated cart item
    } else {
      var newCartItem = CartModel(item: product); // Create a new cart item
      cartList.add(newCartItem); // Add the new item to the cart
      updateCart(); // Recalculate the total price
      return newCartItem; // Return the newly added cart item
    }
  }

  void calculateTotalPrice(CartModel item) {
    totalItemPrice(item.item.price * item.quantity.value);
    update();
  }

  void increaseQuantity(CartModel cartItem) {
    cartItem.quantity.value++;
    updateCart(); // Update the overall cart if needed
  }

  void decreaseQuantity(CartModel cartItem) {
    if (cartItem.quantity.value > 1) {
      cartItem.quantity.value--;
      calculateTotalPrice(cartItem);
      updateCart();
    }
  }

  // Method to remove an item from the cart
  void removeFromCart(CartModel cartItem) {
    cartList.remove(cartItem);
    updateCart();
  }

  // Method to update total price for the entire cart
  void updateCart() {
    totalPrice.value = cartList.fold(0.0, (sum, item) {
      calculateTotalPrice(item);
      return sum + totalItemPrice.value;
    });
  }

  void clearCart() {
    cartList.clear(); // This clears the list
    update();
  }

  // Method to initialize main image and thumbnails
  void initializeImages(String? initialImage, List<String>? initialThumbnails) {
    mainImage.value = initialImage ?? '';
    thumbnails.clear();
    if (initialThumbnails != null) {
      thumbnails.addAll(initialThumbnails.toSet());
    }
  }

  // Method to update the main image
  void updateMainImage(String newImage) {
    if (mainImage.value.isNotEmpty && !thumbnails.contains(mainImage.value)) {
      thumbnails.add(mainImage.value);
    }
    thumbnails.remove(newImage);
    mainImage.value = newImage;
  }

  @override
  void onInit() {
    super.onInit();
    updateCart(); // Recalculate total price on initialization
  }
}
