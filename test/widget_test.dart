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

  testWidgets('WelcomePage displays elements and navigates to MainScreen', (WidgetTester tester) async {
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

    // Additional checks on the MainScreen
    // Verify specific UI elements
    expect(find.text("Main Dashboard"), findsOneWidget); // Replace with actual element text
    expect(find.byIcon(Icons.settings), findsOneWidget); // Example icon check

    // Simulate user interactions on MainScreen
    final button = find.text("Explore"); // Replace with actual button text
    if (button.evaluate().isNotEmpty) {
      await tester.tap(button);
      await tester.pump(); // Trigger any changes due to interaction
    }

    // Verify state change or response after the interaction
    expect(find.text("Explore Page"), findsOneWidget); // Replace with the result of interaction
  });
}
