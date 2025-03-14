import 'package:day59/models/products/ProductModel.dart';
import 'package:day59/repositories/ProductRepository.dart';

class ProductProvider {
  final ProductRepository _productRepository;

  ProductProvider(this._productRepository);

  Future<List<ProductModel>> fetchProducts() async {
    try {
      var products = await _productRepository.getDiscountedProducts();

      // Ensure proper type conversion
      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return []; // Return an empty list in case of an error
    }
  }
}
