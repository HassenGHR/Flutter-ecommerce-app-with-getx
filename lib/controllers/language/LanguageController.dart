// File: lib/controllers/language/LanguageController.dart
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  final _storage = GetStorage();
  final String _storageKey = 'selectedLanguage';
  final RxString currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved language from storage
    String? savedLang = _storage.read(_storageKey);
    if (savedLang != null) {
      currentLanguage.value = savedLang;
    }
  }

  // Updated method signature to match the call in UserTab
  void changeLanguage(BuildContext context, String languageCode) async {
    currentLanguage.value = languageCode;
    _storage.write(_storageKey, languageCode);

    // Update the locale using EasyLocalization
    await Future.delayed(Duration(milliseconds: 300));
    if (context.mounted) {
      context.setLocale(Locale(languageCode));

      await Future.delayed(Duration(milliseconds: 100));
      Phoenix.rebirth(context);

      update();
    }

    // Or alternatively, if you don't want to use Phoenix:
    // Get.reset(); // Clear GetX dependencies
    // Get.offAll(() => YourMainApp()); // Rebuild from root
  }

  String getCurrentLanguageName() {
    switch (currentLanguage.value) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  bool isRTL() {
    return currentLanguage.value == 'ar';
  }
}
