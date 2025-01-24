// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer
//import '../tests/Robots/main_navigation_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  try {
    debugPrint('Initializing dependencies...');
    await initializeDependencies();
    debugPrint('Dependencies initialized successfully.');
  } catch (e) {
    debugPrint('Error during dependency initialization: $e');
    return;
  }
  // group('MattressTypePage Tests', () {
  //   late LoginRobot loginRobot;

  //   testWidgets('Verify mattress types after login', (tester) async {
  //     // Initialize robots
  //     loginRobot = LoginRobot(tester);

  //     // Launch the app
  //     await tester.pumpWidget(MyApp());
  //     await tester.pumpAndSettle();

  //     // Perform login
  //     await loginRobot.enterEmail('matcron@gmail.com');
  //     await loginRobot.enterPassword('password');
  //     await loginRobot.tapSignInButton();

  //     // Verify navigation to MattressTypePage
  //     //await mattressRobot.tapOnType();

  //     await tester.pumpAndSettle();
  //     //await mattressRobot.verifyRowCount(4); // Ensure mattress types are displayed
  //   });
  // });

  testWidgets('Mattress Type Page integration test',
      (WidgetTester tester) async {
    // Launch the app
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Initialize the robot
    //final robot = MattressTypeRobot(tester);
    //final mainNavigationRobot = MainNavigationRobot(tester);

    // await mainNavigationRobot.tapTypesItem();

    // // Verify the initial list of mattress types
    // await robot.verifyMattressTypeInList('string');

    // // Test searching for a mattress type
    // await robot.searchMattressType('string');
    // await robot.verifyMattressTypeInList('string');

    // Test adding a new mattress type
  });
}
