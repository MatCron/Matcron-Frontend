import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AddMattressTypeRobot {
  final WidgetTester tester;

  AddMattressTypeRobot(this.tester);

  /// Enter text into a TextFormField
  Future<void> enterText(String label, String text) async {
    final field = find.byKey(Key(label));
    await tester.enterText(field, text);
    await tester.pumpAndSettle();
  }

  /// Select a value from a dropdown field
  Future<void> selectDropdownValue(String label, String value) async {
    final dropdown =
        find.widgetWithText(DropdownButtonFormField<String>, label);
    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    final dropdownItem = find.text(value).last;
    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();
  }

  /// Toggle a checkbox
  Future<void> toggleCheckbox(String label, bool value) async {
    final checkboxFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Row &&
          widget.children.any((child) {
            return child is Text && child.data == label;
          }),
    );
    final checkbox =
        find.descendant(of: checkboxFinder, matching: find.byType(Checkbox));
    final checkboxWidget = tester.widget<Checkbox>(checkbox);

    if (checkboxWidget.value != value) {
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
    }
  }

  /// Submit the form
  Future<void> tapSubmitButton() async {
    final submitButton = find.text("+Add Mattress Type");
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
  }

  /// Verify error message for a specific field
  Future<void> verifyErrorMessage(String errorMessage) async {
    final errorText = find.text(errorMessage);
    expect(errorText, findsOneWidget);
  }
}
