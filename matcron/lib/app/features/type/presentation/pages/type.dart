import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_bloc.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_state.dart';
import 'package:matcron/app/features/type/presentation/widgets/bottom_drawer.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/app/features/type/presentation/pages/type_form.dart';
import 'package:matcron/core/components/search_bar/search_bar.dart' as custom;
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/resources/nfc_decoder.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MattressTypePage extends StatefulWidget {
  const MattressTypePage({super.key});

  @override
  MattressTypePageState createState() => MattressTypePageState();
}

class MattressTypePageState extends State<MattressTypePage> {
  final List<MattressTypeEntity> mattressTypes = [];

  // Filtered list for searching
  List<MattressTypeEntity> filteredTypes = [];

  //search bar integration
  bool canRefreshList = false;
  final MattressRepository _mattressRepository =
      GetIt.instance<MattressRepository>();

  bool isScanning = true; // NFC scanning status
  bool isFinished = false; // Finished writing status

  MattressTypeEntity? currentSearchedEntity;

  @override
  void initState() {
    super.initState();
    filteredTypes = mattressTypes; // Initialize with all data
    canRefreshList = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _searchMattress(MattressEntity m) {
    setState(() {
      filteredTypes = [m.mattressType!]; // Update with the single mattress
      currentSearchedEntity = m.mattressType;
    });
    debugPrint("Filtered Mattresses Updated: $filteredTypes");
  }

  void _refreshList() {
    setState(() {
      filteredTypes = mattressTypes; // Update with the single mattress
      currentSearchedEntity = null;
      canRefreshList = false;
    });
  }

  void _openRfidModal(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), _startNfcSession);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/scan_icon.png', // Adjust your image path as needed
                  width: 275,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text("Tap On RFID..."),
            ],
          ),
        );
      },
    );
  }

  Future<void> _startNfcSession() async {
    if (!mounted) return; // Ensure the widget is still in the tree

    setState(() {
      isScanning = true;
      isFinished = false;
    });

    NfcManager.instance.startSession(onDiscovered: (NfcTag badge) async {
      try {
        var ndef = Ndef.from(badge);
        if (ndef != null && ndef.cachedMessage != null) {
          var uid = decodeNfcPayload(ndef.cachedMessage!.records[0].payload);
          var state = await _mattressRepository.getMattressById(uid);
          state.data!.uid = uid;

          if (state is DataSuccess && state.data != null) {
            // Update filteredMattresses using _searchMattress
            _searchMattress(state.data!);
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Mattress not found for UID: $uid")),
              );
            }
          }

          NfcManager.instance.stopSession();

          // Close the dialog safely
          if (mounted) {
            Navigator.of(context, rootNavigator: true)
                .pop(); // Ensure only the dialog is closed
          }
        } else {
          _handleNfcError("Failed to read NFC tag.");
        }
      } catch (e) {
        _handleNfcError("Error reading NFC tag: $e");
      }
    });
  }

  void _handleNfcError(String errorMessage) {
    if (!mounted) return;

    setState(() {
      isScanning = false;
    });

    NfcManager.instance.stopSession(errorMessage: errorMessage);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );

    // Close the dialog if still visible
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
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

            debugPrint(currentSearchedEntity?.name);

            if (currentSearchedEntity != null) {
              canRefreshList = true;
              currentSearchedEntity = mattressTypes.singleWhere(
                  (element) => element.id == currentSearchedEntity!.id);
              filteredTypes = [currentSearchedEntity!];
            }

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
            custom.SearchBar(
              placeholder: "Search Mattress Type",
              canRefreshList: canRefreshList,
              searchMattress: () => _openRfidModal(context),
              refreshList: () => _refreshList(),
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
                        builder: (context) => AddMattressTypePage()),
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
