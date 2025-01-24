// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer
import 'Robots/type_robot.dart';
import '../tests/Robots/main_navigation_robot.dart';

import 'Robots/type_form_robot.dart';

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
  group('Mattress Type Flow Tests', () {
    testWidgets('Complete Mattress Type Flow', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Initialize the robot
      final addMattressRobot = AddMattressTypeRobot(tester);
      final mattressTypeRobot = MattressTypePageRobot(tester);
      final mainNavigationRobot = MainNavigationRobot(tester);
      await mainNavigationRobot.tapTypesItem();
      await tester.pumpAndSettle();

      // Step 1: Search for an existing mattress type
      // await mattressTypeRobot.searchForMattressType('Foam Mattress');
      // await mattressTypeRobot.verifyMattressTypeInList(
      //     'Foam Mattress', '(80 x 200 x 15)', '100');

      // Step 2: Add a new mattress type
      await mattressTypeRobot.tapAddTypeButton();
      // Verify navigation to Add Type page
      expect(find.text('Add Mattress Type'), findsOneWidget);

      // Fill out the form for a new mattress type
      await addMattressRobot.enterText("type_name", "Gel Foam");
      await addMattressRobot.enterText("width", "90");
      await addMattressRobot.enterText("length", "200");
      await addMattressRobot.enterText("height", "20");
      await addMattressRobot.enterText("material_composition", "Gel and Foam");
      await addMattressRobot.enterText("allergen_info", "No allergens");
      await addMattressRobot.selectDropdownValue("Life Span", "5 years");
      await addMattressRobot.enterText("recycle_info", "100% recyclable");
      await addMattressRobot.enterText("rotation_timer", "30");
      await addMattressRobot.selectDropdownValue("washable", "Yes");
      await addMattressRobot.tapSubmitButton();

      // Verify successful submission (mock or check UI behavior)
      expect(find.text("Mattress Type added successfully"), findsOneWidget);

      // Navigate back to the Mattress Type Page
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify the new mattress type is displayed in the list
      await mattressTypeRobot.verifyMattressTypeInList(
          'Gel Foam', '(90 x 200 x 20)', '50');

      // Step 3: Open bottom drawer for the newly added mattress type
      await mattressTypeRobot.openBottomDrawer('Gel Foam');
      await mattressTypeRobot.verifyBottomDrawerDisplayed();

      // Step 4: Edit the mattress type
      await mattressTypeRobot.tapEditButton('Gel Foam');
      // Verify navigation to edit form
      expect(find.text('Edit Mattress Type'), findsOneWidget);

      // Make edits in the form
      await addMattressRobot.enterText("Type Name", "Edited Gel Foam");
      await addMattressRobot.tapSubmitButton();
      await tester.pumpAndSettle();

      // Verify the updated mattress type in the list
      await mattressTypeRobot.verifyMattressTypeInList(
          'Edited Gel Foam', '(90 x 200 x 20)', '50');

      // Step 5: Delete the mattress type
      await mattressTypeRobot.tapDeleteButton('Edited Gel Foam');
      await mattressTypeRobot.confirmDeletion();
      await tester.pumpAndSettle();

      // Verify the mattress type is removed from the list
      expect(find.text('Edited Gel Foam'), findsNothing);
    });

    testWidgets('Validation for Add Mattress Type Form',
        (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      final addMattressRobot = AddMattressTypeRobot(tester);
      final mattressTypeRobot = MattressTypePageRobot(tester);
      final mainNavigationRobot = MainNavigationRobot(tester);
      await mainNavigationRobot.tapTypesItem();
      await tester.pumpAndSettle();

      // Navigate to Add Type form
      await mattressTypeRobot.tapAddTypeButton();
      expect(find.text('Add Mattress Type'), findsOneWidget);

      // Attempt to submit without filling in required fields
      await addMattressRobot.tapSubmitButton();

      // Verify error messages
      await addMattressRobot.verifyErrorMessage("Please enter a type name");
      await addMattressRobot.verifyErrorMessage("Please enter a valid width");

      // Fill in a required field and verify other errors persist
      await addMattressRobot.enterText("Type Name", "Foam Mattress");
      await addMattressRobot.tapSubmitButton();
      await addMattressRobot.verifyErrorMessage("Please enter a valid width");
    });
  });
}
