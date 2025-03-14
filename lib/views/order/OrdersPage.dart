import 'package:day59/controllers/auth/AuthController.dart';
import 'package:day59/controllers/order/OrderController.dart';
import 'package:day59/controllers/theme/ThemesController.dart';
import 'package:day59/models/invoice/CustomerModel.dart';
import 'package:day59/models/invoice/InvoiceModel.dart';
import 'package:day59/models/invoice/SupplierModel.dart';
import 'package:day59/models/order/OrderModel.dart';
import 'package:day59/shared/helpers/pdf/PdfGenerteHelper.dart';
import 'package:day59/shared/widgets/OrderCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final OrderController _orderController = Get.find<OrderController>();
  final AuthController _authController = Get.find<AuthController>();

  void _loadOrderHistory() {
    final user = _authController.getUser();
    if (user != null) {
      _orderController.fetchOrderHistory(user.phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemesController themesController = Get.find<ThemesController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr("orders.order_history"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themesController.theme == 'light'
                ? AppColors.lightScheme.onSurface
                : AppColors.darkScheme.onSurface,
          ),
        ),
        backgroundColor: themesController.theme == 'light'
            ? AppColors.lightScheme.surface
            : AppColors.darkScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (_orderController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: themesController.theme == 'light'
                  ? AppColors.lightScheme.primary
                  : AppColors.darkScheme.primary,
            ),
          );
        }

        if (_orderController.orderList.isEmpty) {
          _loadOrderHistory();

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 100,
                  color: themesController.theme == 'light'
                      ? AppColors.lightScheme.onSurface.withOpacity(0.3)
                      : AppColors.darkScheme.onSurface.withOpacity(0.3),
                ),
                SizedBox(height: 20),
                Text(
                  context.tr("orders.no_orders_yet"),
                  style: TextStyle(
                    fontSize: 18,
                    color: themesController.theme == 'light'
                        ? AppColors.lightScheme.onSurface.withOpacity(0.6)
                        : AppColors.darkScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                Text(
                  context.tr("orders.start_shopping"),
                  style: TextStyle(
                    color: themesController.theme == 'light'
                        ? AppColors.lightScheme.onSurface.withOpacity(0.5)
                        : AppColors.darkScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
        }

        return Obx(() => ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _orderController.orderList.length,
              itemBuilder: (context, index) {
                final order = _orderController.orderList[index];

                return GestureDetector(
                  onTap: () async {
                    DateTime dateTime = DateTime.parse(order.date!);
                    String formattedDate =
                        DateFormat('dd MMMM yyyy').format(dateTime);

                    final invoice = Invoice(
                        supplier: const Supplier(
                            name: 'Oasis Delivery ',
                            address: 'Khemis El-Khachna, Boumerdes',
                            phone: "0697476363"),
                        customer: Customer(
                            name: order.user!.name,
                            address: order.user!.address,
                            phone: order.user!.phone),
                        info: InvoiceInfo(
                          date: dateTime,
                          description: 'First Order Invoice',
                          number: '${DateTime.now().day}${order.items!.length}',
                        ),
                        items: order.items!);

                    final pdfFile = await PdfInvoicePdfHelper.generate(invoice);

                    _orderController.openPdfViewer(
                      pdfFile,
                    );
                  },
                  child: OrderCard(
                    order: order,
                    isExpanded: _orderController.isExpandidng.value,
                    onTap: () {
                      _orderController.expandOrdersList();
                    },
                  ),
                );
              },
            ));
      }),
    );
  }
}
