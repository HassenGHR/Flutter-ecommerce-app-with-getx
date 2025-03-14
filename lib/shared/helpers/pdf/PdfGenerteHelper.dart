import 'dart:io';
import 'package:day59/controllers/order/OrderController.dart';
import 'package:day59/models/invoice/CustomerModel.dart';
import 'package:day59/models/invoice/InvoiceModel.dart';
import 'package:day59/models/invoice/SupplierModel.dart';
import 'package:day59/shared/widgets/CommonWidgets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

Future<pw.ImageProvider> loadLogoImage() async {
  final ByteData data = await rootBundle
      .load('assets/images/logo.png'); // Replace with your logo path
  final Uint8List bytes = data.buffer.asUint8List();
  return pw.MemoryImage(bytes);
}

class PdfInvoicePdfHelper {
  static Future<File> generate(Invoice invoice) async {
    final OrderController orderController = Get.put(OrderController());

    final pdf = Document();
    final arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));
    final logoImage = await loadLogoImage();

    pdf.addPage(MultiPage(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      textDirection: pw.TextDirection.rtl, // Ensure RTL text direction

      build: (context) => [
        buildHeader(invoice, arabicFont, logoImage),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice, arabicFont),
        buildInvoice(invoice, arabicFont),
        Divider(),
        buildTotal(invoice, arabicFont),
      ],
      footer: (context) => buildFooter(invoice, arabicFont),
    ));

    return orderController.saveDocument(
        name: '${DateTime.now()}-OasisDelivery.pdf', pdf: pdf);
  }

  static Widget buildHeader(
          Invoice invoice, Font arabicFont, pw.ImageProvider logoImage) =>
      Column(
        children: [
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: logoImage, // Replace with your logo path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Oasis Delivery',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Supplier and Customer addresses in one column

              // Circular logo and Invoice Info in another column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 0.5 *
                          PdfPageFormat.cm), // Space between logo and info
                  buildInvoiceInfo(invoice.info, arabicFont),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildSupplierAddress(invoice.supplier, arabicFont),
                  SizedBox(
                      height: 0.2 *
                          PdfPageFormat
                              .cm), // Space between supplier and customer
                  buildCustomerAddress(invoice.customer, arabicFont),
                ],
              ),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer, Font arabicFont) {
    // Truncate the address to a maximum of 20 characters
    final truncatedAddress = customer.address.length > 30
        ? customer.address.substring(0, 30) + '...'
        : customer.address;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(customer.name,
            style: TextStyle(fontWeight: FontWeight.bold, font: arabicFont)),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(customer.phone, style: TextStyle(font: arabicFont)),
        Text(truncatedAddress, style: TextStyle(font: arabicFont)),
      ],
    );
  }

  static Widget buildInvoiceInfo(InvoiceInfo info, Font arabicFont) {
    final titles = <String>[
      'رقم الوصل:',
      'تاريخ الوصل:',
    ];
    final data = <String>[
      info.number,
      CommonWidgets.formatDate(info.date),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(
            title: title, value: value, width: 200, arabicFont: arabicFont);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier, Font arabicFont) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Oasis Delivery",
              style: TextStyle(fontWeight: FontWeight.bold, font: arabicFont)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.phone, style: TextStyle(font: arabicFont)),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // Text(supplier.address, style: TextStyle(font: arabicFont)),
        ],
      );

  static Widget buildTitle(Invoice invoice, Font arabicFont) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'وصل التسليم',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              font: arabicFont,
            ),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description, style: TextStyle(font: arabicFont)),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice, Font arabicFont) {
    final headers = ['المجموع', 'سعر الوحدة', 'الكمية', 'النوع', 'الوصف'];
    final data = invoice.items.map((item) {
      final total = item.item.price * item.quantity.value;

      return [
        '${total.toStringAsFixed(2)} \دج',
        '${item.item.price} \دج',
        '${item.quantity}',
        item.item.category,
        item.item.title,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(
        fontWeight: FontWeight.bold,
        font: arabicFont,
      ),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerRight,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
      cellStyle: TextStyle(
        font: arabicFont,
      ),
    );
  }

  static Widget buildTotal(Invoice invoice, Font arabicFont) {
    final netTotal = invoice.items
        .map((item) => item.item.price * item.quantity.value)
        .reduce((item1, item2) => item1 + item2);
    // final total = netTotal;
    final qteTotal = invoice.items
        .map((item) => item.quantity)
        .reduce((qte1, qte2) => qte1 + qte2.value);

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'الكمية الإحمالية ',
                  value: qteTotal.toString(),
                  unite: true,
                  arabicFont: arabicFont,
                ),

                buildText(
                  title: 'المبلغ الإجمالي',
                  value: CommonWidgets.formatPrice(netTotal),
                  unite: true,
                  arabicFont: arabicFont,
                ),
                // buildText(
                //   title: 'المبلغ الإجمالي المستحق',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     font: arabicFont,
                //   ),
                //   value: Utils.formatPrice(total),
                //   unite: true,
                //   arabicFont: arabicFont,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice, Font arabicFont) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text(
            'شكرا لتعاملك معنا!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              font: arabicFont,
            ),
          ),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
    required Font arabicFont,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold, font: arabicFont);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value, style: TextStyle(font: arabicFont)),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    required Font arabicFont,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ??
        TextStyle(
          fontWeight: FontWeight.bold,
          font: arabicFont,
        );

    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: style, textAlign: TextAlign.right),
          SizedBox(width: 2 * PdfPageFormat.mm),
          Expanded(
            child: Text(value,
                style: unite ? style : null, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
