// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer
import '../tests/Robots/main_navigation_robot.dart';
import '../tests/Robots/matress_page_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  try {
    debugPrint('Initializing dependencies...');
    await initializeDependencies();
    debugPrint('Dependencies initialized successfully.');
  } catch (e) {
    debugPrint('Error during dependency initialization: $e');
    return;
  }
  group('Matress Page test', () {
    testWidgets('Mattress Page Interaction Test', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Initialize the robot
      final robot = MattressPageRobot(tester);
      final mainNavigationRobot = MainNavigationRobot(tester);

      // navigate to Mattress Page
      await mainNavigationRobot.tapMattressItem();

      // Test searching for a mattress
      await robot.searchForMattress('string');
      await robot.verifyMattressInList('string');

      // Test adding a mattress
      await robot.tapAddMattressButton();
      // Verify navigation to Add Mattress Page
      expect(find.text('Generate RFID'), findsOneWidget);

      // Go back to Mattress Page
      await robot.pressBackButton(tester);

      await tester.pumpAndSettle();

      // // Test importing mattresses
      // await robot.tapImportMattressButton();
      // // Verify navigation to Import Mattress Page
      // expect(find.text('Import Mattress'), findsOneWidget);

      // Go back to Mattress Page
      // await tester.pageBack();
      // await tester.pumpAndSettle();

      // Test opening mattress dropdown details
      await robot.tapMattressItem('string', 'test124');
      await robot.verifyDropdownDetails('0', '20-01-2025');

      // Test editing mattress details
      await robot.tapEditButton();
      // Verify modal opens for editing
      expect(find.text('Edit'), findsOneWidget);

      // // Test More button
      // await robot.tapMoreButton();
      // Verify some action occurs, adjust as per app logic
    });
  });
}
