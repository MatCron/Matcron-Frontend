import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart'; // Replace with your actual main.dart import
import '../tests/Robots/matress_type_robot.dart';
import '../tests/Robots/login_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('MattressTypePage Tests', () {
    late LoginRobot loginRobot;
    late MattressTypeRobot mattressRobot;

    testWidgets('Verify mattress types after login', (tester) async {
      // Initialize robots
      loginRobot = LoginRobot(tester);
      mattressRobot = MattressTypeRobot(tester);

      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Perform login
      await loginRobot.enterEmail('user@example.com');
      await loginRobot.enterPassword('correctpassword');
      await loginRobot.tapSignInButton();

      // Verify navigation to MattressTypePage
      await tester.pumpAndSettle();
      await mattressRobot.verifyRowCount(4); // Ensure mattress types are displayed
    });

    testWidgets('Search mattress types after login', (tester) async {
      // Initialize robots
      loginRobot = LoginRobot(tester);
      mattressRobot = MattressTypeRobot(tester);

      // Launch the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Perform login
      await loginRobot.enterEmail('user@example.com');
      await loginRobot.enterPassword('correctpassword');
      await loginRobot.tapSignInButton();

      // Verify navigation to MattressTypePage
      await tester.pumpAndSettle();

      // Search for a specific mattress type
      await mattressRobot.enterSearchQuery("Single");
      await mattressRobot.verifyRowCount(1);
    });
  });
}
