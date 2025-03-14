import 'package:day59/shared/typedef.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  // Factory constructor to create an instance from JSON
  factory CategoryModel.fromJson(JSON json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
