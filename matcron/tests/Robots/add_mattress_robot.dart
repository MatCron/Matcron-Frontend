import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:matcron/app/features/mattress/presentation/pages/assign_page.dart';

class AddMattressRobot {
  final WidgetTester tester;

  AddMattressRobot(this.tester);

  /// Enter location in the location text field
  Future<void> enterLocation(String location) async {
    final locationField = find
        .byKey(Key('locationFieldKey')); // Add a key to the location TextField
    await tester.enterText(locationField, location);
    await tester.pumpAndSettle();
  }

  /// Select a mattress type from the dropdown
  Future<void> selectMattressType(String mattressType) async {
    final dropdown = find.byKey(
        Key('mattressTypeDropdownKey')); // Add a key to the DropdownButton
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final typeOption = find.text(mattressType).last;
    await tester.tap(typeOption);
    await tester.pumpAndSettle();
  }

  /// Select a date from the date picker
  Future<void> selectDate(DateTime date) async {
    final dateField =
        find.byKey(Key('dateFieldKey')); // Add a key to the date TextField
    await tester.tap(dateField);
    await tester.pumpAndSettle();

    // Select the date in the date picker
    final datePicker = find.text('${date.day}').first;
    await tester.tap(datePicker);
    await tester.pumpAndSettle();

    // Confirm the date
    final okButton = find.text('OK');
    await tester.tap(okButton);
    await tester.pumpAndSettle();
  }

  /// Tap the "Generate RFID" button
  Future<void> tapGenerateRfid() async {
    final button =
        find.byKey(Key('generateRfidButtonKey')); // Add a key to the button
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  /// Verify a snack bar with a specific message is shown
  Future<void> verifySnackBarMessage(String message) async {
    expect(find.text(message), findsOneWidget);
  }

  /// Verify navigation to AssignPage
  Future<void> verifyNavigationToAssignPage() async {
    final assignPage = find.byType(AssignPage);
    expect(assignPage, findsOneWidget);
  }
}
