import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import '../tests/robots/login_robot.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  try {
    print('Initializing dependencies...');
    await initializeDependencies();
    print('Dependencies initialized successfully.');
  } catch (e) {
    print('Error during dependency initialization: $e');
    return;
  }

  group('Login Page Tests', () {
    late LoginRobot loginRobot;

    testWidgets('Login with invalid credentials shows error', (tester) async {
      print('Starting test: Login with invalid credentials');

      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      print('Launching the app...');
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      print('App launched successfully.');

      // Enter invalid email and password
      print('Entering invalid email and password...');
      await loginRobot.enterEmail('invalid@example.com');
      await loginRobot.enterPassword('wrongpassword');
      print('Invalid email and password entered.');

      // Tap Sign In
      print('Tapping the Sign In button...');
      await loginRobot.tapSignInButton();
      print('Sign In button tapped.');

      // Verify error message
      try {
        print('Verifying error message...');
        await loginRobot.verifyErrorMessage('Invalid credentials');
        print('Error message verified successfully.');
      } catch (e) {
        print('Error during error message verification: $e');
        rethrow; // Re-throw the error to fail the test
      }
    });

    testWidgets('Login with valid credentials navigates to home page',
        (tester) async {
      print('Starting test: Login with valid credentials');

      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      print('Launching the app...');
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      print('App launched successfully.');

      // Enter valid email and password
      print('Entering valid email and password...');
      await loginRobot.enterEmail('matcron@gmail.com');
      await loginRobot.enterPassword('password');
      print('Valid email and password entered.');

      // Tap Sign In
      print('Tapping the Sign In button...');
      await loginRobot.tapSignInButton();
      print('Sign In button tapped.');

      // Verify navigation to the home page
      try {
        print('Verifying navigation to the dashboard page...');
        expect(find.text('Dashboard Page'), findsOneWidget);
        print('Navigation to the home page verified successfully.');
      } catch (e) {
        print('Error during home page navigation verification: $e');
        rethrow; // Re-throw the error to fail the test
      }
    });
  });
}
