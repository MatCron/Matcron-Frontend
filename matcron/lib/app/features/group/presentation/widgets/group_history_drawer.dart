import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/group/domain/repositories/group_repository.dart';
import 'package:matcron/app/features/mattress_history/domain/entities/mattress_history.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:matcron/core/resources/data_state.dart';

class GroupHistoryDrawer extends StatefulWidget {
  final String groupId;
  const GroupHistoryDrawer({super.key, required this.groupId});

  @override
  GroupHistoryDrawerState createState() =>
      GroupHistoryDrawerState();
}

class GroupHistoryDrawerState extends State<GroupHistoryDrawer> {
  late GroupRepository _groupRepository;
  late List<MattressHistoryEntity> history;
  bool isLoading = true;
  
  

  @override
  void initState() {
    super.initState();
    _groupRepository = GetIt.instance<GroupRepository>();
    _getHistory();
  }

  void _getHistory() async {
    var state = await _groupRepository.getGroupHistoryById(widget.groupId);

    if (state is DataSuccess && state.data != null) {
      setState(() {
        history = sortByNewest(state.data!);
        isLoading = false;
      });
    }
  }

  List<MattressHistoryEntity> sortByNewest(List<MattressHistoryEntity> list) {
    list.sort((a, b) =>
        (b.timeStamp ?? DateTime(0)).compareTo(a.timeStamp ?? DateTime(0)));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isLoading) {
      //color matcronPrimaryColor
      return Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary));
    }

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        final theme = Theme.of(context);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
           decoration:  BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color:theme.colorScheme.onSurface .withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("History", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.colorScheme.primary),),
              IconButton(
                    icon:  Icon(Icons.close, color: theme.colorScheme.error),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),

              Expanded(child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Details",
                          style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    color: theme.cardColor)
                        )
                      ],
                    ),
                  ),

                  Expanded(
                        child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final item = history[index];
                            bool isLast = index ==
                                history.length -
                                    1; // Check if it's the last item

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Timeline Indicator (Dot + Line)
                                  Column(
                                    children: [
                                      // Dot
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: matcronPrimaryColor, // Customize color
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      // Vertical Line
                                      if (!isLast)
                                        Container(
                                          width: 2,
                                          height: 50, // Adjust for spacing
                                          color:theme.colorScheme.primary.withOpacity(0.1),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                      width:
                                          12), // Space between timeline and text

                                  // Details & Timestamp
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.details ?? "No details",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        const SizedBox(height: 4),
                                        Text(
                                          item.timeStamp != null
                                              ? "${item.timeStamp!.day}/${item.timeStamp!.month}/${item.timeStamp!.year}"
                                              : "No date",
                                          style: TextStyle(
                                              fontSize: 14,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                ],
              ))
            ],
          )
        );
      }
    );
  }
  
}

