import 'package:day59/models/user/UserModel.dart';
import 'package:day59/shared/constants/CachManager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController with CacheManager {
  static AuthController get to => Get.find();

  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxString errorMessage = ''.obs;
  var isLoggedIn = false.obs;

  UserModel? get userModel => _userModel.value;
  final storage = GetStorage();

  void saveUser(UserModel user) {
    storage.write('user', user.toMap());
  }

  UserModel? getUser() {
    final userData = storage.read('user');
    if (userData != null) {
      return UserModel.fromMap(userData);
    }
    return null;
  }

  void clearUser() {
    storage.remove('user');
    isLoggedIn.value = false;
    _userModel.value = null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void checkLoginStatus() {
    final user = getUser();
    if (user != null) {
      _userModel.value = user;
      isLoggedIn.value = true;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final user = getUser();
      if (user != null && user.email == email && user.token == password) {
        _userModel.value = user;
        isLoggedIn.value = true;
        Get.toNamed('/');
      } else {
        errorMessage.value = 'Invalid email or password';
        isLoggedIn.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Login failed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      UserModel newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
        email: email.trim(),
        phone: phone ?? "",
        address: address ?? "",
        token: password.trim(),
        imageUrl:
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      );

      saveUser(newUser);
      _userModel.value = newUser;
      isLoggedIn.value = true;
      Get.toNamed('/');
    } catch (e) {
      errorMessage.value = 'Registration failed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String phone,
    required String address,
    String? imageUrl,
  }) async {
    try {
      isLoading.value = true;
      final user = getUser();
      if (user == null) {
        errorMessage.value = 'No user is logged in.';
        return false;
      }

      UserModel updatedUser = UserModel(
        id: user.id,
        name: name,
        email: user.email,
        phone: phone,
        address: address,
        token: user.token,
        imageUrl: imageUrl ?? user.imageUrl,
      );

      saveUser(updatedUser);
      _userModel.value = updatedUser;
      return true;
    } catch (e) {
      errorMessage.value = 'Profile update failed: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Sign Out
  Future<bool> signOut() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      clearUser();
      isLoggedIn.value = false;
      removeToken();

      return true; // Sign-out successful
    } catch (e) {
      errorMessage.value = 'Sign out error: $e';

      return false; // Sign-out failed
    } finally {
      isLoading.value = false;
    }
  }
}
