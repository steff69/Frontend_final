import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:travel_app/controller/testControl.dart'; // Import TetyController
import 'package:travel_app/pages/welcome_page.dart'; // Import the WelcomePage

void main() {
  setUp(() {
    // Ensure the controller is registered before running tests
    Get.put(TetyController(), permanent: true);
  });

  testWidgets('WelcomePage displays elements and navigates on button tap', (WidgetTester tester) async {
    // Build the WelcomePage widget for testing
    await tester.pumpWidget(MaterialApp(
      home: WelcomePage(),
    ));

    // Add your test assertions and interactions here
    expect(find.text('Get Started'), findsOneWidget);

    // Simulate button tap and wait for navigation
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Additional assertions if needed
  });
}
