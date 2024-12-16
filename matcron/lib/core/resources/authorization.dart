import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthorizationService {
  final secureStorage = FlutterSecureStorage();

  void saveToken(String token) async {
    await secureStorage.write(key: 'authToken', value: token);
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'authToken');
  }

  void deleteToken() async {
    await secureStorage.delete(key: 'authToken');
  }
}