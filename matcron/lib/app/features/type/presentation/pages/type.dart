import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_bloc.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_event.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_state.dart';
import 'package:matcron/app/features/type/presentation/widgets/bottom_drawer.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/app/features/type/presentation/pages/type_form.dart';
import  'package:matcron/core/components/search_bar/search_bar.dart' as custom;

class MattressTypePage extends StatefulWidget {
  const MattressTypePage({super.key});

  @override
  MattressTypePageState createState() => MattressTypePageState();
}

class MattressTypePageState extends State<MattressTypePage> {
  final List<MattressTypeEntity> mattressTypes = [];

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

  void _openBottomDrawer(BuildContext context,
      {required MattressTypeEntity type, required bool isEditable}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the drawer to take up full height
      backgroundColor: Colors.transparent, // Matches design
      builder: (context) {
        return MattressTypeBottomDrawer(
          mattress: type,
          isEditable: isEditable,
          onSave: (mattress) {
            // Save functionality placeholder
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RemoteTypeBloc, RemoteTypeState>(
        builder: (_, state) {
          if (state is RemoteTypesLoading) {
            return Scaffold(
              backgroundColor: HexColor("#E5E5E5"),
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(matcronPrimaryColor),
                ),
              ),
            );
          }

          if (state is RemoteTypesDone) {
            mattressTypes.clear();
            mattressTypes.addAll(state.types!);
            return _buildDoneState(context);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildDoneState(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#E5E5E5"),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            custom.SearchBar(
              placeholder: "Search Mattress Type",
              searchMattress: (m) => {},
              canRefreshList: false,
              onSearchChanged: (query) {
                setState(() {
                  filteredTypes = mattressTypes
                      .where((type) => type.name!
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              },
         
            ),
            const SizedBox(height: 10.0),

            // Add mattress type button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMattressTypePage()
                    ),
                  );
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
                const SizedBox(
                    width: 40), // More spacing between Inches and Stock
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
            const Divider(color: Colors.black26),

            // Table rows with mattress types
            Expanded(
              child: ListView.builder(
                itemCount: filteredTypes.length,
                itemBuilder: (context, index) {
                  final type = filteredTypes[index];
                  return GestureDetector(
                    onTap: () {
                      // Open bottom drawer with mattress type details
                      _openBottomDrawer(context, type: type, isEditable: false);
                    },
                    child: Container(
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
                                overflow: TextOverflow.ellipsis,
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
                              _openBottomDrawer(context,
                                  type: type, isEditable: true);
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
