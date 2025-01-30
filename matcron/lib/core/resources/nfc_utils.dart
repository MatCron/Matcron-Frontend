import 'dart:typed_data';
import 'package:flutter/services.dart';

class NFCUtils {
  static const MethodChannel _channel =
      MethodChannel('com.matcron.nfc/transceive');

  static Future<List<int>> transceive(Uint8List command) async {
    try {
      final List<int> response =
          await _channel.invokeMethod('transceive', {'command': command});
      return response;
    } catch (e) {
      throw Exception('Transceive failed: $e');
    }
  }
}
