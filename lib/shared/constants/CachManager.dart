import 'package:get_storage/get_storage.dart';

enum CacheManagerKey { TOKEN }

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }
}
