import 'dart:typed_data';

String decodeNfcPayload(Uint8List payload) {
  // Ignore the first byte and extract the language code length
  int languageCodeLength = payload[0];
  
  // Extract actual data after the language code
  String data = String.fromCharCodes(payload.sublist(1 + languageCodeLength));
  return data;
}
