import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:day59/controllers/bookmark/BookMarkController.dart';
import 'package:day59/controllers/cart/CartController.dart';
import 'package:day59/controllers/home/HomeController.dart';
import 'package:day59/controllers/theme/ThemesController.dart'; // Import ThemesController
import 'package:day59/models/categories/CategoryModel.dart';
import 'package:day59/shared/widgets/HomePageSkeleton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ExploreTab extends GetView<HomeController> {
  ExploreTab({Key? key}) : super(key: key);
  final CartController cartController = Get.find();
  final ThemesController themesController = Get.find(); // Add ThemesController
  final BookmarkController bookmarkcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();

    return Obx(() => SafeArea(
          child: (controller.isLoadingCategories.value ||
                  controller.isLoadingOffers.value ||
                  controller.isLoadingProducts.value)
              ? ExploreTabSkeletonLoader()
              : Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        floating: false,
                        pinned: true,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        // Disable color transitions
                        scrolledUnderElevation: 0,
                        // Prevent foreground color changes
                        foregroundColor:
                            Theme.of(context).textTheme.bodyLarge?.color,
                        // Disable all default animations
                        forceMaterialTransparency: false,
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(child: SearchField()),
                              const SizedBox(width: 16),
                              IconBtnWithCounter(
                                numOfitem: cartController.cartList.length,
                                svgSrc: cartIcon,
                                press: () {
                                  Get.toNamed('/cart');
                                },
                              ),
                              const SizedBox(width: 8),
                              IconBtnWithCounter(
                                svgSrc: bellIcon,
                                numOfitem: 3,
                                press: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          _buildOfferCarousel(context),
                          _buildOfferIndicator(),
                          const SizedBox(height: 16),
                          _buildCategories(context),
                          const SizedBox(height: 16),
                          _buildSection(context.tr('explore_tab.products')),
                          const SizedBox(height: 8),
                          _buildDiscountedProducts(
                              controller.category.value, context),
                        ]),
                      ),
                    ],
                  ),
                ),
        ));
  }

  // Build Offer Carousel
  Widget _buildOfferCarousel(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Obx(() {
        if (controller.activeOffers.isEmpty) {
          return Center(
            child: Text(
              context.tr('explore_tab.no_offers_available'),
              style: TextStyle(
                fontSize: 16,
                color: themesController.theme == 'light'
                    ? AppColors.lightScheme.tertiary
                    : AppColors.darkScheme.tertiary,
              ),
            ),
          );
        }
        return CarouselSlider.builder(
          carouselController: controller.carouselController,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 1,
            initialPage: 0,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) => controller.changeBanner(index),
          ),
          itemCount: controller.activeOffers.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  _buildOffer(controller.activeOffers[itemIndex]),
        );
      }),
    );
  }

  // Build Offer
  Widget _buildOffer(String offer) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: themesController.theme == 'light'
            ? AppColors.lightScheme.surface
            : AppColors.darkScheme.surface,
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            imageUrl: offer,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  // Build Offer Indicator
  Widget _buildOfferIndicator() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.activeOffers.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (themesController.theme == 'light'
                        ? AppColors.lightScheme.primary
                        : AppColors.darkScheme.primary)
                    .withOpacity(
                        controller.currentBanner == entry.key ? 0.9 : 0.2),
              ),
            );
          }).toList(),
        ));
  }

  // Build Categories Section
  Widget _buildCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.tr('explore_tab.top_categories'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: themesController.theme == 'light'
                  ? AppColors.newTagLight
                  : AppColors.newTagDark,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return _buildCategory(
                  controller.categories[index], index, context);
            },
          ),
        ),
      ],
    );
  }

  // Build Category Card
  Widget _buildCategory(
      CategoryModel category, int index, BuildContext context) {
    return ZoomTapAnimation(
      beginDuration: const Duration(milliseconds: 300),
      endDuration: const Duration(milliseconds: 500),
      child: Obx(
        () => GestureDetector(
          onTap: () {
            controller.updateCategory(category.name);
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Consistent border radius
              border: Border.all(
                color: controller.category.value == category.name
                    ? themesController.theme == 'light'
                        ? AppColors.lightScheme.primaryContainer
                        : AppColors.darkScheme.primaryContainer
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: controller.category.value == category.name
                  ? [
                      BoxShadow(
                        color: (themesController.theme == 'light'
                                ? AppColors.lightScheme.primary
                                : AppColors.darkScheme.primary)
                            .withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            margin: EdgeInsets.only(
                right: controller.categories.length - 1 == index ? 0 : 8),
            child: Stack(
              children: [
                // Category image
                Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10), // Consistent border radius
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10), // Consistent border radius
                    child: Image.asset(
                      category.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image,
                            size: 40, color: Colors.grey);
                      },
                    ),
                  ),
                ),
                // Overlay for text and styling
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(110),
                      borderRadius:
                          BorderRadius.circular(10), // Consistent border radius
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Category name
                          Text(
                              context.tr(
                                  "explore_tab.categories.${category.name[0].toLowerCase()}${category.name.substring(1)}"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.darkScheme.onSurface,
                              )),
                          // Optional bottom indicator
                          if (controller.category.value == category.name)
                            Container(
                                margin: const EdgeInsets.only(top: 4),
                                height: 3,
                                width: 60,
                                color: AppColors.darkScheme.primary),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Section Title
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: themesController.theme == 'light'
                  ? AppColors.lightScheme.tertiary
                  : AppColors.darkScheme.tertiary,
            ),
          ),
          Obx(() => IconButton(
                onPressed: () {
                  controller.isHorizontal.toggle();
                },
                icon: Icon(
                    size: 30,
                    controller.isHorizontal.value
                        ? Icons.grid_view_rounded
                        : Icons.list,
                    color: themesController.theme == 'light'
                        ? AppColors.lightScheme.onSurface
                        : AppColors.darkScheme.onSurface),
              )),
        ],
      ),
    );
  }

  // Build Discounted Products
  Widget _buildDiscountedProducts(String category, BuildContext context) {
    return Obx(() => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: controller.isHorizontal.value
              ? _buildHorizontalDiscounts(category, context)
              : _buildVerticalDiscounts(category, context),
        ));
  }

  // Build Horizontal Discounts
  Widget _buildHorizontalDiscounts(String category, BuildContext context) {
    var products = controller.getProductsByCategoryAndSearchQuery(category);

    if (products.isEmpty) {
      return SizedBox(
        height: 290,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_basket_outlined,
                size: 80,
                color: themesController.theme == 'light'
                    ? AppColors.newTagLight
                    : AppColors.newTagDark,
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('explore_tab.no_products_yet'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themesController.theme == 'light'
                      ? AppColors.newTagLight
                      : AppColors.newTagDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.tr('explore_tab.no_products_message'),
                style: TextStyle(
                  fontSize: 14,
                  color: themesController.theme == 'light'
                      ? AppColors.lightScheme.onSecondary
                      : AppColors.darkScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 290,
      child: ListView.builder(
        key: ValueKey('horizontal_$category'),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 5, right: 5),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 200,
            child: _buildDiscountCard(index, category, context),
          );
        },
      ),
    );
  }

  // Build Vertical Discounts
  Widget _buildVerticalDiscounts(String category, BuildContext context) {
    var products = controller.getProductsByCategoryAndSearchQuery(category);
    if (products.isEmpty) {
      return SizedBox(
        height: 290,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_basket_outlined,
                size: 80,
                color: themesController.theme == 'light'
                    ? AppColors.lightScheme.tertiary
                    : AppColors.darkScheme.tertiary,
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('explore_tab.no_products_yet'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themesController.theme == 'light'
                      ? AppColors.lightScheme.onTertiaryContainer
                      : AppColors.darkScheme.onTertiaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.tr('explore_tab.no_products_message'),
                style: TextStyle(
                  fontSize: 14,
                  color: themesController.theme == 'light'
                      ? AppColors.lightScheme.onSurface
                      : AppColors.darkScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    }
    return GridView.builder(
      key: const ValueKey('vertical'),
      padding: const EdgeInsets.only(left: 5, right: 5),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildDiscountCard(index, category, context);
      },
    );
  }

  // Build Discount Card
  Widget _buildDiscountCard(int index, String category, BuildContext context) {
    var products = controller.getProductsByCategoryAndSearchQuery(category);
    final product = products[index];

    return GestureDetector(
      onTap: () {
        Get.toNamed('/product/${product.id}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: themesController.theme == 'light'
              ? AppColors.lightScheme.surface
              : AppColors.darkScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: themesController.theme == 'light'
                ? AppColors.lightScheme.outline
                : AppColors.darkScheme.outline,
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    (product.imageUrls[1]
                            as Map<String, dynamic>)['cover_image'] ??
                        "https://cdn3.iconfinder.com/data/icons/it-and-ui-mixed-filled-outlines/48/default_image-1024.png",
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Product Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          product.title,
                          style: TextStyle(
                            color: themesController.theme == 'light'
                                ? AppColors.lightScheme.onSurface
                                : AppColors.darkScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Product Brand
                        Text(
                            context.tr(
                                "explore_tab.categories.${product.category[0].toLowerCase()}${product.category.substring(1)}"),
                            style: TextStyle(
                              color: themesController.theme == 'light'
                                  ? AppColors.lightScheme.onSurface
                                  : AppColors.darkScheme.onSurface,
                            )),
                        // Product Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${product.price.toString()} ${context.tr('explore_tab.currency')}",
                                style: TextStyle(
                                  color: themesController.theme == 'light'
                                      ? AppColors.saleLight
                                      : AppColors.saleDark,
                                )),
                            // Add to Cart Button
                            IconButton(
                              icon: const Icon(Icons.shopping_cart),
                              color: themesController.theme == 'light'
                                  ? AppColors.lightScheme.onSurface
                                  : AppColors.darkScheme.onSurface,
                              onPressed: product.isAvailable
                                  ? () {
                                      cartController.addItem(product);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                        // Availability Indicator
                        Row(
                          children: [
                            Icon(
                              product.isAvailable
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: product.isAvailable
                                  ? Colors.green
                                  : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.isAvailable
                                  ? context.tr("explore_tab.available")
                                  : context.tr("explore_tab.out_of_stock"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: product.isAvailable
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Favorite Icon
            Positioned(
              top: 0,
              left: 0,
              child: Obx(() {
                return IconButton(
                  icon: Icon(
                    bookmarkcontroller.isBookmarked(product.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: bookmarkcontroller.isBookmarked(product.id)
                        ? Colors.red
                        : themesController.theme == 'light'
                            ? AppColors.lightScheme.onPrimary
                            : AppColors.lightScheme.onPrimary,
                  ),
                  onPressed: () {
                    bookmarkcontroller.toggleBookmark(product);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SearchField()),
              const SizedBox(width: 16),
              IconBtnWithCounter(
                numOfitem: cartController.cartList.length,
                svgSrc: cartIcon,
                press: () {},
              ),
              const SizedBox(width: 8),
              IconBtnWithCounter(
                svgSrc: bellIcon,
                numOfitem: 3,
                press: () {},
              ),
            ],
          ),
        ));
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Form(
      child: TextFormField(
        onChanged: (value) {
          homeController.setSearchQuery(value);
        },
        decoration: InputDecoration(
          filled: true,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          fillColor: const Color(0xFF979797).withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          hintText: context.tr("explore_tab.search"),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF979797).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.string(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

const cartIcon =
    '''<svg width="22" height="18" viewBox="0 0 22 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M18.4524 16.6669C18.4524 17.403 17.8608 18 17.1302 18C16.3985 18 15.807 17.403 15.807 16.6669C15.807 15.9308 16.3985 15.3337 17.1302 15.3337C17.8608 15.3337 18.4524 15.9308 18.4524 16.6669ZM11.9556 16.6669C11.9556 17.403 11.3631 18 10.6324 18C9.90181 18 9.30921 17.403 9.30921 16.6669C9.30921 15.9308 9.90181 15.3337 10.6324 15.3337C11.3631 15.3337 11.9556 15.9308 11.9556 16.6669ZM20.7325 5.7508L18.9547 11.0865C18.6413 12.0275 17.7685 12.6591 16.7846 12.6591H10.512C9.53753 12.6591 8.66784 12.0369 8.34923 11.1095L6.30162 5.17154H20.3194C20.4616 5.17154 20.5903 5.23741 20.6733 5.35347C20.7563 5.47058 20.7771 5.61487 20.7325 5.7508ZM21.6831 4.62051C21.3697 4.18031 20.858 3.91682 20.3194 3.91682H5.86885L5.0002 1.40529C4.70961 0.564624 3.92087 0 3.03769 0H0.621652C0.278135 0 0 0.281266 0 0.62736C0 0.974499 0.278135 1.25472 0.621652 1.25472H3.03769C3.39158 1.25472 3.70812 1.48161 3.82435 1.8183L4.83311 4.73657C4.83622 4.74598 4.83934 4.75434 4.84245 4.76375L7.17339 11.5215C7.66531 12.9518 9.00721 13.9138 10.512 13.9138H16.7846C18.304 13.9138 19.6511 12.9383 20.1347 11.4859L21.9135 6.14917C22.0847 5.63369 21.9986 5.06175 21.6831 4.62051Z" fill="#7C7C7C"/>
</svg>
''';

const bellIcon =
    '''<svg width="15" height="20" viewBox="0 0 15 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M13.9645 15.8912C13.9645 16.1628 13.7495 16.3832 13.4844 16.3832H9.22765H9.21987H1.51477C1.2505 16.3832 1.03633 16.1628 1.03633 15.8912V10.7327C1.03633 7.08053 3.93546 4.10885 7.50043 4.10885C11.0645 4.10885 13.9645 7.08053 13.9645 10.7327V15.8912ZM7.50043 18.9381C6.77414 18.9381 6.18343 18.3327 6.18343 17.5885C6.18343 17.5398 6.18602 17.492 6.19034 17.4442H8.81052C8.81484 17.492 8.81743 17.5398 8.81743 17.5885C8.81743 18.3327 8.22586 18.9381 7.50043 18.9381ZM9.12488 3.2292C9.35805 2.89469 9.49537 2.48673 9.49537 2.04425C9.49537 0.915044 8.6024 0 7.50043 0C6.39847 0 5.5055 0.915044 5.5055 2.04425C5.5055 2.48673 5.64281 2.89469 5.87512 3.2292C2.51828 3.99204 0 7.06549 0 10.7327V15.8912C0 16.7478 0.679659 17.4442 1.51477 17.4442H5.15142C5.14883 17.492 5.1471 17.5398 5.1471 17.5885C5.1471 18.9186 6.20243 20 7.50043 20C8.79843 20 9.8529 18.9186 9.8529 17.5885C9.8529 17.5398 9.85117 17.492 9.84858 17.4442H13.4844C14.3203 17.4442 15 16.7478 15 15.8912V10.7327C15 7.06549 12.4826 3.99204 9.12488 3.2292Z" fill="#626262"/>
</svg>
''';
