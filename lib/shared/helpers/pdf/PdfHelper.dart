import 'dart:io';
import 'package:day59/controllers/order/OrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewerPage extends StatelessWidget {
  final File file;
  final OrderController orderController = Get.put(OrderController());

  PdfViewerPage({required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('وصل التسليم'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SfPdfViewer.file(file),
      floatingActionButton: _buildFloatingContainer(),
    );
  }

  Widget _buildFloatingContainer() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        _showOptions();
      },
      child: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
    );
  }

  void _showOptions() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.save),
                title: const Text('حفظ إلى الجهاز'),
                onTap: () async {
                  try {
                    Get.back();
                    await orderController.saveDocument(
                      name: '${DateTime.now()}-OasisDelivery.pdf',
                      pdf: pw.Document(), // Replace with your actual document
                    );
                    orderController.showToast(
                        'تم حفظ ملف الوصل بنجاح', Colors.green);
                  } catch (e) {
                    orderController.showToast('حدث خطأ: $e', Colors.red);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('مشاركة'),
                onTap: () async {
                  Get.back();
                  await Share.shareXFiles(
                    [XFile(file.path)],
                    sharePositionOrigin: Rect.fromCircle(
                      radius: Get.width * 0.25,
                      center: const Offset(0, 0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
