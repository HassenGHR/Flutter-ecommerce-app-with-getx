import 'package:get/get.dart';

class SplashController extends GetxController {
  // Initialize any necessary variables or services here
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate a delay for splash screen
    Future.delayed(Duration(seconds: 3), () {
      isLoading.value = false;
      // Navigate to the next screen after splash
      Get.offNamed('/home');
    });
  }
}
