import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class OrganizationFormRobot {
  final WidgetTester tester;

  OrganizationFormRobot(this.tester);

  /// Enter text into a specific TextFormField
  Future<void> enterText(String labelText, String input) async {
    final textField = find.widgetWithText(TextFormField, labelText);
    await tester.enterText(textField, input);
    await tester.pumpAndSettle();
  }

  /// Select a value from a DropdownButtonFormField
  Future<void> selectDropdownValue(String labelText, String value) async {
    final dropdown =
        find.widgetWithText(DropdownButtonFormField<String>, labelText);
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownValue = find.text(value).last; // Find the dropdown item
    await tester.tap(dropdownValue);
    await tester.pumpAndSettle();
  }

  /// Toggle a checkbox
  Future<void> toggleCheckbox(String label, bool value) async {
    final checkboxFinder = find.byType(Checkbox).first;
    final checkboxState = tester.widget<Checkbox>(checkboxFinder).value;

    if (checkboxState != value) {
      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();
    }
  }

  /// Tap the "+Add Organisation" button
  Future<void> tapAddOrganizationButton() async {
    final button = find.text('+Add Organisation');
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  /// Verify a specific error message is displayed
  Future<void> verifyErrorMessage(String errorMessage) async {
    final errorFinder = find.text(errorMessage);
    expect(errorFinder, findsOneWidget);
  }

  /// Verify no error messages are displayed
  Future<void> verifyNoErrorMessages() async {
    final errorFinder = find.byType(Text).evaluate().where((element) {
      final widget = element.widget as Text;
      return widget.style?.color == const Color(0xFFD32F2F); // Error color
    });
    expect(errorFinder, isEmpty);
  }
}
