import 'package:flutter/material.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
          // Successfully written to the tag
          setState(() {
            isFinished = true;
            isWriting = false;
          });

          // Redirect after writing is finished and ensure no back navigation
          Future.delayed(const Duration(seconds: 2), () {
  // Check if the widget is still mounted before attempting to navigate
  if (mounted) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(startPageIndex: 1,),
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
          NfcManager.instance
              .stopSession(errorMessage: "Error while writing to badge");
        }
      } else {
        // Tag is not writable
        setState(() {
          isScanning = false;
          isWriting = false;
          isFinished = false;
        });
        NfcManager.instance.stopSession(errorMessage: "Tag is not writable");
      }
    });
  }

  @override
  void dispose() {
    // Ensure the NFC session is stopped when the page is disposed
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
