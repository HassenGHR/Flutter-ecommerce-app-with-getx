import 'package:get/get.dart';
import 'package:day59/models/bookmark/BookmarkModel.dart';
import 'package:day59/models/products/ProductModel.dart';

class BookmarkController extends GetxController {
  final RxList<BookmarkModel> _bookmarks = <BookmarkModel>[].obs;

  // Getter for bookmarks list
  List<BookmarkModel> get bookmarks => _bookmarks;

  // Add a bookmark
  void addBookmark(ProductModel product) {
    // Check if the product is already bookmarked
    if (!_bookmarks.any((item) => item.id == product.id)) {
      // Safely access the image URL (fallback to a default or first image if needed)
      String imageUrl = product.imageUrls.isNotEmpty &&
              product.imageUrls.length > 1
          ? product.imageUrls[1]['cover_image'] ?? ''
          : product.imageUrls.isNotEmpty
              ? product.imageUrls[0]['cover_image'] ?? ''
              : 'assets/images/default_image.png'; // Fallback to a default image

      // Create a BookmarkModel instance
      BookmarkModel productBooked = BookmarkModel(
        id: product.id,
        name: product.title,
        imageUrl: imageUrl,
        price: product.price,
      );

      // Add the product to bookmarks
      _bookmarks.add(productBooked);
    } else {
      print('Product is already bookmarked.');
    }
  }

  // Remove a bookmark
  void removeBookmark(String productId) {
    _bookmarks.removeWhere((item) => item.id == productId);
  }

  // Toggle bookmark
  void toggleBookmark(ProductModel product) {
    if (isBookmarked(product.id)) {
      removeBookmark(product.id);
    } else {
      addBookmark(product);
    }
  }

  // Check if a product is bookmarked
  bool isBookmarked(String productId) {
    return _bookmarks.any((item) => item.id == productId);
  }
}
