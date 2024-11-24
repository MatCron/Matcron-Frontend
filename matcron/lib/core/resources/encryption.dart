import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  // Step 1: Hash and salt the password
  static String hashAndSaltPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt); // Combine password and salt
    var hash = sha256.convert(bytes);
    return hash.toString(); // Return the hashed password
  }

  // Step 2: Get the current datetime
  String getCurrentDatetime() {
    DateTime now = DateTime.now();
    return now.toIso8601String(); // Returns a string of the current datetime
  }

  // Step 3: Combine password and datetime with a delimiter
  String combinePasswordAndDatetime(String passwordHash, String datetime) {
    return '$passwordHash|$datetime'; // Combine with delimiter '|'
  }

  // Step 4: Encrypt the combination of password hash and datetime
  String encryptData(String data, String encryptionKey) {
    final key = encrypt.Key.fromUtf8(encryptionKey.padRight(32, ' ')); // Encryption key needs to be 32 bytes
    final iv = encrypt.IV.fromLength(16); // 16 bytes IV (Initialization Vector)

    final encrypter = encrypt.Encrypter(encrypt.AES(key)); // Using AES encryption
    final encrypted = encrypter.encrypt(data, iv: iv); // Encrypting data
    return encrypted.base64; // Return the encrypted data in base64 format
  }

  // Combine all steps for encryption
  String encryptPassword(String password, {String salt = "matrcronIsTheBest2024", String encryptionKey = "encryptPassword"}) {
    String hashedPassword = hashAndSaltPassword(password, salt);
    String datetime = getCurrentDatetime();
    String combinedData = combinePasswordAndDatetime(hashedPassword, datetime);
    return encryptData(combinedData, encryptionKey);
  }
}
