import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import '../tests/robots/login_robot.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer

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

  group('Login Page Tests', () {
    late LoginRobot loginRobot;

    testWidgets('Login with invalid credentials shows error', (tester) async {
      debugPrint('Starting test: Login with invalid credentials');

      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      debugPrint('Launching the app...');
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      debugPrint('App launched successfully.');

      // Enter invalid email and password
      debugPrint('Entering invalid email and password...');
      await loginRobot.enterEmail('invalid@example.com');
      await loginRobot.enterPassword('wrongpassword');
      debugPrint('Invalid email and password entered.');

      // Tap Sign In
      debugPrint('Tapping the Sign In button...');
      await loginRobot.tapSignInButton();
      debugPrint('Sign In button tapped.');

      // Verify error message
      try {
        debugPrint('Verifying error message...');
        await loginRobot.verifyErrorMessage('Invalid credentials');
        debugPrint('Error message verified successfully.');
      } catch (e) {
        debugPrint('Error during error message verification: $e');
        rethrow; // Re-throw the error to fail the test
      }
    });

    testWidgets('Login with valid credentials navigates to home page',
        (tester) async {
      debugPrint('Starting test: Login with valid credentials');

      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      debugPrint('Launching the app...');
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      debugPrint('App launched successfully.');

      // Enter valid email and password
      debugPrint('Entering valid email and password...');
      await loginRobot.enterEmail('matcron@gmail.com');
      await loginRobot.enterPassword('password');
      debugPrint('Valid email and password entered.');

      // Tap Sign In
      debugPrint('Tapping the Sign In button...');
      await loginRobot.tapSignInButton();
      debugPrint('Sign In button tapped.');

      // Verify navigation to the home page
      try {
        debugPrint('Verifying navigation to the dashboard page...');
        expect(find.text('Dashboard Page'), findsOneWidget);
        debugPrint('Navigation to the home page verified successfully.');
      } catch (e) {
        debugPrint('Error during home page navigation verification: $e');
        rethrow; // Re-throw the error to fail the test
      }
    });
  });
}
