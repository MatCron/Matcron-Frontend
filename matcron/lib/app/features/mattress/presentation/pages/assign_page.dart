import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/constants/constants.dart';
// import 'package:matcron/core/resources/nfc_utils.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:nfc_manager/platform_tags.dart';

class AssignPage extends StatefulWidget {
  final String? uid;

  const AssignPage(this.uid, {super.key});

  @override
  AssignPageState createState() => AssignPageState();
}

class AssignPageState extends State<AssignPage> {
  bool isScanning = true; // NFC scanning status
  bool isWriting = false; // NFC writing status
  bool isFinished = false; // Finished writing status
  final String hardcodedPassword = "1234"; // 4-byte password
  final String hardcodedPack = "AB"; // 2-byte PACK
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance
  // Future<void> _lockTag() async {
  //   await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //     try {
  //       // Authenticate with password (if set)
  //       Uint8List password =
  //           Uint8List.fromList([0x12, 0x34, 0x56, 0x78]); // Set your password
  //       Uint8List authCommand = Uint8List.fromList([0x1B] + password);
  //       List<int> authResponse = await NFCUtils.transceive(authCommand);
  //       print("Authentication response: $authResponse");

  //       // Set AUTH0 to 4 (Protect from Page 4 onwards)
  //       Uint8List auth0Command =
  //           Uint8List.fromList([0xA2, 0x2A, 0x04, 0x00, 0x00, 0x00]);
  //       await NFCUtils.transceive(auth0Command);
  //       print("AUTH0 set successfully!");

  //       // Set ACCESS register to disable writing
  //       Uint8List accessCommand =
  //           Uint8List.fromList([0xA2, 0x2B, 0x80, 0x00, 0x00, 0x00]);
  //       await NFCUtils.transceive(accessCommand);
  //       print("ACCESS set successfully!");

  //       await NfcManager.instance.stopSession();
  //       print("Tag locked!");
  //     } catch (e) {
  //       print("Error locking tag: $e");
  //       await NfcManager.instance
  //           .stopSession(errorMessage: "Failed to lock tag.");
  //     }
  //   });
  // }

  // Future<void> _authenticateTag() async {
  //   try {
  //     Uint8List passwordBytes = Uint8List.fromList(hardcodedPassword.codeUnits);
  //     Uint8List authCommand = Uint8List.fromList([0x1B, ...passwordBytes]);
  //     List<int> response = await NFCUtils.transceive(authCommand);
  //     _handleError("Authentication successful: PACK ${response.sublist(0, 2)}");
  //   } catch (e) {
  //     throw Exception("Authentication failed: $e");
  //   }
  // }
  Future<void> _lockTag() async {
    await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        // Authenticate with password (if set)
        final mifareUl = MifareUltralight.from(tag);
        if (mifareUl == null) {
          print('Tag is not compatible with NTAG215 commands.');
          return;
        }

        Uint8List password = Uint8List.fromList([0x11, 0x22, 0x33, 0x44]);
        Uint8List pack = Uint8List.fromList([0xAA, 0xBB]);

        await mifareUl.transceive(
          data: Uint8List.fromList([
            // <-- Add 'data:' here
            0xA2, // Write command
            0x2B, // Page address
            ...password,
          ]),
        );

        await mifareUl.transceive(
          data: Uint8List.fromList([
            // <-- Add 'data:' here
            0xA2,
            0x2C,
            ...pack,
            0x00, // AUTH0
            0x00, // RFUI
          ]),
        );

        // Set lock bits in page 0x2A
        await mifareUl.transceive(
          data: Uint8List.fromList([
            // <-- Add 'data:' here
            0xA2,
            0x2A,
            0x01, 0x00, 0x00, 0x00,
          ]),
        );

        await NfcManager.instance.stopSession();
        print("Tag locked!");
      } catch (e) {
        _handleError("Error while writing to badge");
        await NfcManager.instance
            .stopSession(errorMessage: "Failed to lock tag.");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Get NfcService instance
    // Start NFC session
    _startNfcSession();
  }

  // Start NFC session and update the state
  Future<void> _startNfcSession() async {
    setState(() {
      isScanning = true;
      isWriting = false;
      isFinished = false;
    });

    // Start scanning NFC tags
    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      var ndef = Ndef.from(badge);

      if (ndef != null && ndef.isWritable) {
        // Change state for writing
        setState(() {
          isScanning = false;
          isWriting = true;
        });

        // Simulate writing process
        await Future.delayed(const Duration(seconds: 2));

        NdefRecord ndefRecord = NdefRecord.createText(widget.uid!);
        NdefMessage message = NdefMessage([ndefRecord]);

        try {
          // Write the message to the tag
          await ndef.write(message);

          // Lock the tag after writing
          await setDynamicLockBytes(badge);

          //print("sucess");
          // Vibrate on success
          if (await Vibration.hasVibrator() ?? false) {
            Vibration.vibrate(duration: 500);
          }
          // Play success sound
          await _audioPlayer.play(AssetSource('sounds/sucess2.wav'));
          // Successfully written to the tag
          setState(() {
            isFinished = true;
            isWriting = false;
          });

          NfcManager.instance.stopSession();

          // Redirect after writing is finished and ensure no back navigation
          Future.delayed(const Duration(seconds: 2), () {
            // Check if the widget is still mounted before attempting to navigate
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    startPageIndex: 1,
                  ),
                ),
                (Route<dynamic> route) => false, // Remove all previous routes
              );
            }
          });
        } catch (e) {
          // Error during writing
          setState(() {
            isWriting = false;
          });
          // Vibrate and play error sound
          _handleError("Error while writing to badge");
          NfcManager.instance.stopSession();
        }
      } else {
        // Tag is not writable
        setState(() {
          isScanning = false;
          isWriting = false;
          isFinished = false;
        });

        // Vibrate and play error sound
        _handleError("Tag is not writable");
        NfcManager.instance.stopSession();
      }
    });
  }

  Future<void> setDynamicLockBytes(NfcTag tag) async {
    var mifare = MifareUltralight.from(tag);

    if (mifare == null) {
      print(" Error: This NFC tag does not support MIFARE Ultralight.");
      return;
    }

    try {
      // Convert command to Uint8List
      Uint8List lockCommand = Uint8List.fromList([
        0xA2, // WRITE command
        0x82, // Page 130 (Dynamic Lock Page)
        0xFF, 0xFF, 0xFF, 0xFF // Lock all user memory pages
      ]);

      // Send raw command using transceive()
      await mifare.transceive(data: lockCommand);

      print(" Dynamic lock applied: All user memory pages are now read-only.");
    } catch (e) {
      print(" Error setting dynamic lock: $e");
    }
  }

  // Handle error scenarios with vibration and sound
  void _handleError(String errorMessage) async {
    // Vibrate on error
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 1000);
    }

    // Play error sound
    try {
      await _audioPlayer.play(AssetSource('sounds/error.wav'));
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }

    // Stop NFC session with error message
    NfcManager.instance.stopSession(errorMessage: errorMessage);

    // Update UI
    setState(() {
      isScanning = false;
      isWriting = false;
      isFinished = false;
    });
  }

  @override
  void dispose() {
    // Ensure the NFC session is stopped when the page is disposed
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#E5E5E5"),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(title: 'Mattress'),
              const SizedBox(height: 20.0),

              // Block with rounded edges and picture
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/images/assign_page.png',
                    height: 175,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 70.0),

              // Show scanning status (optional UI feedback)
              if (isScanning) ...[
                // Scanning state UI
                Center(
                  child: Image.asset(
                    'assets/images/rfid.png', // Adjust your image path as needed
                    width: 275,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Tap On Mattress RFID..."),
              ] else if (isWriting) ...[
                // Writing state UI
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(matcronPrimaryColor),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Processing..."),
              ] else if (isFinished) ...[
                // Finished writing state UI
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                const SizedBox(height: 10),
                Text("Finished writing to NFC tag!"),
              ] else ...[
                // Error or no tag detected
                Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Failed or no writable tag found."),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
