import 'package:day59/models/cart/CartModel.dart';
import 'package:day59/models/order/OrderModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final bool isExpanded;
  final VoidCallback? onTap;

  const OrderCard({
    Key? key,
    required this.order,
    this.isExpanded = false,
    this.onTap,
  }) : super(key: key);

  double calculateTotalPrice(CartModel item) {
    return item.item.price * item.quantity.value;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Compact Order ID and Date
                Expanded(
                  child: Text(
                    '#${(order.id != null && order.id!.length >= 6) ? order.id!.substring(0, 6) : 'N/A'}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  order.date?.substring(0, 10) ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Order Items
            _buildOrderItems(context),

            // Total Price
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '${order.totalPrice?.toStringAsFixed(2) ?? '0.00'} ${context.tr('explore_tab.currency')}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItems(BuildContext context) {
    // If no items, return empty container
    if (order.items == null || order.items!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Limit to 3 items when not expanded
    final displayItems =
        isExpanded ? order.items! : order.items!.take(3).toList();

    return Column(
      children: [
        ...displayItems
            .map((cartItem) => _buildOrderItemRow(context, cartItem)),

        // Show more indicator if there are more items
        if (!isExpanded && order.items!.length > 3)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                '+${order.items!.length - 3} more items',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOrderItemRow(BuildContext context, CartModel cartItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Product Image (Placeholder)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(cartItem.item.imageUrls[1]['cover_image']!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.item.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Qty: ${cartItem.quantity.value}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Item Total Price
          Text(
            '${(calculateTotalPrice(cartItem)).toStringAsFixed(2)} ${context.tr('explore_tab.currency')}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
