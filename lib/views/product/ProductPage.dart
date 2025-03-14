import 'package:cached_network_image/cached_network_image.dart';
import 'package:day59/controllers/bookmark/BookMarkController.dart';
import 'package:day59/controllers/cart/CartController.dart';
import 'package:day59/controllers/language/LanguageController.dart';
import 'package:day59/controllers/products/ProductController.dart';
import 'package:day59/controllers/theme/ThemesController.dart'; // Import ThemesController
import 'package:day59/models/cart/CartModel.dart';
import 'package:day59/models/products/ProductModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class ProductPage extends GetView<ProductController> {
  final CartController cartController = Get.find();
  final ThemesController themesController = Get.find(); // Add ThemesController

  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['id'] == null) {
      return _isLoading();
    }

    controller.fetchProduct(Get.parameters['id']!);

    return controller.obx(
      (state) =>
          state != null ? _buildProductPage(context, state) : _isLoading(),
      onLoading: _isLoading(),
      onError: (error) => _errorWidget(error),
    );
  }

  Widget _buildProductPage(BuildContext context, ProductModel product) {
    LanguageController languageController = Get.find();
    cartController.initializeImages(
      (product.imageUrls[1] as Map<String, dynamic>)['cover_image'],
      [
        (product.imageUrls[0] as Map<String, dynamic>)['image1'] ??
            "https://via.placeholder.com/400"
      ],
    );
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: themesController.theme == 'light'
          ? AppColors.lightScheme.background
          : AppColors.darkScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: themesController.theme == 'light'
                  ? Colors.white
                  : Colors.grey.shade900,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: themesController.theme == 'light'
                  ? Colors.black
                  : Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: themesController.theme == 'light'
                ? Colors.white
                : Colors.grey.shade900,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: themesController.theme == 'light'
            ? Colors.white
            : Colors.grey.shade900,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      CartModel cartItem = cartController.addItem(product);
                      cartItem.setQuantity(
                          int.tryParse(controller.quantityController.text)!);

                      // Add item to cart
                      Get.snackbar(
                        context.tr("product_details.cart_updated"),
                        languageController.currentLanguage == 'ar'
                            ? "${context.tr("product_details.added_to_cart")} ${product.title}"
                            : "${product.title} ${context.tr("product_details.added_to_cart")}",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: themesController.theme == 'light'
                            ? Colors.green
                            : Colors.green.shade900,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: Text(context.tr("product_details.add_to_cart")),
                  ),
                ),
                const SizedBox(width: 20),
                Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: themesController.theme == 'light'
                            ? Colors.white
                            : Colors.grey.shade900,
                        border: Border.all(
                          color: themesController.theme == 'light'
                              ? AppColors.lightScheme.primary
                              : AppColors.darkScheme.primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: cartController.cartList.isNotEmpty
                          ? badges.Badge(
                              position:
                                  badges.BadgePosition.topEnd(top: -8, end: -5),
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.red,
                                padding: const EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              badgeContent: Text(
                                cartController.cartList.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Get.toNamed('/cart');
                                },
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: themesController.theme == 'light'
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                Get.toNamed('/cart');
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: themesController.theme == 'light'
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorWidget(String? error) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 20),
            Text(
              'Error Loading Product',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              error ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _isLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            themesController.theme == 'light'
                ? Colors.yellow.shade800
                : Colors.yellow.shade600,
          ),
        ),
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Obx(() => CachedNetworkImage(
                  imageUrl: cartController.mainImage.value,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          ),
        ),
        const SizedBox(height: 20),
        Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: cartController.thumbnails.map((thumbnail) {
                return SmallProductImage(
                  image: thumbnail,
                );
              }).toList(),
            )),
      ],
    );
  }
}

class SmallProductImage extends StatelessWidget {
  const SmallProductImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    ThemesController themesController = Get.find(); // Add ThemesController

    return GestureDetector(
      onTap: () => cartController.updateMainImage(image),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: themesController.theme == 'light'
              ? Colors.white
              : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: themesController.theme == 'light'
                ? AppColors.lightScheme.primary
                : AppColors.darkScheme.primary,
          ),
        ),
        child: Image.network(image),
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final ProductModel product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    BookmarkController bookmarkcontroller = Get.find();
    LanguageController languageController = Get.find();
    ThemesController themesController = Get.find(); // Add ThemesController
    ProductController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            context.tr("explore_tab.categories.${product.category}"),
            style: TextStyle(
              color: themesController.theme == 'light'
                  ? Colors.orange.shade400
                  : Colors.orange.shade300,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                product.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themesController.theme == 'light'
                      ? AppColors.lightScheme.tertiary
                      : AppColors.darkScheme.tertiary,
                ),
              ),
            ),
            Align(
              alignment: languageController.currentLanguage != 'ar'
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: 48,
                decoration: BoxDecoration(
                  color: bookmarkcontroller.bookmarks
                          .any((element) => element.id == product.id)
                      ? const Color(0xFFFFE6E6)
                      : themesController.theme == 'light'
                          ? const Color(0xFFF5F6F9)
                          : Colors.grey.shade800,
                  borderRadius: languageController.currentLanguage != 'ar'
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                ),
                child: Obx(() {
                  return SvgPicture.string(
                    heartIcon,
                    colorFilter: ColorFilter.mode(
                      bookmarkcontroller.isBookmarked(product.id)
                          ? Colors.red
                          : themesController.theme == 'light'
                              ? const Color(0xFFDBDEE4)
                              : Colors.grey.shade400,
                      BlendMode.srcIn,
                    ),
                    height: 16,
                  );
                }),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Availability
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: product.isAvailable
                      ? themesController.theme == 'light'
                          ? Colors.green.shade100
                          : Colors.green.shade900
                      : themesController.theme == 'light'
                          ? Colors.red.shade100
                          : Colors.red.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      product.isAvailable ? Icons.check_circle : Icons.cancel,
                      color: product.isAvailable ? Colors.green : Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      product.isAvailable
                          ? context.tr("product_details.available")
                          : context.tr("product_details.out_of_stock"),
                      style: TextStyle(
                        color: product.isAvailable
                            ? themesController.theme == 'light'
                                ? Colors.green.shade800
                                : Colors.green.shade300
                            : themesController.theme == 'light'
                                ? Colors.red.shade800
                                : Colors.red.shade300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Price and Bookmark
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "${product.price.toString()} ${context.tr('product_details.currency')}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themesController.theme == 'light'
                      ? AppColors.saleLight
                      : AppColors.saleDark,
                ),
              ),
            ),
            // Quantity Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 40,
                decoration: BoxDecoration(
                  color: themesController.theme == 'light'
                      ? Colors.white
                      : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 4), // Subtle elevation
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIconButton(
                      icon: Icons.remove,
                      onPressed: controller.decrement,
                      backgroundColor: themesController.theme == 'light'
                          ? Colors.grey.shade100
                          : Colors.grey.shade800,
                      iconColor: themesController.theme == 'light'
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: controller.quantityController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 12),
                          border: InputBorder.none,
                          hintText: '1',
                          hintStyle: TextStyle(
                            color: themesController.theme == 'light'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: themesController.theme == 'light'
                              ? Colors.black
                              : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildIconButton(
                        icon: Icons.add,
                        onPressed: controller.increment,
                        backgroundColor: themesController.theme == 'light'
                            ? AppColors.lightScheme.primary.withOpacity(0.3)
                            : AppColors.darkScheme.primary.withOpacity(0.3),
                        iconColor: themesController.theme == 'light'
                            ? AppColors.lightScheme.primary.withOpacity(0.9)
                            : AppColors.darkScheme.primary.withOpacity(0.9)),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            product.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: themesController.theme == 'light'
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
            ),
          ),
        ),

        const SizedBox(height: 70),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2), // Subtle hover effect
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor ?? Colors.black,
          size: 20,
        ),
      ),
    );
  }
}

const starIcon =
    '''<svg width="13" height="12" viewBox="0 0 13 12" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M12.7201 5.50474C12.9813 5.23322 13.0659 4.86077 12.9476 4.50957C12.8292 4.15777 12.5325 3.90514 12.156 3.83313L9.12773 3.25704C9.03883 3.23992 8.96219 3.18621 8.91743 3.11007L7.41279 0.515295C7.22517 0.192424 6.88365 0 6.49983 0C6.116 0 5.7751 0.192424 5.58748 0.515295L4.08284 3.11007C4.03808 3.18621 3.96144 3.23992 3.87192 3.25704L0.844252 3.83313C0.467173 3.90514 0.171028 4.15777 0.0526921 4.50957C-0.0662565 4.86077 0.0189695 5.23322 0.280166 5.50474L2.37832 7.68397C2.43963 7.74831 2.46907 7.83508 2.45803 7.92185L2.09199 10.8725C2.04661 11.2397 2.20419 11.5891 2.51566 11.8063C2.6996 11.935 2.91236 11.9999 3.12696 11.9999C3.27595 11.9999 3.42617 11.9687 3.56842 11.9055L6.36984 10.6577C6.45262 10.6211 6.54704 10.6211 6.62981 10.6577L9.43185 11.9055C9.7795 12.0601 10.1725 12.0235 10.484 11.8063C10.7955 11.5891 10.9537 11.2397 10.9083 10.8725L10.5416 7.92244C10.5306 7.83508 10.56 7.74831 10.6226 7.68397L12.7201 5.50474Z" fill="#FFC416"/>
</svg>
''';

const heartIcon =
    '''<svg width="18" height="16" viewBox="0 0 18 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5266 8.61383L9.27142 15.8877C9.12207 16.0374 8.87889 16.0374 8.72858 15.8877L1.47343 8.61383C0.523696 7.66069 0 6.39366 0 5.04505C0 3.69644 0.523696 2.42942 1.47343 1.47627C2.45572 0.492411 3.74438 0 5.03399 0C6.3236 0 7.61225 0.492411 8.59454 1.47627C8.81857 1.70088 9.18143 1.70088 9.40641 1.47627C11.3691 -0.491451 14.5629 -0.491451 16.5266 1.47627C17.4763 2.42846 18 3.69548 18 5.04505C18 6.39366 17.4763 7.66165 16.5266 8.61383Z" fill="#DBDEE4"/>
</svg>
''';
