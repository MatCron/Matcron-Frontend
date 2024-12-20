import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class MattressTypeRobot {
  final WidgetTester tester;

  MattressTypeRobot(this.tester);

  // Locators
  Finder get searchField => find.byType(TextField);
  Finder get addTypeButton => find.text('+ Add Type');
  Finder get typeRows => find.byType(Container).hitTestable();
  Finder get editIcons => find.byIcon(Icons.edit);
  Finder get deleteIcons => find.byIcon(Icons.delete);

  // Actions
  Future<void> enterSearchQuery(String query) async {
    await tester.enterText(searchField, query);
    await tester.pumpAndSettle();
  }

  Future<void> tapAddTypeButton() async {
    await tester.tap(addTypeButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapEditIcon(int index) async {
    final editIconFinder = editIcons.at(index);
    await tester.tap(editIconFinder);
    await tester.pumpAndSettle();
  }

  Future<void> tapDeleteIcon(int index) async {
    final deleteIconFinder = deleteIcons.at(index);
    await tester.tap(deleteIconFinder);
    await tester.pumpAndSettle();
  }

  // Assertions
  Future<void> verifyRowCount(int expectedCount) async {
    expect(typeRows, findsNWidgets(expectedCount));
  }

  Future<void> verifyTypePresent(String typeName) async {
    expect(find.text(typeName), findsOneWidget);
  }

  Future<void> verifyTypeNotPresent(String typeName) async {
    expect(find.text(typeName), findsNothing);
  }
}