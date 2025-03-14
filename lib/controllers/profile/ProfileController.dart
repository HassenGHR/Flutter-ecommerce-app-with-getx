import 'dart:io';
import 'dart:typed_data';
import 'package:day59/controllers/auth/AuthController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final picker = ImagePicker();
  final isSaving = false.obs;
  final profileImageUrl = ''.obs;
  XFile? imageFile;

  @override
  void onInit() {
    super.onInit();
    // Load user data here
    initializeUserModel();
  }

  void initializeUserModel() {
    // Example user data initialization
    final _user = _authController.getUser();
    profileImageUrl.value = _user?.imageUrl ??
        'https://via.placeholder.com/150'; // Replace with actual data
    nameController.text = _user?.name ?? 'User Name';
    phoneController.text = _user?.phone ?? '1234567890';
    addressController.text = _user?.address ?? 'User Address';
  }
}
