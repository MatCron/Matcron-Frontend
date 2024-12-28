import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart'; // Replace with your actual main.dart import
import '../tests/Robots/login_robot.dart'; // Import the robot

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Page Tests', () {
    late LoginRobot loginRobot;

    testWidgets('Login with invalid credentials shows error', (tester) async {
      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Verify that the login page is displayed
      await loginRobot.verifyWelcomeText();

      // Enter invalid email and password
      await loginRobot.enterEmail('invalid@example.com');
      await loginRobot.enterPassword('wrongpassword');

      // Tap Sign In
      await loginRobot.tapSignInButton();

      // Verify error message
      await loginRobot.verifyErrorMessage('Invalid credentials');
    });

    testWidgets('Successful login navigates to home page', (tester) async {
      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Verify that the login page is displayed
      await loginRobot.verifyWelcomeText();

      // Enter valid email and password
      await loginRobot.enterEmail('user@example.com');
      await loginRobot.enterPassword('correctpassword');

      // Tap Sign In
      await loginRobot.tapSignInButton();

      // Verify navigation to the home page
      
    });

    testWidgets('Forgot password navigation', (tester) async {
      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Tap Forgot Password
      await loginRobot.tapForgotPassword();

      // Verify navigation to Forgot Password page
      expect(find.text('Forgot Password Page'), findsOneWidget);
    });

    testWidgets('Sign up navigation', (tester) async {
      // Initialize the robot with the tester
      loginRobot = LoginRobot(tester);

      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Tap Sign Up link
      await loginRobot.tapSignUpLink();

      // Verify navigation to Sign Up page
      
    });
  });
}
