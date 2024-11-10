import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:travel_app/login/login.dart';
import 'package:travel_app/Register/register.dart';
import 'package:travel_app/controller/LoginController.dart';

void main() {
  setUp(() {
    Get.put(LoginController());
  });

  tearDown(() {
    Get.delete<LoginController>();
  });

  testWidgets('LoginPage displays elements and navigates correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(),
      ),
    );

    // Check if "Sign In" title is displayed
    expect(find.text("Sign In"), findsOneWidget);

    // Check if "Enter Email" field is displayed
    expect(find.byType(TextField).at(0), findsOneWidget);
    expect(find.widgetWithText(TextField, "Enter Email"), findsOneWidget);

    // Check if "Password" field is displayed
    expect(find.widgetWithText(TextField, "Password"), findsOneWidget);

    // Check if "L O G I N" button is displayed
    final loginButton = find.text("L O G I N");
    expect(loginButton, findsOneWidget);

    // Check if "Register" link is displayed
    final registerLink = find.text("Register");
    expect(registerLink, findsOneWidget);

    // Tap on the "Register" link and check navigation to RegisterPage
    await tester.tap(registerLink);
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage), findsOneWidget);

    // Go back to LoginPage for the next test
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Tap on the "L O G I N" button and verify the loading indicator appears
    await tester.tap(loginButton);
    await tester.pump(); // Start the loading indicator animation
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
