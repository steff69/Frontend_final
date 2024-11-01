import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:travel_app/pages/welcome_page.dart';
import 'package:travel_app/pages/MainScreen.dart';
import 'package:travel_app/controller/testControl.dart';

// Set up necessary before running tests
void main() {
  setUp(() {
    Get.put(TetyController());
  });

  tearDown(() {
    Get.delete<TetyController>();
  });

  // Individual test cases

  // UI state test
  testWidgets('WelcomePage shows loading indicator', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: WelcomePage()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // Error handling test
  testWidgets('WelcomePage displays error message', (WidgetTester tester) async {
    Get.find<TetyController>().state = ControllerState.error;
    await tester.pumpWidget(GetMaterialApp(home: WelcomePage()));
    expect(find.text('An error occurred'), findsOneWidget);
  });

  // Interaction test
  testWidgets('Navigates to MainScreen on button tap', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: WelcomePage()));
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.byType(MainScreen), findsOneWidget);
  });

  // Performance test
  testWidgets('Performance test for WelcomePage', (WidgetTester tester) async {
    final binding = tester.binding;
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    await tester.pumpWidget(GetMaterialApp(home: WelcomePage()));
    expect(binding.hasScheduledFrame, isFalse);
  });

  // Accessibility test
  testWidgets('Check accessibility labels on WelcomePage', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: WelcomePage()));
    expect(find.bySemanticsLabel('Get Started Button'), findsOneWidget);
  });

  // Snapshot test
  testWidgets('Matches the baseline snapshot', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: WelcomePage()));
    await expectLater(
      find.byType(WelcomePage),
      matchesGoldenFile('goldens/welcome_page.png'),
    );
  });

  // Responsive test
  testWidgets('Responsive test for small screen', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(320, 640);
    await tester.pumpWidget(GetMaterialApp(home: WelcomePage()));
    expect(find.byType(WelcomePage), findsOneWidget);
    tester.binding.window.clearPhysicalSizeTestValue();
  });
}
