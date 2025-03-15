import 'package:day59/shared/typedef.dart';
import 'package:day59/services/networking/ApiService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CategoryRepository {
  final ApiService _apiService;

  CategoryRepository(this._apiService);

  Future<List<JSON>> getCategories() async {
    // Fetch translations

    // Default categories in Arabic
    var categories = [
      {
        'id': 1,
        'name': 'Clothing', // Arabic name
        'translatedName': tr('categories.Clothing'), // Translated name
        'image': "assets/images/Clothing.jpg",
      },
      {
        'id': 2,
        'name': 'Electronics', // Arabic name
        'translatedName': tr('categories.Electronics'), // Translated name
        'image': "assets/images/Electronics.jpg",
      },
      {
        'id': 3,
        'name': 'Furniture', // Arabic name
        'translatedName': tr('categories.Furniture'), // Translated name
        'image': "assets/images/Furniture.jpg",
      },
      {
        'id': 4,
        'name': 'Kitchen', // Arabic name
        'translatedName': tr('categories.Kitchen'), // Translated name
        'image': "assets/images/Kitchen.jpg",
      },
      {
        'id': 5,
        'name': 'Wearables', // Arabic name
        'translatedName': tr('categories.Wearables'), // Translated name
        'image': "assets/images/Wearables.jpg",
      },
    ];

    return categories;
  }
}
