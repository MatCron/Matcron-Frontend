import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  // Method to hash the password with the salt
  String hashPassword(String password, String salt) {
    // Combine password with the salt
    String saltedPassword = password + salt;
    
    // Convert the salted password to bytes
    List<int> bytes = utf8.encode(saltedPassword);
    
    // Compute the SHA-256 hash
    var digest = sha256.convert(bytes);
    
    // Return the hash as a Base64 string
    return base64.encode(digest.bytes);
  }

  // Method to encrypt the timestamp (AES encryption)
  String encryptTimestampAndPass(String pass, String encryptionKey) {
    // Ensure the encryption key is 32 bytes (for AES-256)
    final key = encrypt.Key.fromUtf8(encryptionKey.padRight(32, ' ')); // Padded to 32 bytes
    final iv = encrypt.IV.fromLength(16); // You can use a random IV for better security

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Encrypt the pass
    final encrypted = encrypter.encrypt(pass, iv: iv);

    // Return the encrypted pass as Base64
    return encrypted.base64;
  }

  // Method to encrypt the password (similar to your original encryption)
  String encryptPassword(String password) {
    // Static salt for example (can be customized or generated randomly)
    String salt = "n0xfDfb0rN";
    
    // Hash the password using the provided salt
    String hashedPassword = hashPassword(password, salt);
    
    // Get the current timestamp in milliseconds
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Combine the hashed password and encrypted timestamp
    String encryptedPassword = encryptTimestampAndPass("$hashedPassword-$timestamp", "encryptionKey");

    
    return encryptedPassword;
  }
}