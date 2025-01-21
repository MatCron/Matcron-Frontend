import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_bloc.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_event.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_state.dart';
import 'package:matcron/app/features/mattress/presentation/pages/add_mattress_page.dart';
import 'package:matcron/app/features/mattress/presentation/pages/scan_page.dart';
import 'package:matcron/app/features/mattress/presentation/widgets/bottom_drawer.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/presentation/widgets/bottom_drawer.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/components/transfer_out/transfer_reason.dart';
import 'package:matcron/core/constants/constants.dart';
import  'package:matcron/core/components/search_bar/search_bar.dart' as custom;
import 'package:intl/intl.dart';

class MattressPage extends StatefulWidget {
  final MattressEntity? searchedEntity;
  const MattressPage(MattressEntity? initialSearchedEntity, {super.key, this.searchedEntity});

  @override
  MattressPageState createState() => MattressPageState();
}

class MattressPageState extends State<MattressPage> {
  final List<MattressEntity> mattresses = [];
  List<MattressEntity> filteredMattresses = [];
  List<MattressEntity> selectedMattresses = [];
  int selectedMattressIndex = -1;
  List<MattressTypeEntity> types = [];
  bool canRefreshList = false;

  @override
  void initState() {
    super.initState();
    filteredMattresses = mattresses;

    if (widget.searchedEntity != null) {
      filteredMattresses.clear();
      filteredMattresses.add(widget.searchedEntity!);
    }
  }

  void _updateMattress(MattressEntity m) {
    filteredMattresses.clear();
    context.read<RemoteMattressBloc>().add(UpdateMattress(m));
  }

  void _searchMattress(MattressEntity m) {
    filteredMattresses.clear();
    filteredMattresses.add(m);
  }

  void _openDPPBottomDrawer(BuildContext context,
      {required MattressTypeEntity type, required bool isEditable}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the drawer to take up full height
      backgroundColor: Colors.transparent, // Matches design
      builder: (context) {
        return MattressTypeBottomDrawer(
          mattress: type,
          isEditable: false,
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
      body: BlocBuilder<RemoteMattressBloc, RemoteMattressState>(
        builder: (_, state) {
          if (state is RemoteMattressesLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(matcronPrimaryColor),
              ),
            );
          }

          if (state is RemoteMattressesDone) {
            mattresses.clear();
            mattresses.addAll(state.mattresses!);
            types.addAll(state.types!);
            return _buildDoneState(context);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildDoneState(BuildContext context) {
    return Container(
      color: HexColor("#E5E5E5"),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          custom.SearchBar(
            placeholder: "Search Mattress",
            canRefreshList: canRefreshList,
            searchMattress: _searchMattress,
            onSearchChanged: (query) {
              setState(() {
                filteredMattresses = mattresses
                    .where((mattress) =>
                        mattress.type!
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        mattress.location!
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .toList();
              });
            },
          ),
          
          const SizedBox(height: 10.0),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedMattresses.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<RemoteMattressBloc>(
                          create: (context) => sl<RemoteMattressBloc>(),
                          child: TransferOutMattressPage(),
                        ),
                      ));
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
                  child: const Image(
                    image: AssetImage('assets/images/transfer.png'),
                    width: 20,
                    height: 20,
                  ),
                ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<RemoteMattressBloc>(
                          create: (context) => sl<RemoteMattressBloc>(),
                          child: AddMattressPage(types),
                        ),
                      ));
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
                child: const Image(
                  image: AssetImage('assets/images/add.png'),
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanImportPage(""),
                      ));
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
                child: const Image(
                  image: AssetImage('assets/images/import.png'),
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          // Table headers
          Row(
            children: [
              const SizedBox(width: 50.0),
              Expanded(
                child: Text("Type", style: _headerStyle),
              ),
              Expanded(
                child: Text("Location", style: _headerStyle),
              ),
              const SizedBox(width: 30.0),
              Expanded(
                child: Text("Status", style: _headerStyle),
              ),
            ],
          ),
          const Divider(color: Colors.black26),
          // Mattresses List
          Expanded(
            child: filteredMattresses.isEmpty
                ? Center(
                    child: Text(
                      "No mattresses available",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredMattresses.length,
                    itemBuilder: (context, index) {
                      final mattress = filteredMattresses[index];
                      final isSelected = selectedMattresses.contains(mattress);
                      final dropdownOpen = selectedMattressIndex == index;

                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedMattressIndex == index) {
                                selectedMattressIndex = -1;
                              } else {
                                selectedMattressIndex = index;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 25.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: dropdownOpen
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                          )
                                        : BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                selectedMattresses
                                                    .remove(mattress);
                                              } else {
                                                selectedMattresses
                                                    .add(mattress);
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isSelected
                                                  ? matcronPrimaryColor
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          mattress.type!,
                                          style: _itemTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          mattress.location!,
                                          style: _itemTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          mattress.status != null &&
                                                  mattress.status! <
                                                      mattressStatus.length
                                              ? mattressStatus[mattress.status!]
                                                  ['Text'] as String
                                              : 'Unknown Status',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            color: mattress.status != null &&
                                                    mattress.status! <
                                                        mattressStatus.length
                                                ? mattressStatus[mattress
                                                    .status!]['Color'] as Color
                                                : Colors.black,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (dropdownOpen)
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 25.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Rotate: ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${mattress.daysToRotate} days",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "End of Lifecycle:\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          DateFormat('dd-MM-yyyy').format(mattress.lifeCyclesEnd!),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Organization: ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text: "TEMP",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          //Row of buttons edit and more
                                          const SizedBox(width: 25.0),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return MattressBottomDrawer(
                                                          mattressTypes: types,
                                                          mattress: mattress,
                                                          onSave: _updateMattress,
                                                          );
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .green, // Green background for Edit button
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0), // Slight radius for rounded corners
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // White text
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _openDPPBottomDrawer(context, type: mattress.mattressType!, isEditable: false);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      matcronPrimaryColor, // Use matcronPrimaryColor for More button
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0), // Slight radius for rounded corners
                                                  ),
                                                ),
                                                child: const Text(
                                                  "More",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // White text
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                              ],
                            ),
                          ));
                    },
                  ),
          ),
        ],
      ),
    );
  }

  static const TextStyle _headerStyle = TextStyle(
    fontSize: 16.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle _itemTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );
}
