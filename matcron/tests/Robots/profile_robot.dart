import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ProfileRobot {
  final WidgetTester tester;

  ProfileRobot(this.tester);

  /// Enter text into a TextFormField
  Future<void> TapOnChangeLanguage() async {
    var offset = Offset(102.5, 836.9);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> ChooseDutch() async {
    var offset = Offset(118.1, 358.5);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> ChooseEnglish() async {
    var offset = Offset(172.9, 291.4);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> TapOnSttings() async {
    var offset = Offset(100.2, 760.7);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> ChangeTheme() async {
    var offset = Offset(358.5, 143.6);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }

  Future<void> tapOnHelp() async {
    var offset = Offset(54.5, 366.5);
    await tester.tapAt(offset);
    await tester.pumpAndSettle();
  }
}
