import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:travel_app/controller/RegisterController.dart';
import 'package:http/http.dart' as http;

import 'mocks.dart';

void main() {
  late RegisterController controller;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    controller = RegisterController(client: mockClient);
  });

  testWidgets('Register Page UI Test', (WidgetTester tester) async {
    // Mock the HTTP response
    when(mockClient.post(
      Uri.parse('http://51.120.4.43:8083/api/user/create'),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response('{"message": "Success"}', 200));

    // Run your test logic here and ensure expectations are met
    expect(controller.loading.value, false);

    controller.registerFunction('test data');
    await tester.pumpAndSettle();

    // Validate the UI response or state change
    expect(controller.loading.value, false);
  });
}
