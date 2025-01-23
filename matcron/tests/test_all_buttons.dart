import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import '../tests/robots/login_robot.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer
import 'Robots/type_robot.dart';
import '../tests/Robots/main_navigation_robot.dart';
import '../tests/Robots/matress_page_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  try {
    print('Initializing dependencies...');
    await initializeDependencies();
    print('Dependencies initialized successfully.');
  } catch (e) {
    print('Error during dependency initialization: $e');
    return;
  }

  testWidgets('navigatoin intergratin test ', (WidgetTester tester) async {
    // Launch the app
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Initialize the robot

    final mainNavigationRobot = MainNavigationRobot(tester);

    await mainNavigationRobot.tapMattressItem();
    await mainNavigationRobot.tapTypesItem();
    await mainNavigationRobot.tapDashboardItem();
    await mainNavigationRobot.tapFirmItem();
  });
}
