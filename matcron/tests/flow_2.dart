// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:matcron/app/main.dart'; // Replace with your actual main.dart import
// import '../tests/Robots/matress_type_robot.dart';
// import '../tests/Robots/login_robot.dart';
// import '../tests/Robots/mattress_type_form_robot.dart';
// import 'package:matcron/app/injection_container.dart';

// void main() async {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   try {
//     print('Initializing dependencies...');
//     await initializeDependencies();
//     print('Dependencies initialized successfully.');
//   } catch (e) {
//     print('Error during dependency initialization: $e');
//     return;
//   }

//   group('MattressTypePage Tests', () {
//     late LoginRobot loginRobot;
//     late MattressTypeRobot mattressRobot;
//     late AddMattressTypeFormRobot mattressTypeFormRobot;

//     testWidgets('Verify mattress types after login', (tester) async {
//       // Initialize robots
//       loginRobot = LoginRobot(tester);
//       mattressRobot = MattressTypeRobot(tester);

//       // Launch the app
//       await tester.pumpWidget(MyApp());
//       await tester.pumpAndSettle();

//       // Perform login
//       await loginRobot.enterEmail('matcron@gmail.com');
//       await loginRobot.enterPassword('password');
//       await loginRobot.tapSignInButton();

//       // Verify navigation to MattressTypePage
//       //await mattressRobot.tapOnType();

//       await tester.pumpAndSettle();
//       //await mattressRobot.verifyRowCount(4); // Ensure mattress types are displayed
//     });

//     testWidgets(
//         'Enter the navigate to matress type page and go to tyoe form  and enter values',
//         (tester) async {
//       // Initialize robots
//       loginRobot = LoginRobot(tester);
//       mattressRobot = MattressTypeRobot(tester);
//       mattressTypeFormRobot = AddMattressTypeFormRobot(tester);

//       // Launch the app
//       // await tester.pumpWidget(MyApp());
//       // await tester.pumpAndSettle();

//       // // Perform login
//       // await loginRobot.enterEmail('user@example.com');
//       // await loginRobot.enterPassword('correctpassword');
//       // await loginRobot.tapSignInButton();

//       // Verify navigation to MattressTypePage
//       // await tester.pumpAndSettle();

//       // Search for a specific mattress type
//       //await mattressRobot.tapOnType();
//       await mattressRobot.tapTypeFormButton();

//       await mattressTypeFormRobot.enterTypeName("Premium Memory Foam");
//       await mattressTypeFormRobot.enterDimensions("200", "150", "20");
//       await mattressTypeFormRobot
//           .enterMaterialComposition("Memory foam, cotton cover");
//       await mattressTypeFormRobot.enterAllergenInfo("Hypoallergenic materials");
//       await mattressTypeFormRobot.enterManufacturer("DreamCo");
//       await mattressTypeFormRobot.selectLifeSpan("10 years");
//       await mattressTypeFormRobot
//           .enterRecycleInfo("Eco-friendly recyclable materials");
//       await mattressTypeFormRobot.enterRotationTimer("6 months");
//       await mattressTypeFormRobot.selectWashable("Yes");
//       await mattressTypeFormRobot.submitForm();
//       //await mattressRobot.verifyRowCount(1);
//     });
//   });
// }
