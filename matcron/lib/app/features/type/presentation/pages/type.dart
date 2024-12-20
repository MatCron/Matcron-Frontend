import 'package:flutter/material.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/presentation/widgets/bottom_drawer.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/constants/constants.dart';

class MattressTypePage extends StatefulWidget {
  const MattressTypePage({super.key});

  @override
  MattressTypePageState createState() => MattressTypePageState();
}

class MattressTypePageState extends State<MattressTypePage> {
  
  final List<MattressTypeEntity> mattressTypes = [
    MattressTypeEntity(
      id: "1",
      name: "Single",
      width: 80,
      length: 60,
      height: 10,
      composition: "Foam",
      rotationInterval: 3,
      recyclingDetails: "Recycle",
      expectedLifespan: 5,
      warrantyPeriod: 1,
      stock: 15,
    ),
    MattressTypeEntity(
      id: "2",
      name: "Double",
      width: 75,
      length: 54,
      height: 8,
      composition: "Foam",
      rotationInterval: 3,
      recyclingDetails: "Recycle",
      expectedLifespan: 5,
      warrantyPeriod: 1,
      stock: 20,
    ),
    MattressTypeEntity(
      id: "3",
      name: "King",
      width: 80,
      length: 76,
      height: 12,
      composition: "Foam",
      rotationInterval: 3,
      recyclingDetails: "Recycle",
      expectedLifespan: 5,
      warrantyPeriod: 1,
      stock: 8,
    ),
    MattressTypeEntity(
      id: "4",
      name: "Queen",
      width: 74,
      length: 38,
      height: 6,
      composition: "Foam",
      rotationInterval: 3,
      recyclingDetails: "Recycle",
      expectedLifespan: 5,
      warrantyPeriod: 1,
      stock: 30,
    ),
  ];

  

  // Filtered list for searching
  List<MattressTypeEntity> filteredTypes = [];

  @override
  void initState() {
    super.initState();
    filteredTypes = mattressTypes; // Initialize with all data
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  void _openBottomDrawer(BuildContext context, {required MattressTypeEntity type, required bool isEditable} ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the drawer to take up full height
      backgroundColor: Colors.transparent, // Matches design
      builder: (context) {
        return MattressTypeBottomDrawer(
          mattress: type,
          isEditable: isEditable,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#E5E5E5"),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              onChanged: (query) {
                setState(() {
                  filteredTypes = mattressTypes
                      .where((type) =>
                          type.name!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: "Search Mattress Types",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
            const SizedBox(height: 10.0),

            // Add mattress type button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality placeholder
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: matcronPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "+ Add Type",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 18.0),

            // Table headers with better spacing
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Type",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Added spacing
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "Inches",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ), // Prevent wrapping
                    ),
                  ),
                ),
                const SizedBox(width: 40), // More spacing between Inches and Stock
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Stock",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Text("Edit", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 30),
                const Text("Delete", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10.0),

            // Table rows with mattress types
            Expanded(
              child: ListView.builder(
                itemCount: filteredTypes.length,
                itemBuilder: (context, index) {
                  final type = filteredTypes[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            type.name!,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            //make it fit in one line without squishing
                            child: Text(
                              "(${type.width?.toInt()} x ${type.length?.toInt()} x ${type.height?.toInt()})",
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                              maxLines: 1, // Prevent wrapping in data
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              type.stock.toString(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            // Edit functionality placeholder
                            _openBottomDrawer(context, type: type, isEditable: true);
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            // Delete functionality placeholder
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
