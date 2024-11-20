import 'package:crypt/crypt.dart';

class EncryptionService {
  String encryptPassword(String password) {
    String hashedPassword = "${Crypt.sha256(password, rounds: 1000, salt: "n0xfDfb0rN").toString()}-${DateTime.timestamp().toString()}";
    return hashedPassword;
  }
}