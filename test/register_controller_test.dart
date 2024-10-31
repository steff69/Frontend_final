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
    mockClient = MockClient();
    registerController = Get.put(RegisterController(client: mockClient));
  });

  tearDown(() {
    Get.delete<RegisterController>();
  });

  testWidgets('Register Page UI Test', (WidgetTester tester) async {
    // Mock the HTTP response for successful registration
    when(mockClient.post(
      Uri.parse('http://51.120.4.43:8083/api/user/create'),
      headers: {'Content-Type': 'application/json'},
      body: '{"username":"TestUser","email":"test@example.com","password":"password123"}',
    )).thenAnswer((_) async => http.Response('{"message": "Registration successful"}', 200));

    // Build the RegisterPage widget
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

    // Enter test data into the fields following the correct order
    await tester.enterText(find.byType(TextField).at(0), 'TestUser'); // Username
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com'); // Email
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(2), 'password123'); // Password
    await tester.pumpAndSettle();

    // Tap the "SIGN UP" button
    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle();

    // Verify that the mock client received the POST request with the correct parameters
    verify(mockClient.post(
      Uri.parse('http://51.120.4.43:8083/api/user/create'),
      headers: {'Content-Type': 'application/json'},
      body: '{"username":"TestUser","email":"test@example.com","password":"password123"}',
    )).called(1);

    // Verify that the success snackbar is shown
    expect(find.text('Your account has been successfully created'), findsOneWidget);
  });
}
