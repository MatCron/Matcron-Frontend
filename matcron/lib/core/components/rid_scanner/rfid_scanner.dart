import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/resources/nfc_decoder.dart';
import 'package:nfc_manager/nfc_manager.dart';

class RfidScanner extends StatefulWidget {
  final Function(MattressEntity) searchMattress;

  const RfidScanner({super.key, required this.searchMattress});

  @override
  RfidScannerState createState() => RfidScannerState();
}

class RfidScannerState extends State<RfidScanner> {
  bool isScanning = true; // NFC scanning status
  bool isFinished = false; // Finished writing status
  String readUid = "";

  late MattressEntity mattress;
  late MattressRepository _mattressRepository;

  @override
  void initState() {
    super.initState();
    _mattressRepository = GetIt.instance<MattressRepository>();
    // Get NfcService instance
    // Start NFC session
    _startNfcSession();
  }

  // Start NFC session and update the state
  Future<void> _startNfcSession() async {
    setState(() {
      isScanning = true;
      isFinished = false;
    });

    // Start scanning NFC tags
    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      try {
        var ndef = Ndef.from(badge);
        if (ndef != null && ndef.cachedMessage != null) {
          var uid = decodeNfcPayload(ndef.cachedMessage!.records[0].payload);

          var state = await _mattressRepository.getMattressById(uid);
          if (state is DataSuccess) {
            mattress = state.data!;
          }

          NfcManager.instance.stopSession();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(searchedEntity: mattress)
              ));
        } else {
          setState(() {
            isScanning = false;
          });
          NfcManager.instance.stopSession(errorMessage: "Failed to read tag.");
        }
      } catch (e) {
        setState(() {
          isScanning = false;
        });
        NfcManager.instance.stopSession(errorMessage: "Error reading tag.");
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
              Header(title: 'Search Mattress'),
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
