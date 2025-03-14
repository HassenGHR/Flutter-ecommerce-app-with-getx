import 'package:day59/models/cart/CartModel.dart';
import 'package:day59/models/invoice/CustomerModel.dart';
import 'package:day59/models/invoice/SupplierModel.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<CartModel> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
  });
}

// class InvoiceItem {
//   final String description;
//   final DateTime date;
//   final int quantity;
//   final double vat;
//   final double unitPrice;

//   const InvoiceItem({
//     required this.description,
//     required this.date,
//     required this.quantity,
//     required this.vat,
//     required this.unitPrice,
//   });
// }