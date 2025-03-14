class ProductModel {
  String id;
  String title;
  String description;
  String category;
  double price;
  bool isAvailable;
  String priceDescription;
  List<Map<String, String>> imageUrls;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.isAvailable,
    required this.priceDescription,
    required this.imageUrls,
  });

  // Factory constructor to create ProductModel from a map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      isAvailable: map['isAvailable'] ?? true,
      price: map['price']?.toDouble() ?? 0.0,
      priceDescription: map['priceDescription'] ?? '',
      imageUrls: (map['imageUrls'] as List<dynamic>? ?? [])
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );
  }

  // Convert ProductModel object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'isAvailable': isAvailable,
      'priceDescription': priceDescription,
      'imageUrls':
          imageUrls.map((urlMap) => Map<String, String>.from(urlMap)).toList(),
    };
  }
}
