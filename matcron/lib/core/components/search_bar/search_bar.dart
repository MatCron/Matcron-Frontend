import 'package:flutter/material.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/core/components/rid_scanner/rfid_scanner.dart';

class SearchBar extends StatelessWidget {
  final Function(String)? onSearchChanged; // Callback for text changes
  final String placeholder;
  final bool canRefreshList;
  final Function(MattressEntity) searchMattress;

  const SearchBar({
    super.key,
    this.onSearchChanged, required this.placeholder,
    required this.canRefreshList, required this.searchMattress,
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
              decoration: InputDecoration(
                hintText: placeholder,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              ),
            ),
          ),

          // Scan Icon
          IconButton(
            icon: Image.asset(
              'assets/images/scan_icon.png', // Path to your scan icon asset 
              height: 36,
              width:50,
              // errorBuilder: (context, error, stackTrace) {
              //   // Fallback if the asset is not found
              //   return const Icon(
              //     Icons.qr_code_scanner,
              //     size: 24,
              //     color: Colors.grey,
              //   );
              // },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RfidScanner(searchMattress: searchMattress),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
