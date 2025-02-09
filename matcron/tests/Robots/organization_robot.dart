import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class OrganizationPageRobot {
  final WidgetTester tester;

  OrganizationPageRobot(this.tester);

  /// Search for an organization using the search bar
  Future<void> searchForOrganization(String query) async {
    final searchField =
        find.byType(TextField); // Search bar is likely a TextField
    await tester.enterText(searchField, query);
    await tester.pumpAndSettle(); // Wait for UI to update
  }

  /// Verify an organization is displayed in the list
  Future<void> verifyOrganizationInList(String name, String type) async {
    final nameFinder = find.text(name);
    final typeFinder = find.text(type);

    expect(nameFinder, findsOneWidget);
    expect(typeFinder, findsOneWidget);
  }

  /// Tap the "+ Add Organization" button
  Future<void> tapAddOrganizationButton() async {
    final addButton = find.text('+ Add Organization'); // Button text
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  /// Tap the "Edit" button for a specific organization
  Future<void> tapEditButton(String organizationName) async {
    final orgFinder = find.text(organizationName);
    final editButton = find.descendant(
      of: orgFinder,
      matching: find.byIcon(Icons.edit),
    );
    await tester.tap(editButton);
    await tester.pumpAndSettle();
  }

  /// Tap the "Delete" button for a specific organization
  Future<void> tapDeleteButton(String organizationName) async {
    final orgFinder = find.text(organizationName);
    final deleteButton = find.descendant(
      of: orgFinder,
      matching: find.byIcon(Icons.delete),
    );
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
  }

  /// Confirm deletion in the confirmation dialog
  Future<void> confirmDeletion() async {
    final confirmButton = find.text('Delete');
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();
  }

  /// Cancel deletion in the confirmation dialog
  Future<void> cancelDeletion() async {
    final cancelButton = find.text('Cancel');
    await tester.tap(cancelButton);
    await tester.pumpAndSettle();
  }

  /// Verify the confirmation dialog is shown
  Future<void> verifyConfirmationDialog() async {
    final dialogTitle = find.text('Delete Organization');
    expect(dialogTitle, findsOneWidget);
  }

  /// Verify no organizations are displayed
  Future<void> verifyNoOrganizationsDisplayed() async {
    final noOrganizationsText = find.text('No organizations available');
    expect(noOrganizationsText, findsOneWidget);
  }
}
