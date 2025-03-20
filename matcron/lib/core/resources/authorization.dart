import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthorizationService {
  final secureStorage = FlutterSecureStorage();

  void saveToken(String token) async {
    await secureStorage.write(key: 'authToken', value: token);
  }

  Future<String?> getToken() async {
    try {
      return await secureStorage.read(key: 'authToken');
    } catch (e) {
      print("Secure storage error: $e");
      await secureStorage.deleteAll(); // Reset storage if decryption fails
      return null;
    }
  }

  void deleteToken() async {
    await secureStorage.delete(key: 'authToken');
  }

  /// Get details inside the token
  Future<Map<String, dynamic>?> getTokenDetails() async {
    String? token = await getToken();
    if (token != null && token.isNotEmpty) {
      var p = JwtDecoder.decode(token);
      print(p['OrgId']);
      return JwtDecoder.decode(token); // Decodes payload
    }
    return null;
  }

  Future<int?> getUserType() async {
    String? token = await getToken();
    if (token != null && token.isNotEmpty) {
      var p = JwtDecoder.decode(token);
      print(p);
      // Safely parse the 'UserType' value
      if (p.containsKey('UserType')) {
        try {
          return int.parse(
              p['UserType'].toString()); // Convert to string first, then parse
        } catch (e) {
          print("Error parsing UserType: $e");
          return null;
        }
      }
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

  /// Save language preference
  void setLanguage(String languageCode) async {
    const allowedLanguages = ['EN', 'DE', 'ES'];
    if (allowedLanguages.contains(languageCode.toUpperCase())) {
      await secureStorage.write(key: 'languageCode', value: languageCode.toUpperCase());
    } else {
      print("Invalid language code: $languageCode");
    }
  }

  /// Get saved language preference
  Future<String?> getLanguage() async {
    return await secureStorage.read(key: 'languageCode') ?? 'ES'; // Default to English
  }
}
