import 'package:day59/controllers/bookmark/BookMarkController.dart';
import 'package:day59/controllers/theme/ThemesController.dart'; // Import ThemesController
import 'package:day59/models/bookmark/BookmarkModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BookmarksPage extends StatelessWidget {
  BookmarksPage({super.key});
  final BookmarkController bookmarkController = Get.find();
  final ThemesController themesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themesController.theme == 'light'
          ? AppColors.lightScheme.background
          : AppColors.darkScheme.background,
      appBar: AppBar(
        title: Text(
          context.tr("bookmarks.bookmarks"),
          style: TextStyle(
            color: themesController.theme == 'light'
                ? AppColors.lightScheme.onSurface
                : AppColors.darkScheme.onSurface,
          ),
        ),
        backgroundColor: themesController.theme == 'light'
            ? Colors.white
            : Colors.grey.shade900,
        elevation: 0,
        iconTheme: IconThemeData(
          color:
              themesController.theme == 'light' ? Colors.black : Colors.white,
        ),
      ),
      body: Obx(() {
        final bookmarks = bookmarkController.bookmarks;

        if (bookmarks.isEmpty) {
          return _buildEmptyState(context);
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: bookmarks.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) => ProductCard(
                product: bookmarks[index],
                onPress: () {
                  Get.toNamed('/product/${bookmarks[index].id}');
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: themesController.theme == 'light'
                ? Colors.grey[400]
                : Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            context.tr("bookmarks.no_bookmarks"),
            style: TextStyle(
              fontSize: 18,
              color: themesController.theme == 'light'
                  ? Colors.grey[600]
                  : Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr("bookmarks.no_bookmarks_message"),
            style: TextStyle(
              fontSize: 14,
              color: themesController.theme == 'light'
                  ? Colors.grey[500]
                  : Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final BookmarkModel product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final BookmarkController bookmarkController = Get.find();
    final ThemesController themesController =
        Get.find(); // Add ThemesController

    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themesController.theme == 'light'
                      ? const Color(0xFF979797).withOpacity(0.1)
                      : Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(product.imageUrl),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: TextStyle(
                color: themesController.theme == 'light'
                    ? AppColors.lightScheme.onSurface
                    : AppColors.darkScheme.onSurface,
              ),
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.price} ${context.tr('product_details.currency')}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: themesController.theme == 'light'
                        ? const Color(0xFFFF7643)
                        : const Color(0xFFFF7643).withOpacity(0.8),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    bookmarkController.removeBookmark(product.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: bookmarkController.isBookmarked(product.id)
                          ? const Color(0xFFFF7643).withOpacity(0.15)
                          : themesController.theme == 'light'
                              ? const Color(0xFF979797).withOpacity(0.1)
                              : Colors.grey.shade700,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.string(
                      heartIcon,
                      colorFilter: ColorFilter.mode(
                        bookmarkController.isBookmarked(product.id)
                            ? const Color(0xFFFF4848)
                            : themesController.theme == 'light'
                                ? const Color(0xFFDBDEE4)
                                : Colors.grey.shade400,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const heartIcon =
    '''<svg width="18" height="16" viewBox="0 0 18 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5266 8.61383L9.27142 15.8877C9.12207 16.0374 8.87889 16.0374 8.72858 15.8877L1.47343 8.61383C0.523696 7.66069 0 6.39366 0 5.04505C0 3.69644 0.523696 2.42942 1.47343 1.47627C2.45572 0.492411 3.74438 0 5.03399 0C6.3236 0 7.61225 0.492411 8.59454 1.47627C8.81857 1.70088 9.18143 1.70088 9.40641 1.47627C11.3691 -0.491451 14.5629 -0.491451 16.5266 1.47627C17.4763 2.42846 18 3.69548 18 5.04505C18 6.39366 17.4763 7.66165 16.5266 8.61383Z" fill="#DBDEE4"/>
</svg>
''';
