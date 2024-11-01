import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/pages/welcome_page.dart.dart'; // Import the WelcomePage
import 'package:travel_app/pages/MainScreen.dart'; // Ensure MainScreen is correctly imported

void main() {
  testWidgets('WelcomePage displays correct elements', (WidgetTester tester) async {
    // Build the WelcomePage and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: WelcomePage()));

    // Check for the main welcome text.
    expect(find.text("Welcome to \nTunisair Mobile"), findsOneWidget);

    // Check for the subtitle text.
    expect(find.text("Your gateway to seamless travel and exclusive Fidelys benefits right at your fingertips."), findsOneWidget);

    // Check for the 'Get Started' button.
    expect(find.text("Get Started"), findsOneWidget);

    // Check if the 'Get Started' button works and navigates to MainScreen.
    await tester.tap(find.text("Get Started"));
    await tester.pumpAndSettle(); // Wait for the navigation animation to complete.

    // Verify if MainScreen is displayed (if you have a specific widget to check on MainScreen, use it here).
    expect(find.byType(MainScreen), findsOneWidget);
  });
}
