import 'package:flutter/material.dart';
import 'package:matcron/app/features/mattress/presentation/pages/scan_page.dart';

class SearchBar extends StatelessWidget {
  final Function(String)? onSearchChanged; // Callback for text changes
  const SearchBar({
    super.key,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 400,
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search TextField
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: "Search Mattress",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              ),
            ),
          ),

          // Scan Icon
          IconButton(
            icon: Image.asset(
              'assets/icons/scan_icon.png', // Path to your scan icon asset
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if the asset is not found
                return const Icon(
                  Icons.qr_code_scanner,
                  size: 24,
                  color: Colors.grey,
                );
              },
            ),
            onPressed: () {
              // Navigate to ScanImportPage with a "typeOfImport" parameter
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanImportPage("RFID"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
