import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/controller/LoginController.dart';
import 'package:travel_app/pages/ProfilePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  // Initialize GetStorage to work without mocks
  await GetStorage.init();
  
  // Set up any data in GetStorage if needed
  final box = GetStorage();
  box.write("user", {"username": "Test User", "email": "testuser@example.com", "profile": ""});

  // Set up the controller and inject dependencies
  final loginController = Get.put(LoginController());
  loginController.miles.value = 1000;
  loginController.points.value = 500.0;

  testWidgets('ProfilePage displays user info and allows logout', (WidgetTester tester) async {
    // Wrap in GetMaterialApp with ScreenUtil initialization
    await tester.pumpWidget(
      GetMaterialApp(
        home: Builder(
          builder: (context) {
            ScreenUtil.init(context, designSize: Size(1080, 1920));
            return ProfilePage();
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Check that the profile title and user info are displayed
    expect(find.text("Profile"), findsOneWidget);
    expect(find.text("Test User"), findsOneWidget);
    expect(find.text("testuser@example.com"), findsOneWidget);
    expect(find.text('Qual Miles: 500.0'), findsOneWidget);
    expect(find.text('Prime Miles: 1000'), findsOneWidget);

    // Interact with the logout button and verify its action
    await tester.tap(find.text("Logout"));
    await tester.pumpAndSettle();

    // Verify logout logic by checking if user info is erased
    expect(box.read("user"), isNull);
  });
}
