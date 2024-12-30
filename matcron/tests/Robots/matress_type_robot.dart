import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:matcron/core/resources/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:matcron/app/main.dart';

class MattressTypeRobot {
  final WidgetTester tester;

  MattressTypeRobot(this.tester);

  // Locators
  Finder get searchField => find.byType(TextField);
  Finder get addTypeButton => find.text('+ Add Type');
  Finder get typeTab => find.byWidgetPredicate((widget) => widget is BottomBarItem && widget.itemLabel=='Type',);
  Finder get editIcons => find.byIcon(Icons.edit);
  Finder get deleteIcons => find.byIcon(Icons.delete);
  Finder get typeFormButton => find.text('Type Form');
  
    

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

  Future<void> tapTypeFormButton() async {
    await tester.tap(typeFormButton);
    await tester.pumpAndSettle();
  } 

  // Assertions
  // Future<void> verifyRowCount(int expectedCount) async {
  //   expect(typeRows, findsNWidgets(expectedCount));
  // }

  Future<void> verifyTypePresent(String typeName) async {
    expect(find.text(typeName), findsOneWidget);
  }

  Future<void> verifyTypeNotPresent(String typeName) async {
    expect(find.text(typeName), findsNothing);
  }
  Future<void> tapOnType() async {
    await tester.tap(typeTab); // Tap on the "Type" tab
    await tester.pumpAndSettle();     // Wait for animations to complete
  }
}


