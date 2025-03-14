import 'package:day59/controllers/cart/CartController.dart';
import 'package:day59/controllers/theme/ThemesController.dart'; // Import ThemesController
import 'package:day59/models/cart/CartModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  final ThemesController themesController = Get.find(); // Add ThemesController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themesController.theme == 'light'
          ? AppColors.lightScheme.background
          : AppColors.darkScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themesController.theme == 'light'
                ? Colors.black87
                : Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          context.tr("cart.shopping_cart"),
          style: TextStyle(
            color: themesController.theme == 'light'
                ? Colors.black87
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (cartController.cartList.isEmpty) {
                return _buildEmptyCartView(context);
              }
              return _buildCartItemsList();
            }),
          ),
          Obx(() {
            if (cartController.cartList.isNotEmpty) {
              return _buildBottomCheckoutSection(context);
            }
            return const SizedBox
                .shrink(); // Return an empty widget when the cart is empty
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyCartView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: themesController.theme == 'light'
                ? Colors.grey[300]
                : Colors.grey[600],
          ),
          const SizedBox(height: 20),
          Text(
            context.tr("cart.cart_empty"),
            style: TextStyle(
              fontSize: 20,
              color: themesController.theme == 'light'
                  ? Colors.black54
                  : Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            context.tr("cart.cart_empty_msg"),
            style: TextStyle(
              fontSize: 16,
              color: themesController.theme == 'light'
                  ? Colors.grey
                  : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: cartController.cartList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = cartController.cartList[index];
        return _buildCartItemCard(item, context);
      },
    );
  }

  Widget _buildCartItemCard(CartModel model, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themesController.theme == 'light'
            ? Colors.white
            : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: themesController.theme == 'light'
                ? Colors.grey[200]
                : Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                (model.item.imageUrls[1]
                        as Map<String, dynamic>)['cover_image'] ??
                    "https://cdn3.iconfinder.com/data/icons/it-and-ui-mixed-filled-outlines/48/default_image-1024.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          model.item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: themesController.theme == 'light'
                ? Colors.black87
                : Colors.white,
          ),
        ),
        subtitle: Text(
          "${model.item.price.toStringAsFixed(2)} ${context.tr('product_details.currency')}",
          style: TextStyle(
            color: themesController.theme == 'light'
                ? Colors.orange
                : Colors.orange.shade300,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.remove,
                size: 20,
                color: themesController.theme == 'light'
                    ? Colors.black87
                    : Colors.white,
              ),
              onPressed: () {
                if (model.quantity.value > 1) {
                  cartController.decreaseQuantity(model);
                }
              },
            ),
            Obx(
              () => Text(
                '${model.quantity.value}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: themesController.theme == 'light'
                      ? Colors.black87
                      : Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                size: 20,
                color: themesController.theme == 'light'
                    ? Colors.black87
                    : Colors.white,
              ),
              onPressed: () {
                cartController.increaseQuantity(model);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                cartController.removeFromCart(model);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCheckoutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themesController.theme == 'light'
            ? Colors.white
            : Colors.grey.shade900,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${context.tr("cart.total")} (${cartController.cartList.length} ${context.tr("cart.items")})',
                    style: TextStyle(
                      fontSize: 16,
                      color: themesController.theme == 'light'
                          ? Colors.grey[600]
                          : Colors.grey[400],
                    ),
                  ),
                  Text(
                    '${cartController.totalPrice.value} ${context.tr('product_details.currency')}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themesController.theme == 'light'
                          ? Colors.black87
                          : Colors.white,
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                cartController.clearCart();

                // Show success dialog
                Get.dialog(
                  AlertDialog(
                    title: Text(
                      context.tr('cart.order_success'),
                      style: const TextStyle(color: Colors.green),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 80,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.tr('cart.order_success_msg'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back(); // Close dialog
                          Get.toNamed('/orders'); // Navigate to orders page
                        },
                        child: Text(context.tr("cart.view_orders")),
                      ),
                      TextButton(
                        onPressed: () => Get.back(), // Just close the dialog
                        child: Text(context.tr("cart.close")),
                      ),
                    ],
                  ),
                  barrierDismissible: false,
                );
              } catch (e) {
                // Close loading dialog
                Get.back();

                // Show error snackbar
                Get.snackbar(
                  context.tr('cart.error'),
                  '${context.tr('cart.error_message')}: ${e.toString()}',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red.shade50,
                  colorText: Colors.red,
                  icon: const Icon(Icons.error_outline, color: Colors.red),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              context.tr("cart.confirm_order"),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
