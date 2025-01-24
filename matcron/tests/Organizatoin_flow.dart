// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer
import '../tests/Robots/main_navigation_robot.dart';
import '../tests/Robots/organization_form_robot.dart';
import '../tests/Robots/organization_robot.dart';

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

  group('Organization Form Tests', () {
    testWidgets('Organization Form Interaction Test',
        (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Initialize the robot
      final robot = OrganizationFormRobot(tester);
      final mainNavigationRobot = MainNavigationRobot(tester);
      final organizationPageRobot = OrganizationPageRobot(tester);

      await mainNavigationRobot.tapFirmItem();
      await organizationPageRobot.tapAddOrganizationButton();

      // Fill in the form fields
      await robot.enterText('Name', 'Tech Corp');
      await robot.enterText('E-Mail Address', 'techcorp@example.com');
      await robot.selectDropdownValue('Organisation', 'Hospital');
      await robot.enterText('Organisation Code.', 'ORG123');
      await robot.enterText('Address / Street', '123 Main St');
      await robot.enterText('EIR Code', 'A12BCD');
      await robot.enterText('County', 'Dublin');
      await robot.enterText(
          'Description (Max: 100 words)', 'A leading tech company');

      // Toggle the "Same as Postal Address" checkbox
      await robot.toggleCheckbox('Same as Postal Address', true);

      // Submit the form
      await robot.tapAddOrganizationButton();
      await tester.pageBack(); //
      await tester.pumpAndSettle();
      await organizationPageRobot.verifyOrganizationInList(
          'Tech Corp', 'Hospital');
    });

    testWidgets('Organization Form Validation Test',
        (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Initialize the robot
      final robot = OrganizationFormRobot(tester);
      final mainNavigationRobot = MainNavigationRobot(tester);
      final organizationPageRobot = OrganizationPageRobot(tester);

      await mainNavigationRobot.tapFirmItem();
      await organizationPageRobot.tapAddOrganizationButton();
      // Submit the form without filling in required fields
      await robot.tapAddOrganizationButton();

      // Verify error messages
      await robot.verifyErrorMessage('Please enter a name');
      await robot.verifyErrorMessage('Please enter an email address');
      await robot.verifyErrorMessage('Select Organisation');

      // Fill in one required field and verify the error clears
      await robot.enterText('Name', 'Tech Corp');
      await robot.tapAddOrganizationButton();
      await robot.verifyErrorMessage(
          'Please enter an email address'); // Email error remains
    });
  });

  group('Organization Page Tests', () {
    testWidgets('Organization Page Interaction Test',
        (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Initialize the robot
      final robot = OrganizationPageRobot(tester);
      final mainNavigationRobot = MainNavigationRobot(tester);

      await mainNavigationRobot.tapFirmItem();

      // Test searching for an organization
      await robot.searchForOrganization('Tech Corp');
      await robot.verifyOrganizationInList('Tech Corp', 'Hospital');

      // Test adding a new organization
      await robot.tapAddOrganizationButton();
      expect(
          find.text('Add Organization'), findsOneWidget); // Verify navigation
      await tester.pageBack(); // Navigate back
      await tester.pumpAndSettle();

      // Test editing an organization
      await robot.tapEditButton('Tech Corp');
      expect(
          find.text('Edit Organization'), findsOneWidget); // Verify edit modal

      // Test deleting an organization
      // await robot.tapDeleteButton('Tech Corp');
      // await robot.verifyConfirmationDialog();
      // await robot.confirmDeletion();
      // await robot.verifyNoOrganizationsDisplayed(); // Verify deletion

      // // Test canceling deletion
      // await robot.tapDeleteButton('Another Corp');
      // await robot.verifyConfirmationDialog();
      // await robot.cancelDeletion();
      // await robot.verifyOrganizationInList('Another Corp', 'Finance'); // Verify not deleted
    });
  });
}
