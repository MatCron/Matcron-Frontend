// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:get_it/get_it.dart';
// // import 'package:integration_test/integration_test.dart';
// // import 'package:matcron/app/main.dart'; // Replace with your actual main.dart import
// // import '../tests/Robots/login_robot.dart'; // Import the robot
// // import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:matcron/app/main.dart';
// import '../tests/robots/login_robot.dart';
// import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
// import 'package:matcron/app/injection_container.dart'; 

// // void main() {
// //   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
// //   // setupServiceLocator();

// void main() async {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   // Initialize dependencies
//   try {
    
//     await initializeDependencies();
//     print('Dependencies initialized successfully.');
//   } catch (e) {
//     print('Error during dependency initialization: $e');
//     return;
//   }
//   group('Login Page Tests', () {
//     late LoginRobot loginRobot;

//     testWidgets('Login with invalid credentials shows error', (tester) async {
//       // Initialize the robot with the tester
//       loginRobot = LoginRobot(tester);

//       // Launch the app
//       await tester.pumpWidget(MyApp());
//       await tester.pumpAndSettle();

//       // Verify that the login page is displayed
//       // await loginRobot.verifyWelcomeText();

//       // Enter invalid email and password
//       await loginRobot.enterEmail('invalid@example.com');
//       await loginRobot.enterPassword('wrongpassword');

//       // Tap Sign In
//       await loginRobot.tapSignInButton();

//       // Verify error message
//       // await loginRobot.verifyErrorMessage('Invalid credentials');
//     });

//     // testWidgets('Successful login navigates to home page', (tester) async {
//     //   // Initialize the robot with the tester
//     //   loginRobot = LoginRobot(tester);

//     //   // Launch the app
//     //   await tester.pumpWidget(MyApp());
//     //   await tester.pumpAndSettle();

//     //   // Verify that the login page is displayed
//     //   // await loginRobot.verifyWelcomeText();

//     //   // Enter valid email and password
//     //   await loginRobot.enterEmail('matcron@gmail.com');
//     //   await loginRobot.enterPassword('password');

//     //   // Tap Sign In
//     //   await loginRobot.tapSignInButton();

//     //   // Verify navigation to the home page
      
//     // });

//   //   testWidgets('Forgot password navigation', (tester) async {
//   //     // Initialize the robot with the tester
//   //     loginRobot = LoginRobot(tester);

//   //     // Launch the app
//   //     await tester.pumpWidget(MyApp());
//   //     await tester.pumpAndSettle();

//   //     // Tap Forgot Password
//   //     await loginRobot.tapForgotPassword();

//   //     // Verify navigation to Forgot Password page
//   //     expect(find.text('Forgot Password Page'), findsOneWidget);
//   //   });

//   //   testWidgets('Sign up navigation', (tester) async {
//   //     // Initialize the robot with the tester
//   //     loginRobot = LoginRobot(tester);

//   //     // Launch the app
//   //     await tester.pumpWidget(MyApp());
//   //     await tester.pumpAndSettle();

//   //     // Tap Sign Up link
//   //     await loginRobot.tapSignUpLink();

//   //     // Verify navigation to Sign Up page
      
//   //   });
//   });
// }





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
        throw e; // Re-throw the error to fail the test
      }
    });

    testWidgets('Login with valid credentials navigates to home page', (tester) async {
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
        throw e; // Re-throw the error to fail the test
      }
    });

  });
}


