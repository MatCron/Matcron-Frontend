import 'package:flutter_test/flutter_test.dart';

class MainNavigationRobot {
  final WidgetTester tester;

  MainNavigationRobot(this.tester);

  /// Tap the "Dashboard" item in the AnimatedNotchBottomBar
  Future<void> tapDashboardItem() async {
    final dashboardItem =
        find.text('Dashboard'); // Finds the Dashboard item by text
    await tester.tap(dashboardItem);
    await tester.pumpAndSettle(); // Wait for animations to finish
  }

  /// Tap the "Mattress" item in the AnimatedNotchBottomBar
  Future<void> tapMattressItem() async {
    final mattressItem =
        find.text('Mattress'); // Finds the Mattress item by text
    await tester.tap(mattressItem);
    await tester.pumpAndSettle();
  }

  /// Tap the "Types" item in the AnimatedNotchBottomBar
  Future<void> tapTypesItem() async {
    final typesItem = find.text('Type'); // Finds the Types item by text
    await tester.tap(typesItem);
    await tester.pumpAndSettle();
  }

  /// Tap the "Firm" item in the AnimatedNotchBottomBar
  Future<void> tapFirmItem() async {
    final firmItem = find.text('Firm'); // Finds the Firm item by text
    await tester.tap(firmItem);
    await tester.pumpAndSettle();
  }

  /// Verify the header title of the current page
  Future<void> verifyPageHeader(String expectedTitle) async {
    final header = find.text(expectedTitle); // Locate the header title
    expect(header, findsOneWidget);
  }
}
