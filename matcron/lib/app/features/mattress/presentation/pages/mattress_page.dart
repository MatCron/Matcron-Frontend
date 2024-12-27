import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_bloc.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_state.dart';
import 'package:matcron/app/features/mattress/presentation/pages/add_mattress_page.dart';
import 'package:matcron/app/features/mattress/presentation/pages/import_page.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/constants/constants.dart';

class MattressPage extends StatefulWidget {
  const MattressPage({super.key});

  @override
  MattressPageState createState() => MattressPageState();
}

class MattressPageState extends State<MattressPage> {
  final List<MattressEntity> mattresses = [];
  List<MattressEntity> filteredMattresses = [];
  List<MattressEntity> selectedMattresses = [];
  List<MattressTypeEntity> types = [];

  @override
  void initState() {
    super.initState();
    filteredMattresses = mattresses;
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
          TextField(
            onChanged: (query) {
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
            decoration: InputDecoration(
              hintText: "Search mattresses",
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedMattresses.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    //print("Transfer Out: ${selectedMattresses.length} items");
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
                        builder: (context) => const ImportMattressPage(),
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
                child: Text("Type",
                    style: _headerStyle),
              ),
              Expanded(
                child: Text("Location",
                    style: _headerStyle),
              ),
              const SizedBox(width: 30.0),
              Expanded(
                child: Text("Status",
                    style: _headerStyle),
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

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
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
                                        selectedMattresses.remove(mattress);
                                      } else {
                                        selectedMattresses.add(mattress);
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
                                flex: 2,
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
                                      ? mattressStatus[mattress.status!]['Text']
                                          as String
                                      : 'Unknown Status',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: mattress.status != null &&
                                            mattress.status! <
                                                mattressStatus.length
                                        ? mattressStatus[mattress.status!]
                                            ['Color'] as Color
                                        : Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
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
