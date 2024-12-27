import 'package:nfc_manager/nfc_manager.dart';

class NfcService {
  bool _isNfcActive = false;

  // Start NFC session
  Future<bool> startNfc() async {
    if (_isNfcActive) return false;

    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          print("NFC Tag discovered: ${tag.data}");
          await _writeNfcTag("YourUIDHere");  // Write the UID or custom text
        },
      );
      _isNfcActive = true;
      return true;
    } catch (e) {
      print("Error starting NFC session: $e");
      return false;
    }
  }

  // Write to NFC tag method
  Future<void> _writeNfcTag(String record) async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      var ndef = Ndef.from(badge); // Get the NDEF from the discovered tag

      if (ndef != null && ndef.isWritable) {
        NdefRecord ndefRecord = NdefRecord.createText(record);  // Create text record
        NdefMessage message = NdefMessage([ndefRecord]);  // Create NDEF message

        try {
          await ndef.write(message);  // Write the NDEF message to the tag
          print("Successfully wrote to the NFC tag!");
        } catch (e) {
          print("Error while writing to badge: $e");
        }
      } else {
        print("Tag is not writable or doesn't support NDEF");
      }

      NfcManager.instance.stopSession();  // Stop session after operation
    });
  }

  // Stop NFC session
  void stopNfc() {
    if (!_isNfcActive) return;
    NfcManager.instance.stopSession();
    _isNfcActive = false;
    print("NFC session stopped");
  }

  // Clean up NFC session if needed
  void dispose() {
    if (_isNfcActive) {
      stopNfc();
    }
  }
}
