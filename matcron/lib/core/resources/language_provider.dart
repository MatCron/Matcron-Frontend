import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'EN';

  String get currentLanguage => _currentLanguage;

  Future<void> loadLanguage() async {
    final storage = FlutterSecureStorage();
    String? languageCode = await storage.read(key: 'languageCode');
    if (languageCode != null) {
      _currentLanguage = languageCode;
    }
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    const allowedLanguages = ['EN', 'DE', 'ES', 'FR', 'IT', 'NL', 'PT', 'AR'];
    if (allowedLanguages.contains(languageCode.toUpperCase())) {
      final storage = FlutterSecureStorage();
      await storage.write(key: 'languageCode', value: languageCode.toUpperCase());
      _currentLanguage = languageCode.toUpperCase();
      notifyListeners();  // Notify listeners when language changes
    } else {
      print("Invalid language code: $languageCode");
    }
  }
}
