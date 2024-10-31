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
    mockClient = MockClient(); // Create a mock http.Client
    registerController = Get.put(RegisterController(client: mockClient)); // Inject the mock client
  });

  tearDown(() {
    Get.delete<RegisterController>(); // Clean up the controller
  });

  testWidgets('Register Page UI Test', (WidgetTester tester) async {
    // Build the RegisterPage widget within the test environment
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

    // Mock HTTP response for successful registration
    when(mockClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response('{"message": "Registration successful"}', 200));

    // Check that the text fields are present
    expect(find.byType(TextField), findsNWidgets(3));

    // Enter email in the first TextField
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.pumpAndSettle();

    // Enter name in the second TextField
    await tester.enterText(find.byType(TextField).at(1), 'TestUser');
    await tester.pumpAndSettle();

    // Enter password in the third TextField
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.pumpAndSettle();

    // Tap the "SIGN UP" button
    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle();

    // Verify that the HTTP POST request was made with the correct parameters
    verify(mockClient.post(
      Uri.parse('http://51.120.4.43:8083/api/user/create'),
      headers: {'content-Type': 'application/json'},
      body: '{"email":"test@example.com","password":"password123","username":"TestUser"}',
    )).called(1);

    // Simulate the success response and check UI updates
    expect(registerController.loading.value, false);

    // Verify a success snackbar is shown
    expect(find.text('Your account has been successfully created'), findsOneWidget);
  });
}
