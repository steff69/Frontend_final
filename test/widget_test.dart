import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:travel_app/pages/welcome_page.dart';
import 'package:travel_app/pages/MainScreen.dart';
import 'package:travel_app/controller/testControl.dart'; // Ensure this path is correct

void main() {
  setUp(() {
    // Initialize the TetyController to ensure it's available during tests.
    Get.put(TetyController());
  });

  tearDown(() {
    // Remove the TetyController after each test to avoid conflicts.
    Get.delete<TetyController>();
  });

  testWidgets('WelcomePage displays elements and navigates to MainScreen with detailed checks', (WidgetTester tester) async {
    // Build the widget tree using GetMaterialApp to handle navigation.
    await tester.pumpWidget(
      GetMaterialApp(
        home: WelcomePage(),
      ),
    );

    // Verify that the page displays the correct welcome text.
    expect(find.text("Welcome to \nTunisair Mobile"), findsOneWidget);
    expect(
      find.text(
        "Your gateway to seamless travel and exclusive Fidelys benefits right at your fingertips.",
      ),
      findsOneWidget,
    );

    // Find the "Get Started" button.
    final getStartedButton = find.text("Get Started");
    expect(getStartedButton, findsOneWidget);

    // Tap the "Get Started" button and trigger a frame.
    await tester.tap(getStartedButton);
    await tester.pumpAndSettle(); // Wait for navigation to complete.

    // Verify that we navigated to the MainScreen.
    expect(find.byType(MainScreen), findsOneWidget);

    // Wait for asynchronous processes to complete in MainScreen.
    await tester.pumpAndSettle();

    // Additional verification for elements on the MainScreen.
    expect(find.text("Main Dashboard"), findsOneWidget); // Adjust text as needed.

    // Check for specific widgets or buttons.
    expect(find.byIcon(Icons.settings), findsOneWidget); // Example: check for a settings icon.
    expect(find.text("Explore"), findsOneWidget); // Example: check for a button labeled "Explore".

    // Simulate interaction with a button on MainScreen (if applicable).
    final exploreButton = find.text("Explore");
    if (exploreButton.evaluate().isNotEmpty) {
      await tester.tap(exploreButton);
      await tester.pumpAndSettle(); // Wait for any subsequent action or screen.
      expect(find.text("Explore Page"), findsOneWidget); // Verify next action or screen.
    }
  });
}
