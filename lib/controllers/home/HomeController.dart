import 'package:carousel_slider/carousel_controller.dart' as carousel;
import 'package:day59/controllers/bookmark/BookMarkController.dart';
import 'package:day59/models/categories/CategoryModel.dart';
import 'package:day59/models/products/ProductModel.dart';
import 'package:day59/providers/CategoryProvider.dart';
import 'package:day59/providers/OfferProvider.dart';
import 'package:day59/providers/ProductProvider.dart';
import 'package:day59/views/bookmark/BookmarkPage.dart';
import 'package:day59/views/home/tabs/ExploreTab.dart';
import 'package:day59/views/home/tabs/UserTab.dart';
import 'package:day59/views/order/OrdersPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final OfferProvider _offerProvider;
  final BookmarkController bookmarkController;

  HomeController(this._offerProvider, this.bookmarkController);

  late PageController pageController;
  late carousel.CarouselSliderController carouselController;
  late CategoryProvider _categoryProvider = Get.find();
  late ProductProvider _productProvider = Get.find();

  var currentPage = 0.obs;
  var category = "clothing".obs;
  var searchQuery = "".obs;
  var currentBanner = 0.obs;
  var isHorizontal = false.obs;
  var activeOffers = <String>[].obs;
  var categories = <CategoryModel>[].obs;
  var oasisDeliveryProducts = <ProductModel>[].obs;

  // Loading state
  var isLoadingOffers = false.obs;
  var isLoadingCategories = false.obs;
  var isLoadingProducts = false.obs;

  void updateCategory(String cat) {
    category.value = cat;
    update();
  }

  // Setter method to update the search query
  void setSearchQuery(String query) {
    searchQuery.value = query;
    update();
  }

  List<Widget> pages = [
    ExploreTab(),
    OrdersPage(),
    BookmarksPage(),
    UserTab(),
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    carouselController = carousel.CarouselSliderController();

    getOffers();
    getCategories();
    getDiscountedProducts();
    super.onInit();
  }

  void getOffers() {
    isLoadingOffers.value = true;
    _offerProvider.getOffers().then((offers) {
      activeOffers.value = offers;
      isLoadingOffers.value = false;
    }).catchError((error) {
      isLoadingOffers.value = false;
      print("Error fetching offers: $error");
    });
  }

  void getCategories() {
    isLoadingCategories.value = true;
    _categoryProvider.getCategories().then((cats) {
      categories(cats);
      isLoadingCategories.value = false;
    }).catchError((error) {
      isLoadingCategories.value = false;
      print("Error fetching categories: $error");
    });
  }

  void getDiscountedProducts() {
    isLoadingProducts.value = true;
    _productProvider.fetchProducts().then((products) {
      oasisDeliveryProducts(products);
      isLoadingProducts.value = false;
    }).catchError((error) {
      isLoadingProducts.value = false;
      print("Error fetching products: $error");
    });
  }

  List<ProductModel> getProductsByCategoryAndSearchQuery(String category) {
    // First, filter products by category
    var filteredProducts = oasisDeliveryProducts
        .where((product) => product.category == category)
        .toList();

    // If the query is not empty, further filter by the search query
    if (searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) =>
              product.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              product.description
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filteredProducts;
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
