import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:travel_app/controller/RegisterController.dart';
import 'package:travel_app/Register/register.dart';
import 'register_controller_test.mocks.dart'; // Import generated mocks

@GenerateMocks([http.Client])
void main() {
  Get.testMode = true;
  late RegisterController registerController;
  late MockClient mockClient;

  setUp(() {
    Get.testMode = true;
    mockClient = MockClient(); // Mock http.Client
    registerController = Get.put(RegisterController(client: mockClient)); // Inject the mock client
  });

  tearDown(() {
    Get.delete<RegisterController>();
  });

  testWidgets('Register Page UI Test', (WidgetTester tester) async {
    // Mock the HTTP response with precise matchers
    when(mockClient.post(
      Uri.parse('http://51.120.4.43:8083/api/user/create'),
      headers: {'content-Type': 'application/json'},
      body: '{"email":"test@example.com","password":"password123","username":"TestUser"}',
    )).thenAnswer((_) async => http.Response('{"message": "Registration successful"}', 200));

    // Build the widget tree with ScreenUtilInit
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            home: RegisterPage(),
          );
        },
      ),
    );

    // Verify that the text fields for input are present
    expect(find.byType(TextField), findsNWidgets(3));

    // Enter test data into the fields
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(1), 'TestUser');
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.pump();

    // Tap on the "SIGN UP" button
    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle(); // Wait for all animations and UI updates

    // Verify if the success message snackbar appears
    expect(find.text('Your account has been successfully created'), findsOneWidget);

    // Ensure the loading state is false after completion
    expect(registerController.loading.value, false);
  }); // <-- Closing brace for the testWidgets block
} // <-- Closing brace for the main function
