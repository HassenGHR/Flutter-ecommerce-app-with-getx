import 'package:day59/services/networking/BaseProvider.dart';
import 'package:day59/shared/constants/DummyData.dart';
import 'package:day59/shared/typedef.dart';
import 'package:day59/models/products/ProductModel.dart';
import 'package:uuid/uuid.dart';

class ApiService {
  final BaseProvider _baseProvider;

  ApiService(this._baseProvider);

  Future<JSON> get<T>({
    required String endpoint,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
      if (requiresAuthToken) 'Authorization': 'Bearer <token>',
    };

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.get(
      endpoint,
      headers: customHeaders,
      query: query,
    );

    return response.body;
  }

  Future<JSON> post<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
      if (requiresAuthToken) 'Authorization': 'Bearer <token>',
    };

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.post(
      endpoint,
      body,
      headers: customHeaders,
      query: query,
    );

    return response.body;
  }

  Future<JSON> put<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
      if (requiresAuthToken) 'Authorization': 'Bearer <token>',
    };

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.put(
      endpoint,
      body,
      headers: customHeaders,
      query: query,
    );

    return response.body;
  }

  Future<JSON> delete<T>({
    required String endpoint,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
      if (requiresAuthToken) 'Authorization': 'Bearer <token>',
    };

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.delete(
      endpoint,
      headers: customHeaders,
      query: query,
    );

    return response.body;
  }

  Future<List<String>> fetchAnnounceImages() async {
    // Simulating a delay like a network call
    await Future.delayed(Duration(seconds: 1));

    // Returning dummy image URLs
    return [
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3270&q=80',
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3270&q=80',
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3270&q=80',
    ];
  }

  Future<ProductModel?> fetchProductById(String id) async {
    try {
      final productData = dummyProducts.firstWhere(
        (product) => product.id == id,
      );

      return productData;
    } catch (e) {
      print('Error fetching product by ID: $e');
    }
    return null; // Return null if not found or an error occurs
  }
}
