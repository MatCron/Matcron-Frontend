import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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

  /// Get details inside the token
  Future<Map<String, dynamic>?> getTokenDetails() async {
    String? token = await getToken();
    if (token != null && token.isNotEmpty) {
      return JwtDecoder.decode(token); // Decodes payload
    }
    return null;
  }

  /// Check if token is expired
  Future<bool> isTokenExpired() async {
    String? token = await getToken();
    if (token != null && token.isNotEmpty) {
      return JwtDecoder.isExpired(token);
    }
    return true; // If no token, consider it expired
  }
}
