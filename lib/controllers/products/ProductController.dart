import 'package:day59/providers/ProductProvider.dart';
import 'package:day59/repositories/ProductRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController with StateMixin {
  // final ProductProvider _productProvider;
  final ProductRepository _repository;

  ProductController(this._repository);

  final TextEditingController quantityController = TextEditingController();

  var count = 1.obs;

  @override
  void onInit() {
    quantityController.text = count.value.toString();

    super.onInit();
  }

  void fetchProduct(String id) {
    change(null, status: RxStatus.loading());

    _repository.getProductById(id).then((product) {
      change(product, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void increment() {
    count.value++;

    quantityController.text = count.value.toString();
  }

  void decrement() {
    if (count.value == 1) return;
    count.value--;

    quantityController.text = count.value.toString();
  }
}
