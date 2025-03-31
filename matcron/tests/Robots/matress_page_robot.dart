import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_bloc.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_state.dart';

class MattressPageRobot {
  final WidgetTester tester;

  MattressPageRobot(this.tester);

  /// Search for a mattress by entering text in the search bar
  Future<void> searchForMattress(String query) async {
    final searchBar =
        find.byType(TextField); // Search bar is likely a TextField
    await tester.enterText(searchBar, query);
    await tester.pumpAndSettle(); // Wait for the UI to update
  }

  /// Verify a mattress with the given type and location exists in the list
  Future<void> verifyMattressInList(String type) async {
    final typeFinder = find.text(type);

    expect(typeFinder, findsWidgets);
  }

  /// Tap the "Add Mattress" button
  Future<void> tapAddMattressButton() async {
    final addButton = find.byKey(const Key('add_mattress_button'));
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapStatusButton() async {
    final status = find.byKey(const Key('mattress_status'));
    await tester.tap(status);
    await tester.pumpAndSettle();
  }

  Future<void> tapCancelButton() async {
    final addButton = find.text('Cancel'); // Find by text
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapSaveButton() async {
    final addButton = find.text('Save'); // Find by text
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  /// Tap the "Import Mattress" button
  Future<void> tapImportMattressButton() async {
    final importButton = find.widgetWithIcon(
        ElevatedButton, Icons.import_contacts); // Find by icon
    await tester.tap(importButton);
    await tester.pumpAndSettle();
  }

  /// Tap a mattress to open its dropdown details
  // Future<void> tapMattressItem(String typeName, String location) async {
  //   final mattressItem = find.descendant(
  //     of: find.byType(ListView),
  //     matching: find.text(location),
  //   );

  //   expect(mattressItem,
  //       find.byType(BlocListener<RemoteMattressBloc, RemoteMattressState>),
  //       reason: "Mattress item with location '$location' not found.");

  //   await tester.tap(mattressItem);
  //   await tester.pumpAndSettle();
  // }
  Future<void> tapMattressItem(String type, String location) async {
    await tester.pumpAndSettle();

    // Find the ListView first
    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    // Find the specific text within the ListView
    final locationFinder = find.descendant(
      of: listViewFinder,
      matching: find.text(location),
    );

    // Verify we found the location text
    expect(locationFinder, findsOneWidget);

    // Get the tappable ancestor (GestureDetector or InkWell)
    final tappableFinder = find.ancestor(
      of: locationFinder,
      matching: find.byType(GestureDetector),
    );

    // Tap the item
    await tester.tap(tappableFinder);
    await tester.pumpAndSettle();
  }

  // Future<void> tapMattressItem(String type, String location) async {
  //   await tester.pumpAndSettle();

  //   // Find all Rows that contain both the type and location texts
  //   final itemFinder = find.byWidgetPredicate(
  //     (widget) {
  //       if (widget is Row) {
  //         bool hasType = false;
  //         bool hasLocation = false;

  //         for (final child in widget.children) {
  //           if (child is Expanded) {
  //             if (child.child is Text) {
  //               final text = (child.child as Text).data ?? '';
  //               if (text == type && child.flex == 2) hasType = true;
  //               if (text == location && child.flex == 3) hasLocation = true;
  //             }
  //           }
  //         }
  //         return hasType && hasLocation;
  //       }
  //       return false;
  //     },
  //     description:
  //         'Mattress item row with type "$type" and location "$location"',
  //   );

  //   // Get the tappable Container ancestor
  //   final containerFinder = find.ancestor(
  //     of: itemFinder,
  //     matching: find.byWidgetPredicate(
  //       (widget) => widget is Container && widget.child is Column,
  //     ),
  //   );

  //   expect(containerFinder, findsOneWidget);
  //   await tester.tap(containerFinder);
  //   await tester.pumpAndSettle();
  // }

  /// Tap the "Edit" button within the dropdown
  Future<void> tapEditButton() async {
    final editButton = find.text('Edit'); // Find the Edit button by its label
    await tester.tap(editButton);
    await tester.pumpAndSettle();
  }

  /// Tap the "More" button within the dropdown
  Future<void> tapMoreButton() async {
    final moreButton = find.text('More'); // Find the More button by its label
    await tester.tap(moreButton);
    await tester.pumpAndSettle();
  }

  /// Verify that the dropdown contains the expected details
  Future<void> verifyDropdownDetails(
      String rotateDays, String lifecycleEndDate) async {
    final rotateDaysFinder = find.textContaining('Rotate: $rotateDays days');
    final lifecycleEndDateFinder =
        find.textContaining('End of Lifecycle: $lifecycleEndDate');

    expect(rotateDaysFinder, findsOneWidget);
    expect(lifecycleEndDateFinder, findsOneWidget);
  }

  /// Verify no mattresses are displayed
  Future<void> verifyNoMattressesDisplayed() async {
    final noMattressesText = find.text('No mattresses available');
    expect(noMattressesText, findsOneWidget);
  }

  Future<void> pressBackButton(WidgetTester tester) async {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
  }

  Future<void> tapOnX() async {
    var offset = Offset(374.1, 404.5);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> tapOnStatus() async {
    var offset = Offset(118.1, 629.7);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> tapOnInUse() async {
    var offset = Offset(40.0, 679.2);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> tapoffset(Offset of) async {
    await tester.tapAt(of);
    await tester.pumpAndSettle();
  }

  Future<void> tapOnCircle() async {
    tapoffset(Offset(54.5, 385.5));
  }

  // Future<void> tapOnTransferOut() async {
  //   tapoffset(Offset(222.1, 205.3));
  // }
  Future<void> tapOnTransferOut() async {
    final importButton = find.widgetWithIcon(
        ElevatedButton, Icons.import_contacts); // Find by icon
    await tester.tap(importButton);
    await tester.pumpAndSettle();
  }
}
