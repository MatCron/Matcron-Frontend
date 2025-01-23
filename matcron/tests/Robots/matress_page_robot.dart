import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

  /// Tap the "Import Mattress" button
  Future<void> tapImportMattressButton() async {
    final importButton = find.widgetWithIcon(
        ElevatedButton, Icons.import_contacts); // Find by icon
    await tester.tap(importButton);
    await tester.pumpAndSettle();
  }

  /// Tap a mattress to open its dropdown details
  Future<void> tapMattressItem(String type, String location) async {
    final mattressItem = find.widgetWithText(ColoredBox, 'tesr123678');

    await tester.tap(mattressItem);
    await tester.pumpAndSettle();
  }

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
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
  }
}
