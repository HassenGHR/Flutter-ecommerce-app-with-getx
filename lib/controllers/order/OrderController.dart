import 'dart:io';

import 'package:day59/models/order/OrderModel.dart';
import 'package:day59/providers/OrderProvider.dart';
import 'package:day59/shared/helpers/pdf/PdfHelper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class OrderController extends GetxController {
  final OrderProvider _orderProvider = Get.find<OrderProvider>();

  // Reactive states from the provider
  RxBool get isSubmitting => _orderProvider.submitting;
  var orderList = <OrderModel>[].obs;
  var isExpandidng = false.obs;
  RxBool get isLoading => _orderProvider.isLoading;
  RxBool get hasMore => _orderProvider.hasMore;

  // Fetch paginated order history
  Future<void> fetchOrderHistory(String phoneNumber) async {
    _orderProvider.fetchOrderHistory(phoneNumber).then((orders) {
      orderList(orders);
      update();
    });
  }

  void expandOrdersList() {
    isExpandidng.value = true;
    update();
  }

  // Reset order history
  void resetOrderHistory() {
    _orderProvider.resetOrderHistory();
  }

  // Private helper to send notifications
  void _sendOrderNotification(String orderId) {
    print("Order notification sent for Order ID: $orderId");
    // Additional notification logic here
  }

  // Private helper to generate an order ID
  String _generateOrderId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> requestPermissions() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      print('Storage permission is not granted.');
    }
  }

  Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    // Request storage permission
    await requestPermissions();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    Directory? appDocumentsDir;
    if (Platform.isAndroid) {
      if (androidInfo.version.sdkInt >= 30) {
        appDocumentsDir = await getDownloadsDirectory();
      } else {
        appDocumentsDir = await getExternalStorageDirectory();
      }
    }
    final file = File('${appDocumentsDir!.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  void openPdfViewer(File file) {
    Get.to(() => PdfViewerPage(file: file));
  }

  void showToast(String message, Color backgroundColor) {
    Get.snackbar(
      '',
      message,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
