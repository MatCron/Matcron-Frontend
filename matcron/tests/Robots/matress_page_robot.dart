import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
class MattressPageRobot {
  final WidgetTester tester;

  MattressPageRobot(this.tester);

  

  Future<void> verifyLoadingState() async {
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  Future<void> verifyMattressesDisplayed(List<String> mattressTypes) async {
    for (final type in mattressTypes) {
      expect(find.text(type), findsWidgets);
    }
  }

  Future<void> searchFor(String query) async {
    final searchField = find.byType(TextField);
    await tester.enterText(searchField, query);
    await tester.pumpAndSettle();
  }

  Future<void> tapAddButton() async {
    final addButton = find.byType(ElevatedButton).last;
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  Future<void> verifyNoMattressesMessage() async {
    expect(find.text("No mattresses available"), findsOneWidget);
  }
}