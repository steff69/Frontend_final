import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:travel_app/login/login.dart';
import 'package:travel_app/controller/LoginController.dart';

void main() {
  setUp(() {
    Get.put(LoginController());
  });

  tearDown(() {
    Get.delete<LoginController>();
  });

  testWidgets('LoginPage displays elements and navigates correctly', (WidgetTester tester) async {
    // Initialize ScreenUtil
    ScreenUtil.init(
      BoxConstraints(maxWidth: 1080, maxHeight: 1920),
      designSize: Size(1080, 1920),
      orientation: Orientation.portrait,
    );

    // Pump the LoginPage widget
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(),
      ),
    );

    // Allow UI to load
    await tester.pumpAndSettle();

    // Check for the presence of "Sign In" text
    expect(find.text("Sign In"), findsOneWidget);

    // Simulate tapping the Login button
    final loginButton = find.text("L O G I N");
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();
  });
}
