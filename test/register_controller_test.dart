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
    // Set up the mocked HTTP response
    when(mockClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response('{"message": "Registration successful"}', 200));

    // Initialize ScreenUtil and build the widget tree
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

    // Verify that text fields exist
    expect(find.byType(TextField), findsNWidgets(3));

    // Enter email, name, and password
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(1), 'TestUser');
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.pump();

    // Tap on the "SIGN UP" button and wait for UI update
    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle();

    // Verify that the snackbar is shown with the success message
    expect(find.text('Your account has been successfully created'), findsOneWidget);

    // Ensure the loading state is false after the registration process
    expect(registerController.loading.value, false);
  });
}
