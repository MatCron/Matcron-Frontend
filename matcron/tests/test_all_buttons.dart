import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer
import '../tests/Robots/main_navigation_robot.dart';

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
