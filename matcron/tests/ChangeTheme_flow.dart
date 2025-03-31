// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matcron/config/theme/theme_cubit.dart';
import 'package:matcron/core/resources/language_provider.dart';
import 'package:matcron/main.dart';
import 'package:matcron/app/injection_container.dart'; // Import your dependency initializer
import 'package:provider/provider.dart';
import '../tests/Robots/main_navigation_robot.dart';
import '../tests/Robots/matress_page_robot.dart';
import 'Robots/profile_robot.dart';

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
  group('Matress Page test', () {
    testWidgets('Cannge language flow ', (WidgetTester tester) async {
      // Launch the app

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            BlocProvider(create: (context) => ThemeCubit()),
            ChangeNotifierProvider(
                create: (context) => LanguageProvider()..loadLanguage()),
          ],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Initialize the robot
      final robot = MattressPageRobot(tester);
      final mainNavigationRobot = MainNavigationRobot(tester);
      final profileRobot = ProfileRobot(tester);
      await mainNavigationRobot.pumpUntilFound(tester, find.text('Dashboard'));
      // navigate to Mattress Page
      await mainNavigationRobot.tapOnProfileIcon();
      await profileRobot.TapOnSttings();
      await profileRobot.ChangeTheme();
      await robot.pressBackButton(tester);
      await robot.pressBackButton(tester);

      await mainNavigationRobot.tapMattressItem();

      await mainNavigationRobot.tapOnProfileIcon();
      await profileRobot.TapOnSttings();
      await profileRobot.ChangeTheme();
      await robot.pressBackButton(tester);
      await robot.pressBackButton(tester);
      // // Test More button
      // await robot.tapMoreButton();
      // Verify some action occurs, adjust as per app logic
    });
  });
}
