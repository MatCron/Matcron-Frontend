import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MattressTypePageRobot {
  final WidgetTester tester;

  MattressTypePageRobot(this.tester);

  /// Search for a mattress type using the search bar
  Future<void> searchForMattressType(String query) async {
    final searchBar = find
        .byType(TextField)
        .first; // Assumes the search bar is the first TextField
    await tester.enterText(searchBar, query);
    await tester.pumpAndSettle(); // Wait for the UI to update
  }

  /// Verify the presence of a mattress type in the list
  Future<void> verifyMattressTypeInList(
      String name, String dimensions, String stock) async {
    final nameFinder = find.text(name);
    final dimensionsFinder = find.text(dimensions);
    final stockFinder = find.text(stock);

    expect(nameFinder, findsOneWidget);
    expect(dimensionsFinder, findsOneWidget);
    expect(stockFinder, findsOneWidget);
  }

  /// Tap the "+ Add Type" button
  Future<void> tapAddTypeButton() async {
    final addButton = find.text("+ Add Type");
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  /// Tap on a mattress type to open its bottom drawer
  Future<void> openBottomDrawer(String name) async {
    final typeFinder = find.text(name);
    await tester.tap(typeFinder);
    await tester.pumpAndSettle();
  }

  /// Verify the bottom drawer is displayed
  Future<void> verifyBottomDrawerDisplayed() async {
    final bottomDrawer = find.byType(BottomSheet);
    expect(bottomDrawer, findsOneWidget);
  }

  /// Tap the "Edit" button for a mattress type
  Future<void> tapEditButton(String name) async {
    final parentRow = find.ancestor(
      of: find.text(name),
      matching: find.byType(Row),
    );

    final editButton = find.descendant(
      of: parentRow,
      matching: find.byIcon(Icons.edit),
    );

    await tester.tap(editButton);
    await tester.pumpAndSettle();
  }

  /// Tap the "Delete" button for a mattress type
  Future<void> tapDeleteButton(String name) async {
    final parentRow = find.ancestor(
      of: find.text(name),
      matching: find.byType(Row),
    );

    final deleteButton = find.descendant(
      of: parentRow,
      matching: find.byIcon(Icons.delete),
    );

    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
  }

  /// Confirm the delete operation in the confirmation dialog
  Future<void> confirmDeletion() async {
    final confirmButton = find.text('Delete');
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();
  }

  /// Cancel the delete operation in the confirmation dialog
  Future<void> cancelDeletion() async {
    final cancelButton = find.text('Cancel');
    await tester.tap(cancelButton);
    await tester.pumpAndSettle();
  }
}
