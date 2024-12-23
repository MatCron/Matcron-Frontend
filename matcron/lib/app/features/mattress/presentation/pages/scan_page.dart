import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/mattress/presentation/widgets/progress_bar.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/nfc_service.dart';

class ScanImportPage extends StatefulWidget {
  const ScanImportPage(String typeOfImport, {super.key});

  @override
  ScanImportPageState createState() => ScanImportPageState();

}

class ScanImportPageState extends State<ScanImportPage> {
  late NfcService _nfcService;

  @override
  void initState() {
    super.initState();
    _nfcService = GetIt.instance<NfcService>();

    _nfcService.startNfc();
  
  }

  //dispose the NFC service

  @override
  void dispose() {
    _nfcService.stopNfc();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#E5E5E5"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(title: "Import"),
            const SizedBox(height: 20.0),
            ProgressBar(currentStep: 2, labels: progressBarLabels),

            // Center the image in the middle of the page
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/rfid.png',
                  width: 275,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
