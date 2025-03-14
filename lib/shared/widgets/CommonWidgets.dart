import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommonWidgets {
  static formatPrice(double price) => '${price.toStringAsFixed(2)} \دج';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  static void snackBar(String type, String message) async {
    Get.snackbar(
      type,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: type == 'error' ? Colors.red : Colors.green,
      colorText: Colors.white,
      icon: Icon(
        type == 'error' ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
    );
  }

  static void showSuccessToast(String title, String message) async {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const TitleText({
    Key? key,
    required this.text,
    this.fontSize = 18,
    this.color = Colors.black, // Default color
    this.fontWeight = FontWeight.w800,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
