import 'dart:typed_data';

String decodeNfcPayload(Uint8List payload) {
  int languageCodeLength = payload[0];
  String data = String.fromCharCodes(payload.sublist(1 + languageCodeLength));
  return data;
}
