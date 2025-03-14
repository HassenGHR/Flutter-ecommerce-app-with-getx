import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeController.currentTheme,
          home: HomeScreen(),
        ));
  }
}

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  // Toggle theme mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  // Get the current theme data
  ThemeData get currentTheme => isDarkMode.value ? darkTheme : lightTheme;

  // Light Theme
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: ColorScheme.light().secondary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: lightElevatedButtonStyle,
        ),
      );

  // Dark Theme
  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: ColorScheme.dark().primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: darkElevatedButtonStyle,
        ),
      );

  // Light ElevatedButton style
  ButtonStyle get lightElevatedButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: ColorScheme.light().error,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
      );

  // Dark ElevatedButton style
  ButtonStyle get darkElevatedButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: ColorScheme.dark().primary,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
      );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        builder: (themeController) => Scaffold(
              appBar: AppBar(
                title: Text('ElevatedButton Theme with GetX'),
                actions: [
                  IconButton(
                    icon: Icon(themeController.isDarkMode.value
                        ? Icons.light_mode
                        : Icons.dark_mode),
                    onPressed: themeController.toggleTheme,
                  ),
                ],
              ),
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Button Pressed',
                      'You pressed the button!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Text('Press Me'),
                ),
              ),
            ));
  }
}
