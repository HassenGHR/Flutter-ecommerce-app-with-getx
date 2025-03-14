import 'package:day59/shared/typedef.dart';

class OfferModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final String price;
  final String discount;
  final String discountPrice;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.discount,
    required this.discountPrice,
  });

  // Factory constructor to create an instance from JSON
  factory OfferModel.fromJson(JSON json) {
    return OfferModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      price: json['price'] as String,
      discount: json['discount'] as String,
      discountPrice: json['discountPrice'] as String,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'discount': discount,
      'discountPrice': discountPrice,
    };
  }
}
